# critical-reviewer

A cross-platform Claude Skill, GitHub Copilot CLI Skill, and OpenCode Skill for direct, artifact-focused code review and architecture critique. Professional but uncompromising — critiques the code, not the person.

This is a [Claude Skill](https://github.com/anthropics/skills) — a folder of instructions the AI loads on demand. When you ask for a critical review, this skill takes over with direct, structured feedback.

---

## What you get

| Component | Type | What it does |
|---|---|---|
| `/critical-reviewer` | **Skill** | Communication style — opens with the most important finding. Direct, artifact-focused, bilingual (EN/PL). |
| `code-reviewer` | **Agent** | Focused code review — reads the codebase, applies quality standards, produces a structured verdict. Read-only. |

**Skill** = persona that shapes how the AI communicates. Lazy-loaded on first trigger, then stays active for the rest of the session.
**Agent** = focused subprocess for code review. Spawns in its own context, returns structured results, never modifies files.

---

## When to use this skill

| Situation | Use this? |
|---|---|
| "Review this PR" | **Yes** |
| "Critique this architecture" | **Yes** |
| "Is this solution correct?" | **Yes** |
| "What am I missing?" | **Yes** |
| "be direct" / "bez ściemy" | **Yes** |
| "check this idea" | **Yes** |
| Writing code / building features | No — normal AI behavior applies |

---

## Install

### Claude Code — Plugin Marketplace (recommended)

```bash
/plugin marketplace add konraddzbik/critical-reviewer-skill
/plugin install critical-reviewer
```

That's it. The skill activates automatically whenever you ask for a review.

### Claude Code — manual clone

Personal install (available in all your projects):

```bash
git clone https://github.com/konraddzbik/critical-reviewer-skill \
  ~/.claude/skills/critical-reviewer
```

Project install (committed to a repo, shared with your team):

```bash
git clone https://github.com/konraddzbik/critical-reviewer-skill \
  .claude/skills/critical-reviewer
```

### GitHub Copilot CLI

Requires [GitHub CLI](https://cli.github.com/) ≥ 2.90.0:

```bash
gh skill install konraddzbik/critical-reviewer-skill critical-reviewer
```

The skill is installed to `.github/skills/` in your current project by default. To install it globally for all projects:

```bash
gh skill install konraddzbik/critical-reviewer-skill critical-reviewer --scope user
```

If you're already in a `copilot` session, reload without restarting:

```
/skills reload
```

### OpenCode — manual clone

Personal install (available in all your projects):

```bash
git clone https://github.com/konraddzbik/critical-reviewer-skill \
  ~/.config/opencode/skills/critical-reviewer
```

Project install (committed to a repo):

```bash
git clone https://github.com/konraddzbik/critical-reviewer-skill \
  .opencode/skills/critical-reviewer
```

> **Note:** OpenCode also auto-discovers skills from `.claude/skills/` — clone to that path instead if you prefer unified config.

---

## Usage

### Trigger phrases

The skill activates when you say:
- "review this", "critique this", "be direct"
- "check this idea", "verify this solution", "is this correct"
- "what am I missing", "does this make sense", "sanity check"
- "co jest nie tak", "powiedz wprost", "bez ściemy", "szczera ocena"
- Or any request for direct technical feedback

### Agent usage

For structured code reviews with file-level findings:

- **Claude Code**: "review this PR" or "review the diff"
- **Copilot CLI**: "review this" (agent may auto-delegate)
- **OpenCode**: "review this code" (agent may auto-delegate)

The agent reads your codebase, applies quality standards from `references/quality-standards.md`, and produces:

```
[2-3 sentence opening: the most important finding]

**Verdict: [catastrophe | poor | needs-work | solid | clean]**

**Issues:**
1. `file:line` — [one sentence, specific, actionable]
...

**What's good:**
[If anything stands out]

**Summary:**
[One sentence: what to do next]
```

---

## Verdict scale

| Verdict | Meaning | Action |
|---|---|---|
| **catastrophe** | Security hole, data loss, fundamentally wrong | Stop. Do not deploy. |
| **poor** | Broken where it matters | Fix before merge. |
| **needs-work** | Works, barely, with fragile assumptions | Not production-ready. |
| **solid** | Senior approves without comments | Ship it. |
| **clean** | Genuinely elegant. Rare. | This is the standard. |

---

## Languages

English and Polish. Direct technical critique in both. Language auto-detected from user input.

| EN | PL |
|---|---|
| catastrophe | katastrofa |
| poor | słabe |
| needs-work | do poprawy |
| solid | solidne |
| clean | czyste |

---

## Repo structure

```
critical-reviewer-skill/
├── .claude-plugin/                  # Claude Code plugin manifest
│   ├── plugin.json
│   └── marketplace.json
├── skills/                          # Source of truth
│   └── critical-reviewer/
│       ├── SKILL.md                 # Skill definition
│       └── references/
│           └── quality-standards.md
├── agents/                         # Agent definition
│   └── code-reviewer.md
└── README.md
```

The `skills/` directory is the source of truth. All platforms reference it.

---

## Contributing

Contributions are welcome! This is an open project — anyone can fork, improve, and submit PRs.

**How to contribute:**

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-change`)
3. Make your changes
4. Submit a pull request

**What makes a good PR:**
- Changes to quality standards or anti-patterns should include a rationale
- New trigger phrases should cover a real user intent, not just synonyms
- Keep the skill and agent self-consistent — if you update the verdict scale in one, update it in both

**Issues and ideas:** Open an issue on GitHub. Bug reports, feature requests, and suggestions for new quality standards are all welcome.

---

## License

MIT. See [LICENSE](LICENSE) file.