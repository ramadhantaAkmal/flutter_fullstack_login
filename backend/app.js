import express, { json, urlencoded } from "express";
const app = express();
const port = process.env.PORT || 3000;

import routes from "./routes";
app.use(json());
app.use(urlencoded({ extended: true }));
app.use(routes);

app.listen(port, () => {
  console.log(`App is listening on ${port}`);
});
