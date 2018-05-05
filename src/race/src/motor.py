#!/usr/bin/env python
import rospy
import random as rand
import math
from sensor_msgs.msg import LaserScan
from std_msgs.msg import Int32
from race.msg import drive_param
from race.msg import pid_input
from race.msg import predict_vals

turn = None
accel = None
front = 45
side = 20

pub = rospy.Publisher('drive_parameters', drive_param, queue_size=1)
em_pub = rospy.Publisher('eStop', Int32, queue_size=10)

def accel_callback(pred_msg):
	global accel
	global turn
	accel = pred_msg.p_velocity
	turn = pred_msg.p_angle
	if accel != 0:
		em_pub.publish(2)
	velocity()

def front_callback(front_input):
	global front
	front = front_input
	velocity()

def side_callback(side_input):
	global side
	side = side_input

def getRange(data, theta):
	distance = data.ranges[theta]
	if math.isnan(distance):
		distance = 100
	return distance

def breaker(data):
	vel = -8
	distance = 2
	theta = 500

	for i in range(theta, 580, 2):
		distance = distance + getRange(data, i)

	distance = distance / 41

	msg = drive_param()
	msg.velocity = vel
	msg.angle = 0
	if distance <= 1:
		print("!!!!!!!!!!!!!!!!!BREAKING!!!!!!!!!!!!!!!!!")
		pub.publish(msg)
		em_pub.publish(1)

def velocity():
	global turn
	global accel
	global front
	global side
	msg = drive_param()
	ticks = rand.randint(1,11)
	
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
	velocity = 8
	if ticks > 5:
		velocity = -8

	print("Motor.py says: velocity= ", velocity, " and angle= ", angle)
	msg.velocity = velocity
	msg.angle = angle

	pub.publish(msg)



if __name__ == '__main__':
	print("Motor node started")
	rospy.init_node('motor', anonymous=True)
	rospy.Subscriber('predictions', predict_vals, accel_callback)
	rospy.Subscriber('scan',LaserScan, breaker)
	rospy.spin()
