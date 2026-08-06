# Contributing

Contributions are welcome. This is an open project — fork it, improve it, open a PR.

## How to contribute

1. Fork the repository.
2. Create a feature branch: `git checkout -b feat/your-change`.
3. Make your changes.
4. Validate locally (see below).
5. Open a pull request.

## What makes a good PR

- **Changes to quality standards or anti-patterns include a rationale.** A standard is a claim that
  some code "deserves to exist" or doesn't — say why.
- **New trigger phrases cover a real user intent, not just synonyms.** The description is already
  near the length limit; every added phrase should earn its place.
- **Keep the skill and agent self-consistent.** The verdict scale, severity tags, and terminology
  must be identical across `SKILL.md`, `agents/code-reviewer.md`, `references/quality-standards.md`,
  `examples.md`, and `README.md`. If you change one, change all of them.
- **New behavior gets an example.** If a change affects review output, add or update a worked review
  in `examples.md` so the behavior is demonstrated and regression-checkable.

## The source of truth

`skills/critical-reviewer/` is the source of truth. All platforms (Claude Code, GitHub Copilot CLI,
OpenCode) reference the same skill files. Don't fork behavior per platform.

## Validate before you push

The plugin ships with CI that runs the official validator in `--strict` mode. Run the same checks
locally first:

```bash
# Official plugin/skill/agent frontmatter + manifest validation (must be clean, no warnings)
claude plugin validate ./ --strict

# JSON manifests must parse
jq . .claude-plugin/plugin.json .claude-plugin/marketplace.json > /dev/null
```

If you change any file, confirm the verdict terms and severity tags still match across every file:

```bash
grep -rn "catastrophe\|needs-work" skills agents README.md
```

## Issues and ideas

Open an issue on GitHub. Bug reports, feature requests, and suggestions for new quality standards
(especially in the Security and Performance sections) are all welcome.
