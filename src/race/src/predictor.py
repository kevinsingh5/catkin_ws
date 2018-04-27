#!/usr/bin/env python
import rospy
from race.msg import drive_param
from race.msg import pid_input
from race.msg import obj_track

from std_msgs.msg import Int32, Float32
from std_msgs.msg import Bool 

#publishes 'accelerate', 'turn_left' and 'turn_right'
#subscribes to 'obj_found' and 'obj_position'

vel_input = 15.0

pub = rospy.Publisher('accelerate', Float32, queue_size=10)
pub2 = rospy.Publisher('turn', Float32, queue_size=10)


def callback(obj_msg):
	global vel_input
	angle = 0
	velocity = 0

	if obj_msg.obj_found:
		velocity = vel_input
	else:
		velocity = -10

	if obj_msg.offset > 0:		# obj is to the right
		angle = obj_msg.offset/2
	elif position <= 0:		# obj is to the left
		angle = obj_msg.offest/(-2)

		# take into account obj_msg.dist to calcualte the velocity
	
	#msg.angle = angle
	pub.publish(angle)
	pub2.publish(velocity)


if __name__ == '__main__':
	print("Predictor node started")
	rospy.init_node('predictor', anonymous=True)
	#rospy.Subscriber('error', pid_input, control) 	#need error subscription??
	rospy.Subscriber('obj_tracking', obj_track, callback)	#obj_position (no Vector2)
	rospy.spin()
