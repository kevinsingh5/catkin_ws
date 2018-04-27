#!/usr/bin/env python
import sys
import rospy
import cv2

from std_msgs.msg import String, Bool, Int32
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError
from race.msg import obj_track

pub = rospy.Publisher("obj_tracking", obj_track, queue_size=10)

#PARAMS -- SET MAIN
timer = 0
locked = False

startDelay = 120
searchArea = (100, 100, 200, 200)
#searchArea2 = (200,200)
# 'BOOSTING', 'MIL', 'KCF', 'TLD', 'MEDIANFLOW', 'GOTURN'
tracker = cv2.TrackerKCF_create()	
widthDepthConverter = 1

input_image = None
depth_image = None

def image_callback(image):
	global input_image

	bridge = CvBridge()
	try:
		cv_image = bridge.imgmsg_to_cv2(image, "bgr8")
	except CvBridgeError as e:
		print(e)

	input_image = cv_image
	cv2.imshow("Image Test", input_image)
	cv2.waitKey(1)


def depth_callback(image):
	global depth_image
	global input_image

	bridge2 = CvBridge()
	try:
		cv_image2 = bridge2.imgmsg_to_cv2(image, desired_encoding="passthrough")
	except CvBridgeError as e:
		print(e)

	depth_image = cv_image2
	processor(input_image, depth_image)


def processor(input_image, depth_image):
	global timer
	global locked
	global startDelay, searchArea #searchArea2
	global tracker
	global widthDepthConverter
	ok = False
	dist = 0
	offset = 0

	if(input_image is None):
		return

	if(timer == 0):
		timer = cv2.getTickCount()


	if(not locked):    #at start, put bounding box in predefind location
		if(cv2.getTickCount() - timer <= startDelay):
		    cv2.rectangle(input_image, (100, 100), (200, 200), (255,0,0), 3, 8)
		else:
			#when enough time has passed, lock the tracker onto whatever is in the square
		    tracker.init(input_image, searchArea)  
		    cv2.rectangle(input_image, (100, 100), (200, 200), (0,255,0), 3, 8)
		    locked = True
	else:
		ok, box = tracker.update(input_image)	#attempt to track locked object
		if ok:                                
		    cv2.rectangle(input_image, (int(box[0]), int(box[1])), (int(box[2]), int(box[3])), (0,255,0), 3, 8)                                    
		    center = ( ((int(box[0]) + int(box[2])/2), (int(box[1]) + int(box[3])/2)) )
		    		    	#dist measured in units according to zed camera's output. 32f iirc. From center of tracked object
		    dist = depth_image[center[0], center[1]]                          
		    #offset of object center from center of image in pixels  
		    offset = center[0] - input_image.shape[1]/2                            
		    #convert offset to depth units, same as dist's
		    offset *= widthDepthConverter                                        
		else:
		    dist = 0
		    offset = 0

	#Note to predictor, if ok/"Object_Found" = false then dist and offset cannot be trusted!
	msg = obj_track()
	msg.obj_found = ok
	msg.dist = dist
	msg.offset = offset

	pub.publish(msg)


if __name__ == '__main__':
	print("Tracker node started")
	rospy.init_node('tracker', anonymous=True)
	rospy.Subscriber("rgb/image_rect_color", Image, image_callback)
	rospy.Subscriber("depth/depth_registered", Image, depth_callback)
	locked = False
	rospy.spin()