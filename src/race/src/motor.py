#!/usr/bin/env python
import rospy
from race.msg import drive_param
from race.msg import pid_input
from race.msg import predict_vals

turn = None
accel = None
front = 45
side = 20

pub = rospy.Publisher('drive_parameters', drive_param, queue_size=1)


def accel_callback(pred_msg):
	global accel
	global turn
	accel = pred_msg.p_velocity
	turn = pred_msg.p_angle
	velocity()

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
	velocity = 10
	hard_velocity = 10

	if(turn > 0 and side > 0 and side < 25):
		angle = 100
	elif(turn < 0 and side < 0 and side > -25):
		angle = -100
	else: 
		angle = 0

	if(accel > 0 and front > 40):
		velocity = 5
	elif(accel <= 0 and front > 40):
		velocity = 0
	elif(accel > 0 and front < 25):
		velocity = 5
	else:
		velocity = 0
	
	angle = turn
	velocity = 10

	print("Motor.py says: velocity= ", velocity, " and angle= ", angle)
	msg.velocity = velocity
	msg.angle = angle

	pub.publish(msg)



if __name__ == '__main__':
	print("Motor node started")
	rospy.init_node('motor', anonymous=True)
	rospy.Subscriber('predictions', predict_vals, accel_callback)
	rospy.spin()
