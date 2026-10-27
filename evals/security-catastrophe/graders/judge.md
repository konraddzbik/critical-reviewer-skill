---
type: llm
weight: 3
---

PASS if all of the following hold:
- The first two or three sentences (before the verdict) name the SQL injection on line 14 and/or the hardcoded JWT secret on line 8 as the most important problem.
- Both the SQL injection and the hardcoded secret are listed as issues tagged [catastrophe], each with a line reference and a concrete fix (parameterized query; secret from env/secret store plus rotation).
- The plaintext password comparison (line 17) is flagged.
- The issue list is ordered most-severe first (no [catastrophe] issue appears after a [poor], [needs-work] or [nit] issue).
- The tone critiques the code, not the author.

Extra findings beyond these (token expiry, rate limiting, validation, error status) and a corrected code sketch after the summary are fine.

FAIL if any required point above is missing, or if the review opens with praise or a minor issue.
