const { json } = require('express')
const express = require('express')
const path = require('path')
const app = express()
const mongoose = require('mongoose')
const Super = require('./models/super')
const DB ='mongodb+srv://kauts:eFcnmKIGq2PmRaQa@cluster0.ftzct.mongodb.net/myFirstDatabase?retryWrites=true&w=majority'

const bodyParser = require('body-parser');
const port = process.env.PORT || 5000;
const cors = require('cors');
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

  app.get('/super', async(req, res, next) => {
    var superRecords = await Super.find();
    console.log(superRecords);
      res.end();
      })

  app.listen(port,()=> {})