#!/usr/bin/env python
import rospy
from race.msg import drive_param
from race.msg import pid_input
from race.msg import obj_track
from race.msg import predict_vals
 

#publishes 'accelerate' and 'turn'
#subscribes to 'obj_tracking'

vel_input = 15.0
buff = []

pub = rospy.Publisher('predictions', predict_vals, queue_size=10)


def callback(obj_msg):
	global vel_input
	global buff
	angle = 0
	velocity = 0

	found = obj_msg.obj_found	# get obj_found BOOL from obj_msg
	lateral = obj_msg.offset 	# get offset FLOAT32 from obj_msg
	frontal = obj_msg.dist 		# get dist FLOAT32 from obj_msg

	# buffer list stores last known accurate lateral values 

	if found:
		if len(buff) > 25:
			del buff[0]
		buff.append(lateral)
		velocity = vel_input * (frontal/10)

	#if lateral == 0:		# object is in center
	#		angle = 0
	#	elif lateral > 0:		# object is to the right
	#		angle = lateral/7
	#	elif lateral < 0:		# object is to the left
	#		angle = lateral/(-7)
		angle = lateral/7

	else: 	# not found
		if len(buff) > 0:
			lateral = buff.pop()
		velocity = vel_input * (frontal/10)
		
		angle = lateral/7
		
	#msg.angle = angle
	print("Predictor.py says: Velocity= ", velocity, " and angle= ", angle)
	msg = predict_vals()
	msg.p_velocity = velocity
	msg.p_angle = angle
	pub.publish(msg)


if __name__ == '__main__':
	print("Predictor node started")
	rospy.init_node('predictor', anonymous=True)
	#rospy.Subscriber('error', pid_input, control) 	#need error subscription??
	rospy.Subscriber('obj_tracking', obj_track, callback)	#obj_position (no Vector2)
	rospy.spin()

# TODO:
# X if found is False then lateral = 0 doesn't mean center, it means it's lost
# X if found is True, then lateral = 0 means the object is dead center
# X based on msg.distance, increase/decrease velocity accordingly
# X implement a list of last known offset/distance values for when object is lost
# X when boolean is False, fetch values from memory list to pass on to controllers

# NOTES:
# fix clock skew: find . -exec touch {} +
