const mongoose = require("mongoose");

const ReminderModel = mongoose.Schema({
  sid: { type: Number },
  reminderTitle: { type: String },
  reminderDescription: { type: String },
  reminderDate: { type: String },
  reminderTime: { type: String },
});

const reminderModel = mongoose.model("ReminderModel", ReminderModel);

module.exports = reminderModel;
