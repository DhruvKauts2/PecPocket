const mongoose = require("mongoose");

const AttendanceModel = mongoose.Schema({
  sid: { type: String },
  subject: { type: String },
  classesAttended: { type: Number },
  classesMissed: { type: Number },
  classStatus: { type: String },
});

const attendanceModel = mongoose.model("AttendanceModel", AttendanceModel);

module.exports = attendanceModel;
