// Auto-generated. Do not edit!

// (in-package race.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class predict_vals {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.p_velocity = null;
      this.p_angle = null;
    }
    else {
      if (initObj.hasOwnProperty('p_velocity')) {
        this.p_velocity = initObj.p_velocity
      }
      else {
        this.p_velocity = 0.0;
      }
      if (initObj.hasOwnProperty('p_angle')) {
        this.p_angle = initObj.p_angle
      }
      else {
        this.p_angle = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type predict_vals
    // Serialize message field [p_velocity]
    bufferOffset = _serializer.float32(obj.p_velocity, buffer, bufferOffset);
    // Serialize message field [p_angle]
    bufferOffset = _serializer.float32(obj.p_angle, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type predict_vals
    let len;
    let data = new predict_vals(null);
    // Deserialize message field [p_velocity]
    data.p_velocity = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [p_angle]
    data.p_angle = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'race/predict_vals';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '09486aac4bab37b0c67d7c81bbe7acf8';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 p_velocity
    float32 p_angle
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new predict_vals(null);
    if (msg.p_velocity !== undefined) {
      resolved.p_velocity = msg.p_velocity;
    }
    else {
      resolved.p_velocity = 0.0
    }

    if (msg.p_angle !== undefined) {
      resolved.p_angle = msg.p_angle;
    }
    else {
      resolved.p_angle = 0.0
    }

    return resolved;
    }
};

module.exports = predict_vals;
