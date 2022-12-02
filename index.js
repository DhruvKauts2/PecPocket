const { json } = require("express");
const { MongoClient } = require('mongodb');
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
  "mongodb+srv://kauts:BCn1tnsH2G7WB3rE@cluster0.ftzct.mongodb.net/?retryWrites=true&w=majority";

const bodyParser = require("body-parser");
const port = 3000;
const cors = require("cors");
const { Sign } = require("crypto");
const SignUpModel = require("./models/signup");
const { mainModule } = require("process");
const corsOptions = {
  origin: "*",
  credentials: true,
  optionSuccessStatus: 200,
};

const client = new MongoClient(DB);
// mongoose
//   .connect(DB, { useNewUrlParser: true, useUnifiedTopology: true })
//   .then(() => {
//     console.log("connection successful");

//   })
//   .catch((err) => console.log(err));



app.use(cors(corsOptions));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.post("/signUp", async (req, res) => {
  var sid = Number(req.body["sid"]);

  console.log(sid);
  await client.connect();

  var superRecords = await client.db("myFirstDatabase").collection("supermodels").findOne({ sid: sid });

  if (superRecords != null) {
    var signUpRecords = await client.db("myFirstDatabase").collection("signupmodels").findOne({ sid: sid });

    if (signUpRecords != null) {
      const query = { sid: sid };
      const update = {
        $set: {
          sid: sid,
          signedUp: 1,
        },
      };

      await client.db("myFirstDatabase").collection("signupmodels").updateOne(query, update);
      console.log("updated");
    } else {
      await client.db("myFirstDatabase").collection("signupmodels").insertOne({ sid: sid, signedUp: 1 });
      console.log("created");
      res.send("200");
    }
  } else {
    res.send("404");
  }
  res.end();
  await client.close();

});

app.get("/LogIn", async (req, res) => {
  var sid = Number(req.body["sid"]);
  await client.connect();
  var logInRecords = await client.db("myFirstDatabase").collection("loginmodels").findOne({ sid: sid });

  if (logInRecords != null) {
    const query = { sid: sid };
    const update = {
      $set: {
        sid: sid,
        loggedIn: 1,
      },
    };

    await client.db("myFirstDatabase").collection("loginmodels").updateOne(query, update);
    console.log("updated")
  } else {
    await client.db("myFirstDatabase").collection("loginmodels").insertOne({ sid: sid, loggedIn: 1 });
    console.log("created");
  }

  res.send("Logged In");
  client.close();
});

app.get("/Subjects/:subject", async (req, res) => {
  const { subject } = req.params;
  await client.connect();
  const query = { $text: { $search: subject } };
  const projection = {
    _id: 0,
    subjectName: "subjectName",
    subjectCode: "subjectCode",
  };

  const result = await client.db("myFirstDatabase").collection("subjectmodels").findOne(query);
  res.send(result);
  client.close();
});

app.get("/Clubs/:club", async (req, res, next) => {
  const { club } = req.params;
  const query = { $text: { $search: club } };
  await client.connect();
  const result = await client.db("myFirstDatabase").collection("clubmodels").findOne(query);
  res.send(result);
  client.close();
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
  await client.connect();
  const { sid } = req.params;
  var result = await client.db("myFirstDatabase").collection("remindermodels").findOne({ sid: Number(dis) });
  res.send(result);
  console.log(result);
  await client.close();
});

app.delete("/CustomReminders", async (req, res) => {
  const sid = Number(req.body["sid"]);
  const reminderTitle = req.body["reminderTitle"];
  const reminderDescription = req.body["reminderDescription"];
  const reminderDate = req.body["reminderDate"];
  const reminderTime = req.body["reminderTime"];

  await client.db("myFirstDatabase").collection("remindermodels").deleteMany({
    sid: sid,
    reminderTitle: reminderTitle,
    reminderDescription: reminderDescription,
    reminderDate: reminderDate,
    reminderTime: reminderTime,
  });

  res.send("Deleted");
});

app.put("/Attendance", async (req, res) => {
  const sid = req.body["sid"];
  const subject = req.body["subject"];
  const classesAttended = Number(req.body["classesAttended"]);
  const classesMissed = Number(req.body["classesMissed"]);
  const classStatus = req.body["classStatus"];

  await client.connect();

  var result = await client.db("myFirstDatabase").collection("attendancemodels").findOne({
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

    await client.db("myFirstDatabase").collection("attendancemodels").updateOne(query, update);
  } else {
    var result = await client.db("myFirstDatabase").collection("attendancemodels").insertOne({
      sid: sid,
      subject: subject,
      classesAttended: classesAttended,
      classesMissed: classesMissed,
      classStatus: classStatus,
    });
  }
  console.log("created/updated");
  res.send("Created/Updated");
  await client.close();
});

app.get("/Attendance/:sid", async (req, res) => {
  const { sid } = req.params;
  var response = await client.db("myFirstDatabase").collection("attendancemodels").findOne({ sid: sid });
  res.send(response);
  console.log(response);
  await client.close();
});

app.listen(port, () => { });
