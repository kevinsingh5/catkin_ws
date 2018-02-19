#include <ros/ros.h>
#include <image_transport/image_transport.h>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <cv_bridge/cv_bridge.h>
#include <ctime>

#include <iostream>
using namespace std;

//#define MEASURE_TIME 1
#define COLOR_TRACKING 1

#ifdef MEASURE_TIME
clock_t t_begin = 0;
#endif


void cv_process_img(const cv::Mat& input_img, cv::Mat& output_img)
{
	cv::Mat gray_img;
	cv::cvtColor(input_img, gray_img, CV_RGB2GRAY);

	double t1 = 20;
	double t2 = 50;
	int apertureSize = 3;

	cv::Canny(gray_img, output_img, t1, t2, apertureSize); 
}

void cv_publish_img(image_transport::Publisher &pub, cv::Mat& pub_img)
{
	//sensor_msgs::ImagePtr pub_msg = cv_bridge::CvImage(std_msgs::Header(), "bgr8", pub_img).toImageMsg();
	sensor_msgs::ImagePtr pub_msg = cv_bridge::CvImage(std_msgs::Header(), "mono8", pub_img).toImageMsg();
	pub.publish(pub_msg);
}



void cv_color_tracking(const cv::Mat& input_img)
{

	// purple

	int iLowH = 170;  
	int iHighH = 179;

	int iLowS = 150; 
	int iHighS = 255;

	int iLowV = 60;
	int iHighV = 255;



	cv::Mat imgLines = cv::Mat::zeros(input_img.size(), CV_8UC3);	// black img

	cv::Mat imgHSV;
	cv::cvtColor(input_img, imgHSV, CV_RGB2HSV);	//convert input image from RGB to HSV

	cv::Mat imgThresholded;
	cv::inRange(imgHSV, cv::Scalar(iLowH, iLowS, iLowV), cv::Scalar(iHighH, iHighS, iHighV), imgThresholded);	//Threshold the image
	//cv::inRange(imgHSV, cv::Scalar(16, 150, 60), cv::Scalar(38, 255, 255), imgThresholded);	//Threshold the image
	cv::Mat1b mask1, mask2;

	cv::inRange(imgHSV, cv::Scalar(0, 70, 50), cv::Scalar(10, 255, 255), mask1);		//Blue
	cv::inRange(imgHSV, cv::Scalar(170, 70, 50), cv::Scalar(180, 255, 255), mask2);	// Blue
	cv::Mat1b mask = mask1 | mask2;


	//morphological opening (removes small objects from the foreground)
	cv::erode(imgThresholded, imgThresholded, getStructuringElement(cv::MORPH_ELLIPSE, cv::Size(5, 5)) );
	cv::dilate(imgThresholded, imgThresholded, getStructuringElement(cv::MORPH_ELLIPSE, cv::Size(5, 5)) ); 

	//morphological closing (removes small holes from the foreground)
	cv::dilate( imgThresholded, imgThresholded, getStructuringElement(cv::MORPH_ELLIPSE, cv::Size(5, 5)) ); 
	cv::erode(imgThresholded, imgThresholded, getStructuringElement(cv::MORPH_ELLIPSE, cv::Size(5, 5)) );

	//morphological opening (removes small objects from the foreground)
	cv::erode(mask1, mask1, getStructuringElement(cv::MORPH_ELLIPSE, cv::Size(5, 5)) );
	cv::dilate(mask1, mask1, getStructuringElement(cv::MORPH_ELLIPSE, cv::Size(5, 5)) ); 

	//morphological closing (removes small holes from the foreground)
	cv::dilate( mask1, mask1, getStructuringElement(cv::MORPH_ELLIPSE, cv::Size(5, 5)) ); 
	cv::erode(mask1, mask1, getStructuringElement(cv::MORPH_ELLIPSE, cv::Size(5, 5)) );


	cv::imshow("color_tracking_input_image", input_img);
	cv::imshow("blue_tracking", mask); 
	cv::waitKey(1);
}

void imageCallback(const sensor_msgs::ImageConstPtr& msg, image_transport::Publisher &pub)
{


	cv_bridge::CvImageConstPtr cv_ori_img_ptr;
	try{
		cv::Mat cv_ori_img = cv_bridge::toCvShare(msg, "bgr8")->image;
		cv::Mat cv_output_img;

		cv_process_img(cv_ori_img, cv_output_img);

#ifdef COLOR_TRACKING
		cv_color_tracking(cv_ori_img);
#endif

		cv_publish_img(pub, cv_output_img);

#ifdef MEASURE_TIME
		clock_t t_end = clock();
		double delta_time= double(t_end - t_begin) / CLOCKS_PER_SEC;
		cout << "Delta_t = " << 1/delta_time << "\n";
		//t_begin = t_end;
#endif

		cv::imshow("view", cv_bridge::toCvShare(msg, "bgr8")->image);
		cv::imshow("view", cv_output_img);
		cv::waitKey(30);

#ifdef MEASURE_TIME
		t_begin = clock();
#endif
	}catch(cv_bridge::Exception& e){
		ROS_ERROR("Could not convert from '%s' to 'bgr8'.", msg->encoding.c_str());
	}


}



int main(int argc, char **argv)
{
	ros::init(argc, argv, "image_listener");

	ros::NodeHandle nh;

	//cv::namedWindow("view");
	//cv::startWindowThread();
	image_transport::ImageTransport it(nh);

	ros::NodeHandle nh_pub;
	image_transport::ImageTransport itpub(nh_pub);
	image_transport::Publisher pub = itpub.advertise("sample/cannyimg", 1);

#ifdef MEASURE_TIME
	t_begin = clock();
#endif

	image_transport::Subscriber sub = it.subscribe("rgb/image_rect_color", 1, boost::bind(imageCallback, _1, pub));
	ros::spin();
	//cv::destroyWindow("view");

}
