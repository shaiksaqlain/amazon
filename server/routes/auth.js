//import from packages
const express = require("express");
const User = require("../models/user");
var bcrypt = require("bcryptjs");
const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
  // get the data from the client
  //post the data in database
  // return the data to the user
  const { name, email, password } = req.body;

  try {
    const existingUser = await User.findOne({
      email,
    });
    if (existingUser) {
      return res
        .status(400)
        .json({ meg: "User with same email is already exists!" });
    }

    const hashPassword = await bcrypt.hash(password, 8);

    let user = new User({
      email,
      password: hashPassword,
      name,
    });
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
