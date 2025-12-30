import express from "express";
import cors from "cors";
import { StreamChat } from "stream-chat";

const app = express();
app.use(cors());
app.use(express.json());

const apiKey = 'p4q6f6afa9dj';
const apiSecret = '3wsu7sn5zpqstmcbbrn7dws96uzjcgs8x88f5z3qgkm56539vc7u2awjypvguffv';

if (!apiKey || !apiSecret) {
  console.error("Faltan variables STREAM_API_KEY o STREAM_API_SECRET");
  process.exit(1);
}

const serverClient = StreamChat.getInstance(apiKey, apiSecret);

app.get("/health", (_, res) => res.json({ ok: true }));

app.post("/stream/token", (req, res) => {
  const { user_id } = req.body;

  if (!user_id) return res.status(400).json({ error: "user_id required" });

  const token = serverClient.createToken(user_id);
  return res.json({ token });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Token server listo en http://localhost:${PORT}`);
});
