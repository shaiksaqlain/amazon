console.log("hello, world");

//import 'package:express/express.dart'
const express = require("express");

const mongoose = require("mongoose");

// init
const PORT = 3000;
const app = express();
const db="mongodb+srv://lucifer:9440689760@cluster0.dlcy84u.mongodb.net/?retryWrites=true&w=majority";

//import from other files
const authRouter = require("./routes/auth");
//middleware
app.use(express.json());
app.use(authRouter);

//connections
mongoose
  .connect(db)
  .then(() => {
    console.log("Connection Successful!");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0",() => {
  console.log("Port number is" + PORT);
});
