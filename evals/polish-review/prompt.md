---
tags: [code, language, pl]
max_turns: 8
allowed_tools: [Read, Glob, Grep, Skill]
---

Przejrzyj to bez ściemy, `UserList.tsx`:

```tsx
1  import { useEffect, useState } from "react";
2
3  type User = { id: string; name: string };
4
5  export function UserList({ teamId }: { teamId: string }) {
6    const [data, setData] = useState<User[] | null>(null);
7
8    useEffect(() => {
9      fetch(`/api/teams/${teamId}/users`)
10       .then((r) => r.json())
11       .then((users) => setData(users))
12       .catch((e) => console.log(e));
13   }, [teamId]);
14
15   if (!data) return <p>Ładowanie…</p>;
16   return (
17     <ul>
18       {data.map((u) => (
19         <li key={u.id}>{u.name}</li>
20       ))}
21     </ul>
22   );
23 }
```
