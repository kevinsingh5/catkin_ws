import rospy
import math
from sesor_msg.msg import LaserScan
from race.msg import pid_input
from race.msg import detect_values
from race.msg import drive_param
from std_msgs.msg import Int32

vel = 15 # velocity

pub = rospy.Publisher('wall_detection', detect_values, queue_size=10)
pub2 = rospy.Publisher('drive_parameters', drive_param, queue_size=10)
em_pub = rospy.Publisher('eStop', Int32, queue_size=10)

def getRange(data, theta):			# grab sensor data for the given theta value
	distance = data.ranges[theta]
	if math.isnan(distance):
		distance = 100
	return distance

def callback(data):
	distance = 100.0
	theta = -137.0
	min_theta = 0.0
	for i in range(0, data.ranges.size(), 50): # loop will be more accurate once I know size of 'ranges'
		if(data.ranges[i] <= distance):
			distance = data.ranges[i]
			min_theta = theta
		theta += 50*(math.degrees(data.angle_increment))


	print(data.ranges[180])
	msg = detect_values()
	msg.distance = distance
	msg.distance_theta = min_theta

	msg2 = drive_param()
	if(distance < 1):
		msg2.velocity = 0
		msg2.angle = 0
		em_pub.publish(0)

	msg2.velocity = 10
	msg2.angle = 0
	pub.publish(msg)
	pub2.publish(msg2)

if __name__ == '__main__':
	print("Side detection node started")
	rospy.init.node('side_dist_finder', anonymous=True)
	rospy.Subscriber("scan", LaserScan, callback)
	rospy.spin()
