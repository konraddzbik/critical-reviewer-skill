---
type: llm
weight: 3
---

PASS if the response:
- Opens by naming the weakest assumption (that splitting into services buys scalability or anything else at this scale / with two maintainers) rather than with background or praise.
- Gives a clear recommendation — "no" or "conditional, with the conditions listed" — favoring a modular monolith or measuring the bottleneck first. No hedged "it depends" without conditions.
- Names concrete missing pieces (e.g. cross-service failure modes, data consistency across split databases, operational cost for two people, the unmeasured bottleneck).
- Explicitly rejects "the team agreed" as a technical argument or addresses consensus vs technical reasoning.
- Demands an ADR (Context, Decision, Consequences).

FAIL if it endorses the six-service split as stated, or never commits to a recommendation.
