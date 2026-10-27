---
type: llm
weight: 3
---

The request gives no requirements ("is this correct" without saying correct for what). PASS if the response:
- Makes the missing contract visible instead of silently assuming one. Any of these counts: naming the missing context, stating its assumption, or framing the answer conditionally ("for non-empty lists, yes — but you need to decide what empty input should do"). It must give an answer, not only ask questions.
- Leads with the most important concrete finding: an empty list raises ZeroDivisionError.
- Gives a concrete fix or decision (raise a clear error, return None/nan, document the precondition, or use statistics.fmean). Extra real edges (generators/iterators where len() fails, float precision) are fine.

FAIL if it just says "looks correct" with no caveat, only asks questions without an answer, or misses the empty-list case.
