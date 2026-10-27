---
tags: [code, security, en]
max_turns: 8
allowed_tools: [Read, Glob, Grep, Skill]
---

Review this login handler before I merge it. `src/auth.ts`:

```ts
1  import express from "express";
2  import jwt from "jsonwebtoken";
3  import { db } from "./db";
4
5  const router = express.Router();
6
7  // TODO: move to config later
8  const JWT_SECRET = "supersecret";
9
10 router.post("/login", async (req, res) => {
11   try {
12     const { email, password } = req.body;
13     const rows = await db.query(
14       "SELECT id, password FROM users WHERE email = '" + email + "'"
15     );
16     const user = rows[0];
17     if (user && user.password === password) {
18       const token = jwt.sign({ sub: user.id }, JWT_SECRET);
19       return res.json({ token });
20     }
21     return res.status(401).json({ error: "invalid credentials" });
22   } catch (e) {
23     console.log(e);
24     return res.status(200).json({});
25   }
26 });
27
28 export default router;
```
