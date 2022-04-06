const mongoose = require('mongoose')

const SignUpModel = mongoose.Schema({
    sid: {type: Number},
    signedUp: {type: Number}
})

const signUpModel = mongoose.model('SignUpModel', SignUpModel);

module.exports = signUpModel;