const mongoose = require("mongoose");

const LoginModel = mongoose.Schema({
  sid: { type: Number },
  loggedIn: { type: Number },
});

const loginModel = mongoose.model("LoginModel", LoginModel);

module.exports = loginModel;
