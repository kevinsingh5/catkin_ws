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

class detect_values {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.distance = null;
      this.distance_theta = null;
    }
    else {
      if (initObj.hasOwnProperty('distance')) {
        this.distance = initObj.distance
      }
      else {
        this.distance = 0.0;
      }
      if (initObj.hasOwnProperty('distance_theta')) {
        this.distance_theta = initObj.distance_theta
      }
      else {
        this.distance_theta = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type detect_values
    // Serialize message field [distance]
    bufferOffset = _serializer.float32(obj.distance, buffer, bufferOffset);
    // Serialize message field [distance_theta]
    bufferOffset = _serializer.float32(obj.distance_theta, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type detect_values
    let len;
    let data = new detect_values(null);
    // Deserialize message field [distance]
    data.distance = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [distance_theta]
    data.distance_theta = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'race/detect_values';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '401a8ab557bc852ae88e8fd2a8f16efc';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 distance
    float32 distance_theta
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new detect_values(null);
    if (msg.distance !== undefined) {
      resolved.distance = msg.distance;
    }
    else {
      resolved.distance = 0.0
    }

    if (msg.distance_theta !== undefined) {
      resolved.distance_theta = msg.distance_theta;
    }
    else {
      resolved.distance_theta = 0.0
    }

    return resolved;
    }
};

module.exports = detect_values;
