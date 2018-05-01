; Auto-generated. Do not edit!


(cl:in-package race-msg)


;//! \htmlinclude detect_values.msg.html

(cl:defclass <detect_values> (roslisp-msg-protocol:ros-message)
  ((distance
    :reader distance
    :initarg :distance
    :type cl:float
    :initform 0.0)
   (distance_theta
    :reader distance_theta
    :initarg :distance_theta
    :type cl:float
    :initform 0.0))
)

(cl:defclass detect_values (<detect_values>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <detect_values>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'detect_values)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name race-msg:<detect_values> is deprecated: use race-msg:detect_values instead.")))

(cl:ensure-generic-function 'distance-val :lambda-list '(m))
(cl:defmethod distance-val ((m <detect_values>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader race-msg:distance-val is deprecated.  Use race-msg:distance instead.")
  (distance m))

(cl:ensure-generic-function 'distance_theta-val :lambda-list '(m))
(cl:defmethod distance_theta-val ((m <detect_values>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader race-msg:distance_theta-val is deprecated.  Use race-msg:distance_theta instead.")
  (distance_theta m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <detect_values>) ostream)
  "Serializes a message object of type '<detect_values>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'distance_theta))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <detect_values>) istream)
  "Deserializes a message object of type '<detect_values>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'distance) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'distance_theta) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<detect_values>)))
  "Returns string type for a message object of type '<detect_values>"
  "race/detect_values")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'detect_values)))
  "Returns string type for a message object of type 'detect_values"
  "race/detect_values")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<detect_values>)))
  "Returns md5sum for a message object of type '<detect_values>"
  "401a8ab557bc852ae88e8fd2a8f16efc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'detect_values)))
  "Returns md5sum for a message object of type 'detect_values"
  "401a8ab557bc852ae88e8fd2a8f16efc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<detect_values>)))
  "Returns full string definition for message of type '<detect_values>"
  (cl:format cl:nil "float32 distance~%float32 distance_theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'detect_values)))
  "Returns full string definition for message of type 'detect_values"
  (cl:format cl:nil "float32 distance~%float32 distance_theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <detect_values>))
  (cl:+ 0
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <detect_values>))
  "Converts a ROS message object to a list"
  (cl:list 'detect_values
    (cl:cons ':distance (distance msg))
    (cl:cons ':distance_theta (distance_theta msg))
))
