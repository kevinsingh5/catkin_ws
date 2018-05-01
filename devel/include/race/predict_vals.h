// Generated by gencpp from file race/predict_vals.msg
// DO NOT EDIT!


#ifndef RACE_MESSAGE_PREDICT_VALS_H
#define RACE_MESSAGE_PREDICT_VALS_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace race
{
template <class ContainerAllocator>
struct predict_vals_
{
  typedef predict_vals_<ContainerAllocator> Type;

  predict_vals_()
    : p_velocity(0.0)
    , p_angle(0.0)  {
    }
  predict_vals_(const ContainerAllocator& _alloc)
    : p_velocity(0.0)
    , p_angle(0.0)  {
  (void)_alloc;
    }



   typedef float _p_velocity_type;
  _p_velocity_type p_velocity;

   typedef float _p_angle_type;
  _p_angle_type p_angle;




  typedef boost::shared_ptr< ::race::predict_vals_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::race::predict_vals_<ContainerAllocator> const> ConstPtr;

}; // struct predict_vals_

typedef ::race::predict_vals_<std::allocator<void> > predict_vals;

typedef boost::shared_ptr< ::race::predict_vals > predict_valsPtr;
typedef boost::shared_ptr< ::race::predict_vals const> predict_valsConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::race::predict_vals_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::race::predict_vals_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace race

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': True, 'IsMessage': True, 'HasHeader': False}
// {'race': ['/home/nvidia/catkin_ws/src/race/msg'], 'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::race::predict_vals_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::race::predict_vals_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::race::predict_vals_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::race::predict_vals_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::race::predict_vals_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::race::predict_vals_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::race::predict_vals_<ContainerAllocator> >
{
  static const char* value()
  {
    return "09486aac4bab37b0c67d7c81bbe7acf8";
  }

  static const char* value(const ::race::predict_vals_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x09486aac4bab37b0ULL;
  static const uint64_t static_value2 = 0xc67d7c81bbe7acf8ULL;
};

template<class ContainerAllocator>
struct DataType< ::race::predict_vals_<ContainerAllocator> >
{
  static const char* value()
  {
    return "race/predict_vals";
  }

  static const char* value(const ::race::predict_vals_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::race::predict_vals_<ContainerAllocator> >
{
  static const char* value()
  {
    return "float32 p_velocity\n\
float32 p_angle\n\
";
  }

  static const char* value(const ::race::predict_vals_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::race::predict_vals_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.p_velocity);
      stream.next(m.p_angle);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct predict_vals_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::race::predict_vals_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::race::predict_vals_<ContainerAllocator>& v)
  {
    s << indent << "p_velocity: ";
    Printer<float>::stream(s, indent + "  ", v.p_velocity);
    s << indent << "p_angle: ";
    Printer<float>::stream(s, indent + "  ", v.p_angle);
  }
};

} // namespace message_operations
} // namespace ros

#endif // RACE_MESSAGE_PREDICT_VALS_H
