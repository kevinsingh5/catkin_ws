; Auto-generated. Do not edit!


(cl:in-package race-msg)


;//! \htmlinclude predict_vals.msg.html

(cl:defclass <predict_vals> (roslisp-msg-protocol:ros-message)
  ((p_velocity
    :reader p_velocity
    :initarg :p_velocity
    :type cl:float
    :initform 0.0)
   (p_angle
    :reader p_angle
    :initarg :p_angle
    :type cl:float
    :initform 0.0))
)

(cl:defclass predict_vals (<predict_vals>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <predict_vals>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'predict_vals)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name race-msg:<predict_vals> is deprecated: use race-msg:predict_vals instead.")))

(cl:ensure-generic-function 'p_velocity-val :lambda-list '(m))
(cl:defmethod p_velocity-val ((m <predict_vals>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader race-msg:p_velocity-val is deprecated.  Use race-msg:p_velocity instead.")
  (p_velocity m))

(cl:ensure-generic-function 'p_angle-val :lambda-list '(m))
(cl:defmethod p_angle-val ((m <predict_vals>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader race-msg:p_angle-val is deprecated.  Use race-msg:p_angle instead.")
  (p_angle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <predict_vals>) ostream)
  "Serializes a message object of type '<predict_vals>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'p_velocity))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'p_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <predict_vals>) istream)
  "Deserializes a message object of type '<predict_vals>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'p_velocity) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'p_angle) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<predict_vals>)))
  "Returns string type for a message object of type '<predict_vals>"
  "race/predict_vals")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'predict_vals)))
  "Returns string type for a message object of type 'predict_vals"
  "race/predict_vals")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<predict_vals>)))
  "Returns md5sum for a message object of type '<predict_vals>"
  "09486aac4bab37b0c67d7c81bbe7acf8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'predict_vals)))
  "Returns md5sum for a message object of type 'predict_vals"
  "09486aac4bab37b0c67d7c81bbe7acf8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<predict_vals>)))
  "Returns full string definition for message of type '<predict_vals>"
  (cl:format cl:nil "float32 p_velocity~%float32 p_angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'predict_vals)))
  "Returns full string definition for message of type 'predict_vals"
  (cl:format cl:nil "float32 p_velocity~%float32 p_angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <predict_vals>))
  (cl:+ 0
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <predict_vals>))
  "Converts a ROS message object to a list"
  (cl:list 'predict_vals
    (cl:cons ':p_velocity (p_velocity msg))
    (cl:cons ':p_angle (p_angle msg))
))
