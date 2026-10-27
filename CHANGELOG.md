# Changelog

All notable changes to this project are documented here. Versions follow the `version` field in
`.claude-plugin/plugin.json`; users only receive updates when that field is bumped.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [3.2.0] — 2026-10-27

### Added
- **Eval suite** (`evals/`, 8 cases) for `claude plugin eval`, run with and without the plugin:
  security catastrophe, clean code (no manufactured findings), no-severity-inflation (calibrated, no invented bugs), severity
  ordering, Polish end to end, plan/ADR critique, underspecified request, and a negative trigger case.
- **`evals` workflow** — runs the live suite on demand or when a PR carries the `run-evals` label.
- `validate` workflow now checks eval-suite structure, that the agent preloads the skill, and that
  `[solid]` is never used as a per-issue tag.
- **Plugin icon** (`assets/icon.png`) — clears the plugin-directory `ICON_MISSING` warning.
- New README with header, demo GIFs (replays of real eval outputs, `demo/`), architecture diagram,
  CI-gating recipe, `.critical-reviewer.md` example, and eval docs.

### Changed
- **Skill description** rewritten to lead with when to use it (review / critique / sanity-check code,
  diffs, PRs, plans, pasted snippets) and to say it is not for building from scratch — the old
  description made triggering unreliable on plain "review this" requests (1 of 2 runs in the first eval; 14/14 after).
- **One output contract.** `SKILL.md` now defines the exact format (opening, verdict, issues, what's
  good, summary) and the rule that the opening, verdict, and first issue agree. The agent defers to it
  instead of keeping its own copy of the format, verdict table, and noise budget.
- **Per-issue tags** are `[catastrophe]`, `[poor]`, `[needs-work]`, `[nit]`; `[solid]` was dropped —
  it is a verdict, not a severity for a problem.
- **Polish reviews are Polish end to end** — `Werdykt` / `Problemy` / `Dobre` / `Podsumowanie`.
- The 8-step build workflow in `SKILL.md` was replaced by a short "When asked to fix or build"
  section that points to `quality-standards.md` §2–§6, removing the contradiction with the README
  ("writing code → normal behavior") and the "stop and ask" vs "guess loudly" conflict.
- `code-reviewer` agent: Bash is explicitly restricted to read-only inspection.

### Fixed
- The inline example in `SKILL.md` listed a `[catastrophe]` issue last and opened with a lesser
  problem, violating the skill's own severity-order rule.
- A person-directed line in `quality-standards.md` ("…Google it.") replaced with actionable guidance.

## [3.1.0] — 2026-08-06

### Added
- **Per-issue severity tags** (`[catastrophe]` / `[poor]` / `[needs-work]` / `[solid]` / `[nit]`,
  with Polish equivalents) on every finding in both the skill and the `code-reviewer` agent, so the
  issue list is both severity-ordered and greppable — and can gate CI on `[catastrophe]`/`[poor]`.
- **`examples.md`** with four worked reviews: a security catastrophe (EN), a `clean` verdict where
  silence is the review (EN), a `needs-work` React review (PL), and a microservices plan/ADR critique.
- **§7 Security** and **§8 Performance & Scalability** sections in `quality-standards.md` (injection,
  authn/z, secrets, SSRF, path traversal, deserialization; N+1, complexity, unbounded memory, indexes),
  plus a table of contents.
- **Noise budget** rule in the skill and agent — an explicit, enforced anti-nitpick stopping rule.
- **Project config hook** — the reviewer reads and honors a `.critical-reviewer.md` file in the
  reviewed repo when present (focus areas, path-scoped rules, tone).
- **`argument-hint`** frontmatter on the skill for discoverability.
- **CI workflow** (`.github/workflows/validate.yml`) running `claude plugin validate --strict` and
  JSON manifest linting on every push and PR.
- **`CONTRIBUTING.md`** and a **`description`** on the marketplace manifest.

### Fixed
- `code-reviewer` agent no longer points at a repo-root-relative path for the quality standards
  (`skills/critical-reviewer/references/quality-standards.md`), which failed to resolve when the
  plugin was installed and run from a user's project. It now uses the skill-relative reference,
  matching `SKILL.md`.

### Changed
- Removed a time-stamped line ("It's 2026") from `quality-standards.md` per the "avoid
  time-sensitive info" authoring guidance.

## [3.0.0] — earlier

- Cross-platform release: Claude Code plugin + GitHub Copilot CLI + OpenCode skill.
- Critical-reviewer persona skill, read-only `code-reviewer` agent, and `quality-standards.md`
  reference. Bilingual EN/PL. Five-level verdict scale.
