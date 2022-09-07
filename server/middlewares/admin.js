const express= require('express');
const User = require('../models/user');
const jwt = require("jsonwebtoken");
const adminRouter=express.Router();

const admin = async (req, res, next) => {
    try {
      const token = req.header("x-auth-token");
      if (!token)
        return res.status(401).json({ message: "No auth token, access denied" });
  
      const verified = jwt.verify(token, "passwordKey");
      if (!verified)
        return res
          .status(401)
          .json({ message: "token verification faild,authorization denied." });
      
      const user =await User.findById(verified.id);
      if(user.type=='user'|| user.type=='seller'){
        return res.status(401).json({mesge:"Your not an admin!"})
      }
      
      req.user = verified.id;
      req.token = token;
      next();
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  };

  module.exports = admin;