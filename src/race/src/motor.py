#!/usr/bin/env python
import rospy
from race.msg import drive_param
from race.msg import pid_input

from std_msgs.msg import Float32
from std_msgs.msg import Bool 

#subscribes to 'accelerate'

pub = rospy.Publisher('drive_parameters', drive_param, queue_size=1)


def callback(accel):
	msg = drive_param()
	msg.velocity = accel
	pub.publish(msg)	


if __name__ == '__main__':
	print("Motor node started")
	rospy.init_node('motor', anonymous=True)
	rospy.Subscriber('accelerate', Float32, callback)
	rospy.spin()
