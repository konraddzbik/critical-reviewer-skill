# Quality Standards

These are not suggestions. These are the minimum bar for code that deserves to exist.
Sourced from three repos that have survived production. Everything here is non-negotiable.

---

## 1. Code Quality (Marko)

### Critical issues

- **Silent failures.** `try { } catch(e) { }` is not error handling. It's a cover-up. You're not handling the error, you're masking the failure.
- **Bad names.** `data`, `temp`, `result`, `processStuff`, `handleThings`. These are not names. These are what you write when you've given up on communicating with other humans.
- **Magic numbers.** `if (status === 3)` — what is 3? Is that success? Failure? A priority level? Name it.
- **Hardcoded secrets.** API keys in source code. Passwords in config files committed to git. You've effectively published your credentials.
- **N+1 queries.** Code that gets slower the more successful your product becomes. The query count scales linearly with result size.
- **Unbounded loops and missing backoff.** Your retry logic will DDoS your own service. The retry logic becomes the threat.
- **Tests that test nothing.** `expect(true).toBe(true)` doesn't make your coverage number meaningful. It makes your coverage metric meaningless.
- **Dead code, stale comments, commented-out blocks.** If it's not running, it's not code — it's archaeology. Either delete it or explain why it's there. `// TODO: fix this` from 2023 is not an explanation, it's abandoned intent.
- **Leftover debug prints.** `console.log("here")`, `print("wtf")`, `System.out.println("asdf")`. Your production logs now read like debug output, not operational data.
- **Concurrency issues and race conditions.** Two threads update the same row. The first one commits. Now your data is wrong and nobody knows why. Think about shared state or don't use threads.
- **Off-by-one errors.** The oldest bug in programming and you still wrote `<=` when you meant `<`. Fence. Post. Problem. Google it.
- **Premature abstraction.** You wrote a factory pattern for one implementation. An interface with one implementor. A strategy pattern with one strategy. That's not architecture, that's premature abstraction.
- **The reader test.** If the next person reading this code needs to re-read it three times — because of the naming, the indirection, the missing context, the 400-line function — it fails. Code is read 10x more than it's written. Optimize for the reader.

### Things nobody cares about

- Tabs vs spaces. Configure your formatter and move on.
- Semicolons. It's 2026. Your tooling handles this.
- "But my way is cleaner" — your way is different. Different ≠ better. Match the existing style.
- Personal preference masquerading as engineering critique. "I would have done it differently" is not a bug report.
- Nits that don't affect correctness, readability, or operability. If the only complaints are nits, the code is close to solid.

---

## 2. Think Before Coding (Karpathy)

These rules exist because LLMs (and most developers) jump to implementation before understanding the problem. Don't.

- **State your assumptions explicitly.** If you're uncertain about ANYTHING — the expected input format, the deployment environment, the edge cases — say so BEFORE writing a line of code. Hidden assumptions are hidden bugs.
- **Multiple interpretations? Present them.** Don't silently pick one. "This could mean X or Y. I'm going with X because Z." If you can't justify the choice, you don't understand the problem.
- **Push back when warranted.** If a simpler approach exists, say so. If the request is wrong, say so. "You asked for X but Y solves the actual problem" is not insubordination, it's engineering.
- **If something is unclear, STOP.** Name what's confusing. Ask. Don't guess silently and build on top of a guess. A question now costs 5 minutes. A wrong assumption costs 5 days.
- **Don't write error handling for impossible scenarios.** If a value can never be null, don't null-check it. Defensive programming against impossible cases is not robust — it's noise that hides real bugs.

---

## 3. Simplicity First (Karpathy)

Minimum code that solves the problem. Nothing speculative.

- Don't build what wasn't asked for. You're not a visionary, you're adding scope.
- One implementation doesn't need an abstraction. A factory that makes one thing is not a pattern, it's overhead.
- No "flexibility" or "configurability" that wasn't requested. YAGNI is not a suggestion.
- "But what if we need to change it later?" — then you'll change it later. That's literally what version control is for.
- 200 lines that could be 50 is not "thorough." It's a sign you didn't think hard enough.
- If a junior can't read it, it's too complicated. Yes, even your "elegant" recursive solution.
- **The senior engineer test:** "Would a senior engineer say this is overcomplicated?" If yes, simplify. If you're not sure, it's overcomplicated.

---

## 4. Surgical Changes (Karpathy)

Touch only what you must. Your diff is your argument.

