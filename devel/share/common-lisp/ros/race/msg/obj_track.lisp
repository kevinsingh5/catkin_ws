; Auto-generated. Do not edit!


(cl:in-package race-msg)


;//! \htmlinclude obj_track.msg.html

(cl:defclass <obj_track> (roslisp-msg-protocol:ros-message)
  ((obj_found
    :reader obj_found
    :initarg :obj_found
    :type cl:boolean
    :initform cl:nil)
   (dist
    :reader dist
    :initarg :dist
    :type cl:float
    :initform 0.0)
   (offset
    :reader offset
    :initarg :offset
    :type cl:float
    :initform 0.0))
)

(cl:defclass obj_track (<obj_track>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <obj_track>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'obj_track)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name race-msg:<obj_track> is deprecated: use race-msg:obj_track instead.")))

(cl:ensure-generic-function 'obj_found-val :lambda-list '(m))
(cl:defmethod obj_found-val ((m <obj_track>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader race-msg:obj_found-val is deprecated.  Use race-msg:obj_found instead.")
  (obj_found m))

(cl:ensure-generic-function 'dist-val :lambda-list '(m))
(cl:defmethod dist-val ((m <obj_track>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader race-msg:dist-val is deprecated.  Use race-msg:dist instead.")
  (dist m))

(cl:ensure-generic-function 'offset-val :lambda-list '(m))
(cl:defmethod offset-val ((m <obj_track>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader race-msg:offset-val is deprecated.  Use race-msg:offset instead.")
  (offset m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <obj_track>) ostream)
  "Serializes a message object of type '<obj_track>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'obj_found) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dist))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'offset))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <obj_track>) istream)
  "Deserializes a message object of type '<obj_track>"
    (cl:setf (cl:slot-value msg 'obj_found) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dist) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'offset) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<obj_track>)))
  "Returns string type for a message object of type '<obj_track>"
  "race/obj_track")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'obj_track)))
  "Returns string type for a message object of type 'obj_track"
  "race/obj_track")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<obj_track>)))
  "Returns md5sum for a message object of type '<obj_track>"
  "b471f6f1d7cfaf31ae77ada0b181d9de")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'obj_track)))
  "Returns md5sum for a message object of type 'obj_track"
  "b471f6f1d7cfaf31ae77ada0b181d9de")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<obj_track>)))
  "Returns full string definition for message of type '<obj_track>"
  (cl:format cl:nil "bool obj_found~%float32 dist~%float32 offset~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'obj_track)))
  "Returns full string definition for message of type 'obj_track"
  (cl:format cl:nil "bool obj_found~%float32 dist~%float32 offset~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <obj_track>))
  (cl:+ 0
     1
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <obj_track>))
  "Converts a ROS message object to a list"
  (cl:list 'obj_track
    (cl:cons ':obj_found (obj_found msg))
    (cl:cons ':dist (dist msg))
    (cl:cons ':offset (offset msg))
))
