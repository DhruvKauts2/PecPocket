const mongoose = require('mongoose')

const SuperModel = mongoose.Schema({
    sid: {type: Number},
    name: {type: String},
    email: {type: String},
    auth: {type: Number}
})

const superModel = mongoose.model('SuperModel', SuperModel);

module.exports = superModel;