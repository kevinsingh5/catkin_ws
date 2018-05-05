#!/usr/bin/env python


import rospy
from sensor_msg.msg import LaserScan
from race.msg import drive_param
from race.msg import pid_input
from race.msg import predict_vals

pub = rospy.Publisher('drive_parameters', drive_param, queue_size=1)

def callback():
	msg = drive_param()

	msg.velocity = 10
	msg.angle = 0
	pub.publish(msg)

if __name__ == '__main__':
	print("Dummy drive node started")
	rospy.init.node('dummy_driver', anonymous=True)
	rospy.Subscriber("scan", LaserScan, callback)
	rospy.spin()