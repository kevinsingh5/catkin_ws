;; Auto-generated. Do not edit!


(when (boundp 'race::obj_track)
  (if (not (find-package "RACE"))
    (make-package "RACE"))
  (shadow 'obj_track (find-package "RACE")))
(unless (find-package "RACE::OBJ_TRACK")
  (make-package "RACE::OBJ_TRACK"))

(in-package "ROS")
;;//! \htmlinclude obj_track.msg.html


(defclass race::obj_track
  :super ros::object
  :slots (_obj_found _dist _offset ))

(defmethod race::obj_track
  (:init
   (&key
    ((:obj_found __obj_found) nil)
    ((:dist __dist) 0.0)
    ((:offset __offset) 0.0)
    )
   (send-super :init)
   (setq _obj_found __obj_found)
   (setq _dist (float __dist))
   (setq _offset (float __offset))
   self)
  (:obj_found
   (&optional __obj_found)
   (if __obj_found (setq _obj_found __obj_found)) _obj_found)
  (:dist
   (&optional __dist)
   (if __dist (setq _dist __dist)) _dist)
  (:offset
   (&optional __offset)
   (if __offset (setq _offset __offset)) _offset)
  (:serialization-length
   ()
   (+
    ;; bool _obj_found
    1
    ;; float32 _dist
    4
    ;; float32 _offset
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _obj_found
       (if _obj_found (write-byte -1 s) (write-byte 0 s))
     ;; float32 _dist
       (sys::poke _dist (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _offset
       (sys::poke _offset (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _obj_found
     (setq _obj_found (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _dist
     (setq _dist (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _offset
     (setq _offset (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get race::obj_track :md5sum-) "b471f6f1d7cfaf31ae77ada0b181d9de")
(setf (get race::obj_track :datatype-) "race/obj_track")
(setf (get race::obj_track :definition-)
      "bool obj_found
float32 dist
float32 offset

")



(provide :race/obj_track "b471f6f1d7cfaf31ae77ada0b181d9de")


