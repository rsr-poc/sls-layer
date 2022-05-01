import express from "express";
import serverless from "serverless-http";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

const app = express();

app.use(express.json());

app.get("/", async (req, res) => {
  const messages = await prisma.message.findMany();
  res.json({
    text: "Hello from Layers",
    messages,
  });
});

export const server = serverless(app);
