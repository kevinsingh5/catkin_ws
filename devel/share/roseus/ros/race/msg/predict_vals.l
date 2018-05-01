;; Auto-generated. Do not edit!


(when (boundp 'race::predict_vals)
  (if (not (find-package "RACE"))
    (make-package "RACE"))
  (shadow 'predict_vals (find-package "RACE")))
(unless (find-package "RACE::PREDICT_VALS")
  (make-package "RACE::PREDICT_VALS"))

(in-package "ROS")
;;//! \htmlinclude predict_vals.msg.html


(defclass race::predict_vals
  :super ros::object
  :slots (_p_velocity _p_angle ))

(defmethod race::predict_vals
  (:init
   (&key
    ((:p_velocity __p_velocity) 0.0)
    ((:p_angle __p_angle) 0.0)
    )
   (send-super :init)
   (setq _p_velocity (float __p_velocity))
   (setq _p_angle (float __p_angle))
   self)
  (:p_velocity
   (&optional __p_velocity)
   (if __p_velocity (setq _p_velocity __p_velocity)) _p_velocity)
  (:p_angle
   (&optional __p_angle)
   (if __p_angle (setq _p_angle __p_angle)) _p_angle)
  (:serialization-length
   ()
   (+
    ;; float32 _p_velocity
    4
    ;; float32 _p_angle
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _p_velocity
       (sys::poke _p_velocity (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _p_angle
       (sys::poke _p_angle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _p_velocity
     (setq _p_velocity (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _p_angle
     (setq _p_angle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get race::predict_vals :md5sum-) "09486aac4bab37b0c67d7c81bbe7acf8")
(setf (get race::predict_vals :datatype-) "race/predict_vals")
(setf (get race::predict_vals :definition-)
      "float32 p_velocity
float32 p_angle

")



(provide :race/predict_vals "09486aac4bab37b0c67d7c81bbe7acf8")


