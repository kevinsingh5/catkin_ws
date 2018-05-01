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

startDelay = 5000000
searchArea = (200, 200, 200, 200)
#searchArea2 = (200,200)
# 'BOOSTING', 'MIL', 'KCF', 'TLD', 'MEDIANFLOW', 'GOTURN'
tracker = cv2.TrackerMIL_create()
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

def depth_callback(image):
	global depth_image
	global input_image

	bridge2 = CvBridge()
	try:
		cv_image2 = bridge2.imgmsg_to_cv2(image, desired_encoding="passthrough")
	except CvBridgeError as e:
		print(e)

	depth_image = cv_image2
	processor()


def processor():
	global timer
	global locked
	global startDelay, searchArea #searchArea2
	global tracker
	global widthDepthConverter
	global input_image
	global depth_image
	ok = False
	dist = 0
	offset = 0

	if(input_image is None):
		return

	if(timer == 0):
		timer = cv2.getTickCount()

	c = cv2.waitKey(1)
	if(not locked):    #at start, put bounding box in predefind location
		print("Tracker.py says: NOT LOCKED")
		cv2.imshow("Tracking_img",input_image)
		if('q' != chr(c & 255)):
		    cv2.rectangle(input_image, (200, 200), (400, 400), (255,0,0), 3, 8)
		else:
			#when enough time has passed, lock the tracker onto whatever is in the square
		    tracker.init(input_image, searchArea)  
		    cv2.rectangle(input_image, (200, 200), (400, 400), (0,255,0), 3, 8)
		    locked = True
	else:
		print("Tracker.py says: LOCKED ON")
		ok, box = tracker.update(input_image)	#attempt to track locked object
		if ok:
		    p1 = (int(box[0]), int(box[1]))
		    p2 = (int(box[0] + box[2]), int(box[1] + box[3]))                                
		    cv2.rectangle(input_image, p1, p2, (0,255,0), 3, 8)                                    
		    center =  ((int(box[0]) + int(box[2])/2), (int(box[1]) + int(box[3])/2)) 
		    		    	#dist measured in units according to zed camera's output. 32f iirc. From center of tracked object
		    print("Trakcer box: ", box)
		    print("Center: ", center)
		    h1, w1, ch1 = input_image.shape
		    h2, w2 = depth_image.shape
		    offset = center[0] - w1/2
		    print("Tracker says w1= ", w1, "center[0]= ", center[0])
		    center = (center[0] * w2 / w1, center[1] * h2 / h1)		    
		    #dist = depth_image[center[0], center[1]]
		    dist = 10                                              
		else:
		    dist = 0
		    offset = 0

	#Note to predictor, if ok/"Object_Found" = false then dist and offset cannot be trusted!
	print("Tracker.py says: dist= ", dist, " and offset= ", offset)
	msg = obj_track()
	msg.obj_found = ok
	msg.dist = dist
	msg.offset = offset

	pub.publish(msg)

	#cv2.imshow("Tracking Image", input_image)
	c = cv2.waitKey(1)


if __name__ == '__main__':
	print("Tracker node started")
	rospy.init_node('tracker', anonymous=True)
	rospy.Subscriber("rgb/image_rect_color", Image, image_callback)
	rospy.Subscriber("depth/depth_registered", Image, depth_callback)
	locked = False
	rospy.spin()
