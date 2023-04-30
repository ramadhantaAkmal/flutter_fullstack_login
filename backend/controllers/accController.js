const { account } = require("../models");
const { decrypt } = require("../helpers/bcrypt");
const { generateToken, verifToken } = require("../helpers/auth");

class AccountController {
  static async login(req, res) {
    try {
      const { username, password } = req.body;
      let result = await account.findOne({
        where: { username },
      });
      if (result) {
        if (decrypt(password, result.password)) {
          let access_token = generateToken(result);
          let token = verifToken(access_token);
          res.status(200).json({ access_token });
        } else {
          res.status(403).json({ message: "Password Wrong" });
        }
      } else {
        res.status(404).json({ message: "Username Not Found" });
      }
    } catch (error) {
      res.status(500).json(error);
    }
  }

  static async register(req, res) {
    try {
      const {name, username, password, email } = req.body;
      let result = await account.create({
        name,
        username,
        password,
        email,
      });
      res.status(201).json(result);
    } catch (error) {
      res.status(500).json(error);
    }
  }

  static async getacc(req, res){
    try {
      let result = await account.findAll();
      res.status(200).json(result);
    } catch (error) {
      res.status(500).json(error);
    }
  }
}

module.exports = AccountController;
