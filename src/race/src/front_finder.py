#!/usr/bin/env python

import rospy
import math
from sensor_msgs.msg import LaserScan
from race.msg import pid_input
from race.msg import drive_param
from std_msgs.msg import Int32

vel = 10

pub = rospy.Publisher('drive_parameters', drive_param, queue_size=10)
em_pub = rospy.Publisher('eStop', Int32, queue_size=10)

def getRange(data, theta):
	distance = data.ranges[theta]
	if math.isnan(distance):
		distance = 100
	return distance

def callback(data):
	global vel

	distance = 100.0
	theta = 540

	distance = getRange(data, theta)
	print("Front_finder says: FRONT DISTANCE IS: ", distance)
	print("Lidar values size: ", len(data.ranges))

	msg = drive_param()
	msg.velocity = vel
	msg.angle = 0
	if distance <= 1.5:
		msg.velocity = 0
		em_pub.publish(1)

	pub.publish(msg)

if __name__ == '__main__':
	print("Front detection node started")
	rospy.init_node('front_finder', anonymous=True)
	rospy.Subscriber("scan", LaserScan, callback)
	rospy.spin()
