#include <ros/ros.h>
#include <image_transport/image_transport.h>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <cv_bridge/cv_bridge.h>
#include <ctime>
#include <string>
#include <iostream>
#include <sstream>
#include <cmath>

#include <iostream>
using namespace std;
using namespace cv;

//#define MEASURE_TIME 1
#define COLOR_TRACKING 1

#ifdef MEASURE_TIME
clock_t t_begin = 0;
#endif
static double dist;

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

	cv::inRange(imgHSV, cv::Scalar(100, 200, 50), cv::Scalar(110, 255, 255), mask1);		//Blue
	cv::inRange(imgHSV, cv::Scalar(110, 200, 50), cv::Scalar(120, 255, 255), mask2);	// Blue
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

	//START findContours function

	vector<vector<cv::Point> > contours;

	cv::findContours(mask, contours, cv::RETR_EXTERNAL, cv::CHAIN_APPROX_SIMPLE, cv::Point(0, 0));
	
	cv::Mat dst = cv::Mat::zeros(mask.size(), CV_8UC1);

	for(int i = 0; i < contours.size(); i++){
		cv::Scalar color = cv::Scalar((rand()&200, rand()&125, rand()&200));
		cv::drawContours(dst, contours, i, color, 2, 8, NULL, 0, cv::Point()); // cv::FILLED, 8, cv::Point(0, 0));
	}


	// START Hough Circle Transformation
	//cv::Mat(CV_8UC1)
	cv::Mat gray;
	cv::Mat white = cv::Mat(mask.size(), CV_8UC1);
	white = cv::Scalar(255);
	//input_img.copyTo(gray, mask);
	white.copyTo(gray, mask);
	
	//morphological opening (removes small objects from the foreground)
	cv::erode(gray, gray, getStructuringElement(cv::MORPH_ELLIPSE, cv::Size(3, 3)) );
	cv::dilate(gray, gray, getStructuringElement(cv::MORPH_ELLIPSE, cv::Size(3, 3)) ); 

	//morphological closing (removes small holes from the foreground)
	cv::dilate(gray, gray, getStructuringElement(cv::MORPH_ELLIPSE, cv::Size(3, 3)) ); 
	cv::erode(gray, gray, getStructuringElement(cv::MORPH_ELLIPSE, cv::Size(3, 3)) );

	//cv::cvtColor(gray, gray, COLOR_BGR2GRAY);
	cv::medianBlur(gray, gray, 15);
	//cv::medianBlur(dst, dst, 5);

	vector<cv::Vec3f> circles;
	cv::HoughCircles(gray, circles, cv::HOUGH_GRADIENT, 1, 
		200,	// detect circles with different distances to each other
		50, 18, 30, input_img.cols/2		// change the last two parameters
			// (min_radius & max_radius)
	);

	vector<Point> data;
	for(int i = 0; i < circles.size(); i++) {
		cv::Vec3i c = circles[i];
		cv::Point center = cv::Point(c[0], c[1]);
		//circle center
		//cv::circle(input_img, center, 1, Scalar(0,100,100), 3, FILLED);
		// center point
		cv::line(input_img, Point(center.x+10, center.y-10), Point(center.x-10, center.y+10), Scalar(0,200,0), 2, 8);
		cv::line(input_img, Point(center.x-10, center.y-10), Point(center.x+10, center.y+10), Scalar(0,200,0), 2, 8);

		//circle outline
		int radius = c[2];
		//:cv::circle(input_img, center, radius, Scalar(0, 255, 0), 3, FILLED);
		data.push_back(Point(center.x - radius, center.y + radius));
		data.push_back(Point(center.x + radius, center.y - radius));
		cv::rectangle(input_img, data[0], data[1], Scalar(0, 255, 0), 3, 8);
		//printf("CIRCLESSSS index: %d, size: %d\n", circles[0], circles.size());
	}

	int circleX;
	double f = 590;
	double w = 7;
	double xscalar;
	double xx;
	double yy;
	double theta;
	bool   invert;
	if(circles.size() > 0){
		cv::Vec3i center_circle = circles[0];
		circleX = center_circle[0];
		double rad = center_circle[2];

		dist = 0.2*dist + (0.8*(f*w)/(2*rad));
		std::stringstream ss;
		ss << dist;

		std::string str;
		ss >> str;
		cv::putText(input_img, str, Point(0,30), cv::FONT_HERSHEY_SIMPLEX, 1, Scalar(0,255,0));
	
		xscalar = 7/(rad*2);
		xx = xscalar * ((double)circleX - (input_img.cols/2));
		if(xx < 0){
			invert = -1;
		}
		else{
			invert = 1;
		}
		yy = dist;
		theta = tan(abs(xx)/yy) * invert;

		std::stringstream sss;
		sss << theta;
		std::string check;
		sss >> check;

		std::stringstream ssss;
		ssss << xx;
		std::string ourx;
		ssss >> ourx;

		cv::putText(input_img, check, Point(75,75), cv::FONT_HERSHEY_SIMPLEX, 1, Scalar(0,255,0));
		cv::putText(input_img, ourx, Point(125,125), cv::FONT_HERSHEY_SIMPLEX, 1, Scalar(0,255,0));
	}




	//cv::imshow("color_tracking_input_image", input_img);
	//cv::imshow("grayed_image", gray);
	//cv::imshow("red_tracking", mask); 
	cv::imshow("circle_detection", input_img);
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

		//cv::imshow("view", cv_bridge::toCvShare(msg, "bgr8")->image);
		//cv::imshow("view", cv_output_img);
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
