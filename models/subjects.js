const mongoose = require('mongoose')

const SubjectModel = mongoose.Schema({
    subjectName: {type: String},
    subjectCode: {type: String}
})

const subjectModel = mongoose.model('SubjectModel', SubjectModel);

module.exports = subjectModel;