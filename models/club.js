const mongoose = require('mongoose')

const ClubModel = mongoose.Schema({
    clubName: {type: String},
    clubAlias: {type: String},
})

const clubModel = mongoose.model('ClubModel', ClubModel);

module.exports = clubModel;