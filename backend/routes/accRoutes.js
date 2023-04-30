const accRoute = require("express").Router();
const { AccountController } = require("../controllers");

accRoute.get("/", AccountController.getacc);
accRoute.post("/login", AccountController.login);
accRoute.post("/", AccountController.register);

module.exports = accRoute