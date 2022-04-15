const { json } = require("express");
const express = require("express");
const path = require("path");
const app = express();
const mongoose = require("mongoose");
const Attendance = require("./models/attendance");
const CustomReminder = require("./models/customReminder");
const Super = require("./models/super");
const SignUp = require("./models/signup");
const LoggedIn = require("./models/login");
const Subjects = require("./models/subjects");
const Clubs = require("./models/club");
const DB =
  "mongodb+srv://kauts:eFcnmKIGq2PmRaQa@cluster0.ftzct.mongodb.net/myFirstDatabase?retryWrites=true&w=majority";

const bodyParser = require("body-parser");
const port = 5000;
const cors = require("cors");
const { Sign } = require("crypto");
const SignUpModel = require("./models/signup");
const corsOptions = {
  origin: "*",
  credentials: true,
  optionSuccessStatus: 200,
};

mongoose
  .connect(DB, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => {
    console.log("connection successful");
  })
  .catch((err) => console.log("Connection Failed"));

app.use(cors(corsOptions));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.post("/signUp", async (req, res) => {
  var sid = req.body["sid"];
  var superRecords = await Super.find({ sid: sid });
  if (superRecords.length != 0) {
    var signUpRecords = await SignUp.find({ sid: sid });
    if (signUpRecords.length != 0) {
      const query = { sid: sid };
      const update = {
        $set: {
          sid: sid,
          signedUp: 1,
        },
      };

      await SignUp.updateOne(query, update);
    } else {
      await SignUp.create({ sid: sid, signedUp: 1 });
      res.send("200");
    }
  } else {
    res.send("404");
  }
  res.end();
});

app.get("/LogIn", async (req, res) => {
  var sid = req.body["sid"];
  var logInRecords = await LoggedIn.find({ sid: sid });
  if (logInRecords.length != 0) {
    const query = { sid: sid };
    const update = {
      $set: {
        sid: sid,
        loggedIn: 1,
      },
    };

    LoggedIn.updateOne(query, update);
  } else {
    await LoggedIn.create({ sid: sid, loggedIn: 1 });
  }

  res.send("Logged In");
});

app.get("/Subjects/:subject", async (req, res, next) => {
  const { subject } = req.params;
  const query = { $text: { $search: subject } };
  const projection = {
    _id: 0,
    subjectName: "subjectName",
    subjectCode: "subjectCode",
  };

  const result = await Subjects.find(query);
  res.send(result);
});

app.get("/Clubs/:club", async (req, res, next) => {
  const { club } = req.params;
  const query = { $text: { $search: club } };
  const result = await Clubs.find(query);
  res.send(result);
});

app.post("/CustomReminders", async (req, res, next) => {
  const sid = req.body["sid"];

  const reminderTitle = req.body["reminderTitle"];
  const reminderDescription = req.body["reminderDescription"];
  const reminderDate = req.body["reminderDate"];
  const reminderTime = req.body["reminderTime"];

  await CustomReminder.create({
    sid: sid,
    reminderTitle: reminderTitle,
    reminderDescription: reminderDescription,
    reminderDate: reminderDate,
    reminderTime: reminderTime,
  });

  res.send("Created");
});

app.get("/CustomReminders/:sid", async (req, res) => {
  const { sid } = req.params;
  var result = await CustomReminder.find({ sid: sid });
  res.send(result);
});

app.delete("/CustomReminders", async (req, res) => {
  const sid = req.body["sid"];
  const reminderTitle = req.body["reminderTitle"];
  const reminderDescription = req.body["reminderDescription"];
  const reminderDate = req.body["reminderDate"];
  const reminderTime = req.body["reminderTime"];

  await CustomReminder.deleteOne({
    sid: sid,
    reminderTitle: reminderTitle,
    reminderDescription: reminderDescription,
    reminderDate: reminderDate,
    reminderTime: reminderTime,
  });

  res.send("Deleted");
});

app.put("/Attendance", async (req, res, next) => {
  const sid = req.body["sid"];
  const subject = req.body["subject"];
  const classesAttended = req.body["classesAttended"];
  const classesMissed = req.body["classesMissed"];
  const classStatus = req.body["classStatus"];

  var result = await Attendance.findOne({
    sid: sid,
    subject: subject,
  });

  if (result != null) {
    const query = { sid: sid, subject: subject };
    const update = {
      $set: {
        sid: sid,
        subject: subject,
        classesAttended: classesAttended,
        classesMissed: classesMissed,
        status: classStatus,
      },
    };

    await Attendance.updateOne(query, update);
  } else {
    var result = await Attendance.create({
      sid: sid,
      subject: subject,
      classesAttended: classesAttended,
      classesMissed: classesMissed,
      classStatus: classStatus,
    });
  }
  console.log("created/updated");
  res.send("Created/Updated");
});

app.get("/Attendance/:sid", async (req, res) => {
  const { sid } = req.params;
  var response = await Attendance.find({ sid: sid });
  res.send(response);
});

app.post("/UpdateAttendance");
app.listen(port, () => {});
