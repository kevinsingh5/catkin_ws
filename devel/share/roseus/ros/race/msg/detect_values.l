;; Auto-generated. Do not edit!


(when (boundp 'race::detect_values)
  (if (not (find-package "RACE"))
    (make-package "RACE"))
  (shadow 'detect_values (find-package "RACE")))
(unless (find-package "RACE::DETECT_VALUES")
  (make-package "RACE::DETECT_VALUES"))

(in-package "ROS")
;;//! \htmlinclude detect_values.msg.html


(defclass race::detect_values
  :super ros::object
  :slots (_distance _distance_theta ))

(defmethod race::detect_values
  (:init
   (&key
    ((:distance __distance) 0.0)
    ((:distance_theta __distance_theta) 0.0)
    )
   (send-super :init)
   (setq _distance (float __distance))
   (setq _distance_theta (float __distance_theta))
   self)
  (:distance
   (&optional __distance)
   (if __distance (setq _distance __distance)) _distance)
  (:distance_theta
   (&optional __distance_theta)
   (if __distance_theta (setq _distance_theta __distance_theta)) _distance_theta)
  (:serialization-length
   ()
   (+
    ;; float32 _distance
    4
    ;; float32 _distance_theta
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _distance
       (sys::poke _distance (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _distance_theta
       (sys::poke _distance_theta (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _distance
     (setq _distance (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _distance_theta
     (setq _distance_theta (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get race::detect_values :md5sum-) "401a8ab557bc852ae88e8fd2a8f16efc")
(setf (get race::detect_values :datatype-) "race/detect_values")
(setf (get race::detect_values :definition-)
      "float32 distance
float32 distance_theta

")



(provide :race/detect_values "401a8ab557bc852ae88e8fd2a8f16efc")


