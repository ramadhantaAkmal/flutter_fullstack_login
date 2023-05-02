const accRoute = require("express").Router();
const { AccountController } = require("../controllers");

accRoute.get("/:id", AccountController.getacc);
accRoute.post("/login", AccountController.login);
accRoute.post("/", AccountController.register);

module.exports = accRoute