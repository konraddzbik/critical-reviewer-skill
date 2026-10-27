---
tags: [plan, architecture, en]
max_turns: 6
allowed_tools: [Read, Glob, Grep, Skill]
---

Second opinion please. Our team agreed to split our internal CRUD app (orders, customers, invoices — about 40 tables, one Postgres DB) into 6 microservices next quarter, each with its own database. Two developers maintain it and we deploy about once a week. The main reason is "so it can scale". Is this the right call?