- Every line changed should trace to the request. If it doesn't, revert it.
- **Don't "improve" adjacent code.** "While I was here I also improved..." — no. Stop. You were not asked to improve. You were asked to fix one thing.
- **Don't refactor things that aren't broken.** Your aesthetic preferences are not a business requirement.
- **Match existing style.** Yes, even if it's ugly. Consistency beats your preferences every time.
- **Clean up YOUR orphans only.** Imports, variables, functions that YOUR changes made unused — delete them. Pre-existing dead code? Not your problem unless asked.
- **Notice unrelated issues? Mention them — don't fix them.** "I saw dead code in line 47" is fine. Silently deleting it in the same PR is not.

---

## 5. Goal-Driven Execution (Karpathy)

Define success criteria. Loop until verified. If you can't define "done," you don't understand the task.

- **Transform vague tasks into verifiable goals:**
  - "Add validation" → "Reject input X with error Y" — that's a spec
  - "Fix the bug" → "Write a test that reproduces it, then make it pass"
  - "Refactor X" → "Ensure tests pass before and after. No behavior change"
  - "Make it work" → UNACCEPTABLE. Define what "work" means first

- **Multi-step tasks get a plan with verification checkpoints:**
  ```
  1. [Step] → verify: [how you know it worked]
  2. [Step] → verify: [how you know it worked]
  3. [Step] → verify: [how you know it worked]
  ```
  No plan = no start. Weak criteria ("make it work") require clarification, not implementation.

- **Strong success criteria let you loop independently.** If you need to ask the user after every step, your criteria are weak. Fix the criteria first.

---

## 6. Architecture & Domain (Pocock)

### Before writing a single line

- **Read the codebase FIRST.** ALL of it. Not just the file you're touching. "I assumed the auth was middleware" — you assumed wrong because you didn't look.
- **If you can't define "done" in one sentence, go back.** You don't understand the task yet.
- **Design the interface first.** Not after implementation. Not during. Before. The interface IS the design. Implementation is just filling in the blanks.

### TDD — Red, Green, Refactor

Not optional. Not "nice to have." The workflow:

1. **Red** — write a test that fails. If you can't write the test, you don't understand the requirement
2. **Green** — write the MINIMUM code to make it pass. Not the elegant code. Not the complete code. The minimum
3. **Refactor** — now clean it up. Tests still pass? Good. Tests broke? Your refactor changed behavior. Undo it

"Quick fix without tests" is how technical debt is born, raised, and eventually inherits your codebase. Every. Single. Time.

### Domain-Driven Design basics

- **Names come from the business domain, not from your CS degree.** If the business says "order," don't call it `TransactionEntity`. If the business says "approve," don't call it `processStatusUpdate`.
- **Ubiquitous language is not optional.** If developers and business people use different words for the same thing, bugs live in the gap. Pick one word. Use it everywhere.
- **If you can't name it clearly, you don't understand it.** Stop writing code. Go talk to someone who understands the domain.

### Commits and change management

- **Small, atomic commits.** Each commit works independently. If you revert one commit and the build breaks, it wasn't atomic. It was a mess with a message.
- **Each commit should be deployable on its own.** Not "deployable after the next 3 commits land." On its own. Now.
- **Commit messages explain WHY, not WHAT.** The diff shows what changed. The message explains why it needed to change.

### Architecture Decision Records (ADRs)

- When you make a significant architecture decision, document it. Not in a Slack thread. Not in a comment. In a file that lives with the code.
- Format: **Context** (why we're deciding), **Decision** (what we chose), **Consequences** (what changes, what we lose)
- Future-you will thank present-you. Or more likely, future-someone-else will thank present-you because you'll have moved on to another team by then.

---

## Verdict Scale

| Verdict | Translation for people who need it spelled out |
|---|---|
| **catastrophe** | "Stop. Do not deploy. Do not push. Fix immediately." |
| **poor** | "This will break in production in ways that matter. Fix before merge." |
| **needs-work** | "Technically functional, but fragile. Not production-ready without changes." |
| **solid** | "A senior engineer would approve this without comments. This is the goal." |
| **clean** | "Genuinely elegant. Rare. This is the standard the rest of the codebase should match." |

---

## Quick Reference: When to apply what

| Situation | Apply these sections |
|---|---|
| Writing new code | §2 Think First → §5 Goals → §6 TDD → §3 Simplicity → §1 Quality |
| Reviewing code | §1 Quality → §3 Simplicity → §6 Domain → Verdict |
| Fixing a bug | §5 Goals (reproduce first) → §6 TDD (red→green→refactor) → §4 Surgical |
| Refactoring | §4 Surgical → §6 Commits (atomic) → §5 Goals (tests pass before AND after) |
| Architecture decision | §2 Think First → §6 ADR → §6 Domain → §3 Simplicity |
| Vague request from user | §2 Think First (state assumptions) → §5 Goals (define "done") → then proceed |
