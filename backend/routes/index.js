const route = require("express").Router();

route.get("/api", (req, res) => {
    res.status(200).json({
        "message": "Welcome to acc API"
    })
})

const accountRoute = require('./accRoutes');

route.use('/api/accounts', accountRoute);

module.exports = route;