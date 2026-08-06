# Changelog

All notable changes to this project are documented here. Versions follow the `version` field in
`.claude-plugin/plugin.json`; users only receive updates when that field is bumped.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

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
