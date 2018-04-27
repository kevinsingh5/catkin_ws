#!/usr/bin/env python
import rospy
from race.msg import drive_param
from race.msg import pid_input

from std_msgs.msg import Bool, Float32

turn = None
accel = None
front = None
side = None

pub = rospy.Publisher('drive_parameters', drive_param, queue_size=1)


def accel_callback(accel_input):
	global accel
	accel = vel_input

def turn_callback(turn_input):
	global turn
	turn = turn_input

def front_callback(front_input):
	global front
	front = front_input
	velocity()

def side_callback(side_input):
	global side
	side = side_input


def velocity():
	global turn
	global accel
	global front
	global side
	msg = drive_param()
	
	angle = 0
	velocity = 0

	if(turn > 0 and side > 0 and side < 25):
		angle = 100
	elif(turn < 0 and side < 0 and side > -25):
		angle = -100
	else: 
		angle = 0

	if(accel > 0 and front > 40):
		velocity = 15
	elif(accel <= 0 and front > 40):
		velocity = 0
	elif(accel > 0 and front < 25):
		velocity = 5
	else:
		velocity = 0

	msg.velocity = velocity
	msg.angle = angle

	pub.publish(msg)



if __name__ == '__main__':
	print("Motor node started")
	rospy.init_node('motor', anonymous=True)
	rospy.Subscriber('accelerate', Float32, accel_callback)
	rospy.Subscriber('turn', Float32, turn_callback)
	rospy.Subscriber('front_wall', Float32, front_callback)
	rospy.Subscriber('side_wall', Float32, side_callback)
	rospy.spin()
