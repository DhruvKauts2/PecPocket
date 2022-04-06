const { json } = require('express')
const express = require('express')
const path = require('path')
const app = express()
const mongoose = require('mongoose')

const Super = require('./models/super')
const SignUp = require('./models/signup')

const DB ='mongodb+srv://kauts:eFcnmKIGq2PmRaQa@cluster0.ftzct.mongodb.net/myFirstDatabase?retryWrites=true&w=majority'

const bodyParser = require('body-parser');
const port = process.env.PORT || 5000;
const cors = require('cors');
const { Sign } = require('crypto')
const SignUpModel = require('./models/signup')
const corsOptions = {
  origin: '*',
  credentials: true,
  optionSuccessStatus: 200,
}

mongoose.connect(DB, { useNewUrlParser: true, useUnifiedTopology: true }).then(() => {
    console.log('connection successful');
  }).catch((err)=>console.log('Connection Failed'));

  app.use(cors(corsOptions))
  app.use(express.urlencoded({extended: true}))
  app.use(express.json())
  app.use(bodyParser.urlencoded({ extended: true }))
  app.use(bodyParser.json())

  app.get('/signUp', async(req, res, next) => {
    var sid = req.body["sid"];
    var superRecords = await Super.find({"sid" : sid});
    if(superRecords.length != 0){
        var signUpRecords = await SignUp.find({"sid": sid});
        if (signUpRecords.length != 0){
            const query = {"sid" : sid};
            const update = {
                "$set" : {
                    "sid" : sid,
                    "signedUp" : 1
                }
            };
            
            await SignUp.updateOne(query, update);
        }
        else{
            await SignUp.create({"sid": sid, "signedUp" : 1});
            res.send("Created");
        }
    }
    else {
        res.send("Not found");
    }
      res.end();
      })

  app.listen(port,()=> {})