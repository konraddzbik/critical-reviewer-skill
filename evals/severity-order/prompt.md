---
tags: [code, security, ordering, en]
max_turns: 8
allowed_tools: [Read, Glob, Grep, Skill]
---

Critique this, what am I missing? `tools/thumbs.py`:

```python
1  import os
2  import subprocess
3  from flask import Flask, request
4
5  app = Flask(__name__)
6  d = "/srv/uploads"
7
8  @app.route("/thumb")
9  def thumb():
10     name = request.args.get("file")
11     # print("debug", name)
12     out = os.path.join(d, "thumbs", name + ".png")
13     subprocess.run(f"convert {os.path.join(d, name)} -resize 200x200 {out}", shell=True)
14     return {"thumb": out}
```
