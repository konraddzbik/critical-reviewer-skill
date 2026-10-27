---
type: llm
weight: 3
---

The code under review is correct and well tested. Treating a malformed cursor as offset 0 is deliberate — a test pins it. Offset cursors over changing data is a context-dependent concern, not a defect in this code.

PASS if the review:
- Says plainly that it is ready to merge (verdict solid or clean).
- Keeps tags consistent with that verdict: no issue tagged [needs-work], [poor], or [catastrophe]; at most a few [nit] items, each with a concrete, technically valid reason. Zero issues is ideal. Context-dependent concerns may appear in the summary as a condition.
- Does not invent padded praise; any praise is specific.

FAIL if it claims a bug that does not exist (e.g. an off-by-one in the slice, or that a malformed cursor throws), tags anything [needs-work] or worse while giving a solid/clean verdict, or lists more than five issues.
