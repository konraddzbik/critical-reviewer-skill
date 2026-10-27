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
  must be identical across `SKILL.md`, `references/quality-standards.md`, `examples.md`, and
  `README.md`. If you change one, change all of them. CI checks the verdict terms.
- **New behavior gets an example and an eval.** If a change affects review output, add or update a
  worked review in `examples.md` and a case in `evals/` (see below) so the behavior is demonstrated
  and regression-checked.
- **The agent doesn't duplicate the skill.** `agents/code-reviewer.md` preloads the skill and only adds
  the review workflow. Change the output format, verdicts, or tags in `SKILL.md`, not in the agent.

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

## Evals

`evals/<case>/prompt.md` is the user message (frontmatter sets `max_turns`, `allowed_tools`, `tags`);
`evals/<case>/graders/*.md` score the answer. Prefer cheap, deterministic `regex` / `tool_used`
graders for the contract (verdict, tags, ordering, language) and one `llm` judge for substance.
Write judges that check what matters and explicitly allow harmless extras — a judge that fails a good
review is a broken test.

```bash
claude plugin eval . --runs 2 --concurrency 4              # full suite, with vs without the plugin
claude plugin eval . --case polish-review --runs 1         # one case while iterating
```

Results land in `evals/results/` (gitignored). On GitHub, add the `run-evals` label to a PR to run
the suite in CI.

## Re-recording the README GIFs

The GIFs replay verbatim outputs from eval runs so the recordings are stable. To refresh one, put the
prompt on the first line of `demo/transcripts/<name>.txt` (`$ claude "…"`), paste the review below it
(wrapped to ~108 columns), and render with [VHS](https://github.com/charmbracelet/vhs). The prompt
lives in the transcript because VHS can't type non-ASCII characters such as `ś`.

```bash
for t in demo/*.tape; do vhs "$t"; done
```

## Issues and ideas

Open an issue on GitHub. Bug reports, feature requests, and suggestions for new quality standards
(especially in the Security and Performance sections) are all welcome.
