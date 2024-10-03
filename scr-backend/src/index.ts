import dotenv from "dotenv";
import express from "express";
import cors from "cors";
import helmet from "helmet";
import mongoose from 'mongoose';

import routes from './routes';

// INITIALIZE
dotenv.config();

if (!process.env.PORT || !process.env.MONGOURL) { process.exit(1); }

const PORT: number = parseInt(process.env.PORT as string, 10);
const app = express();

// INIT MONGO
mongoose.connect(process.env.MONGOURL)
mongoose.pluralize(null);

app.use(express.json());
app.use(helmet());
app.use(cors());

// ROUTES
app.use("/api", routes);

// START APP
app.listen(PORT, () => {
  console.log(`Listening on port ${PORT}`);
});
