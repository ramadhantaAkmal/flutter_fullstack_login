'use strict';
const { encrypt } = require("../helpers/bcrypt");
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class account extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  account.init({
    name: {
      type: DataTypes.STRING,
      validate: {
        notEmpty: {
          message: "Name Shouldn't Empty",
        },
      },
    },
    username: {
      type: DataTypes.STRING,
      validate: {
        notEmpty: {
          message: "Username Shouldn't Empty",
        },
      },
    },
    password: {
      type: DataTypes.STRING,
      validate: {
        notEmpty: {
          message: "Password Shouldn't Empty",
        },
      },
    },
    email: {
      type: DataTypes.STRING,
      validate: {
        notEmpty: {
          message: "Email Shouldn't Empty",
        },
      },
    },
  }, {
    hooks: {
      beforeCreate: (account, options) => {
        account.password = encrypt(account.password);
      },
      beforeUpdate: (account, options) => {
        account.password = encrypt(account.password);
      },
    },
    sequelize,
    modelName: 'account',
  });
  return account;
};