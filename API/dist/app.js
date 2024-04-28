/*const express = require("express");
var cors = require("cors");
const createError = require("http-errors");
const cookieParser = require("cookie-parser");
const helmet = require("helmet");
require("dotenv").config();


const errorHandler = require("./middleware/errorHandler");

const app = express();

app.use(helmet()); // https://expressjs.com/en/advanced/best-practice-security.html#use-helmet
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());


// catch 404 and forward to error handler
app.use((req, res, next) => {
  next(createError.NotFound());
});

// pass any unhandled errors to the error handler
app.use(errorHandler);

app.listen(process.env.API_PORT, () => console.log("Server Started on Port : " + process.env.API_PORT));*/

const express = require("express");
var cors = require("cors");
const app = express();
require("dotenv").config();
app.use(express.json());
app.use(cors());
const indexRouter = require("./routes/index");
app.use("/", indexRouter);
var port = process.env.API_PORT || 3001;
app.listen(port, function () {
  console.log("Example app listening on port " + port + "!");
});