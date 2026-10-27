---
type: llm
weight: 3
---

PASS if the review is written in Polish (code identifiers may stay in English) and:
- Opens with the most important problem: the missing cleanup/abort in useEffect (stale responses can overwrite newer state when teamId changes) or the swallowed fetch error leaving an endless loading state.
- Flags both of those issues with line references.
- Does not treat the component as catastrophic (verdict "do poprawy" or "słabe" is appropriate).

FAIL if the review is mostly in English, misses either issue, or opens with praise.
