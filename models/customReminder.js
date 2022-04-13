const mongoose = require('mongoose')

const ReminderModel = mongoose.Schema({
    sid : {type:Number},
    reminderTitle: {type: String},
    reminderDescription: {type: String},
    reminderWeekDay: {type: String},
    reminderMonth: {type: String},
    reminderDay: {type: String},
    reminderYear: {type: String},
    reminderStartHour: {type: Number},
    reminderStartMinute: {type: Number},
    reminderEndHour: {type: Number},
    reminderEndMinute: {type: Number}
})

const reminderModel = mongoose.model('ReminderModel', ReminderModel);

module.exports = reminderModel;