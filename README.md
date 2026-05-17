# critical-reviewer

A Claude Code plugin for direct, artifact-focused code review and architecture critique. Professional but uncompromising — critiques the code, not the person.

## Components

| Component | Type | What it does |
|---|---|---|
| `/critical-reviewer` | **Skill** | Communication style — opens with the most important finding. Direct, artifact-focused, bilingual (EN/PL). |
| `code-reviewer` | **Agent** | Focused code review — reads the codebase, applies quality standards, produces a structured verdict. Read-only. |

**Skill** = persona that shapes how Claude communicates. Lazy-loaded on first trigger, then stays active for the rest of the session.
**Agent** = focused subprocess for code review. Spawns in its own context, returns structured results, never modifies files.

## Installation

> All commands below that start with `/` are **Claude Code slash commands** — run them inside a Claude Code session (CLI, desktop app, or IDE extension), not in a regular terminal.

### Option A: Install as a plugin (recommended)

Inside Claude Code, add this repo as a marketplace and install:

```
/plugin marketplace add konraddzbik/critical-reviewer-skill
/plugin install critical-reviewer
```

This registers the skill and the agent. They're available in every project from that point on.

### Option B: Test locally before installing

Clone and load as a local plugin for one session:

```bash
git clone https://github.com/konraddzbik/critical-reviewer-skill.git
claude --plugin-dir ./critical-reviewer-skill
```

The skill and agent are active for that session only. Install with Option A when satisfied.

### Verify installation

After installing, type `/critical-reviewer` inside Claude Code — the skill should appear in the list. To test the agent, say "review this code" in a project with source files.

### Option C: Copy into your project (no plugin system)

Copy the skill and agent files into your project's `.claude/` directory:

```bash
# From this repo's root
mkdir -p your-project/.claude/skills/critical-reviewer/references
mkdir -p your-project/.claude/agents

cp skills/critical-reviewer/SKILL.md your-project/.claude/skills/critical-reviewer/
cp skills/critical-reviewer/references/quality-standards.md your-project/.claude/skills/critical-reviewer/references/
cp agents/code-reviewer.md your-project/.claude/agents/
```

Result:

```
your-project/
├── CLAUDE.md                           # your project's CLAUDE.md (see Mode 2 below for always-on snippet)
└── .claude/
    ├── skills/
    │   └── critical-reviewer/
    │       ├── SKILL.md
    │       └── references/
    │           └── quality-standards.md
    └── agents/
        └── code-reviewer.md
```

This works without the plugin system. The skill and agent are scoped to that project only. The `CLAUDE.md` shown above is YOUR project's file — not one from this repo.

## Usage modes

### Mode 1: On-demand (default after install)

After installing, the skill and agent are **available but not always active**:

- **Skill fires** when you say things like "review this", "be direct", "critique this", "co jest nie tak" — or when you type `/critical-reviewer` manually
- **Agent fires** when Claude detects a focused review task ("review this PR", "what's wrong with this code")
- **Normal coding** uses standard Claude behavior until something triggers the skill or agent

Once the skill fires, it stays loaded for the rest of the session — every subsequent response uses the direct, artifact-focused style.

### Mode 2: Always-on persona

If you want the direct style on **every** response from session start, add this to your project's `CLAUDE.md`:

```markdown
## Active Skills

### critical-reviewer (always active)

Always use the critical-reviewer skill's communication style. Load it at the
start of every session. It is not optional.

Key behaviors:
- Every response opens with the most important finding. No exceptions.
- Critique in the language the user writes in. Polish → Polish. English → English.
- Underspecified requests get called out for missing context, then answered anyway.
- Bad decisions get flagged even if the team already agreed on them.
- Good code gets clear, unqualified acknowledgment.
```

This tells Claude to invoke the skill immediately, so even building and debugging work uses the critical-reviewer style.

### When does what fire?

| You're doing | Skill | Agent |
|---|---|---|
| Writing code, building features | Only if already loaded or CLAUDE.md forces it | No |
| "review this" / "critique this" | Auto-invokes, stays loaded | Claude may delegate here instead |
| "review this PR" / "review the diff" | May fire | Yes — agent spawns, reviews, returns results |
| Coding after a review happened | Yes — stays loaded from earlier | No — agent context is gone |
| Session start (with CLAUDE.md snippet) | Yes — loaded immediately | Only when review is requested |

## What it does

| You say | You get |
|---|---|
| Show code for review | Structured review: verdict + `file:line` issues + what's good |
| "fix this" (no context) | Note about missing context + best guess + actual fix |
| "review this PR" | Agent scans the diff, applies quality standards, returns verdict |
| "co myślisz?" | Polish critique + Polish feedback + actual help |
| Good code | Clear, unqualified acknowledgment |
| "The team agreed on X" | "Show the technical argument, not the headcount." |

## Verdict scale

| Verdict | Meaning | Action |
|---|---|---|
| **catastrophe** | Security hole, data loss, fundamentally wrong | Stop. Do not deploy. |
| **poor** | Broken where it matters | Fix before merge. |
| **needs-work** | Functional but fragile | Not production-ready. |
| **solid** | Senior approves without comments | Ship it. |
| **clean** | Genuinely elegant. Rare. | This is the standard. |

## Plugin structure

```
critical-reviewer-skill/
├── .claude-plugin/
│   ├── plugin.json                  # plugin manifest
│   └── marketplace.json             # marketplace registry
├── skills/
│   └── critical-reviewer/
│       ├── SKILL.md                 # persona + communication style + quality rules
│       └── references/
│           └── quality-standards.md  # quality baseline (Karpathy/Marko/Pocock)
├── agents/
│   └── code-reviewer.md             # focused review agent (read-only)
└── README.md
```

## Sharing with your team

**Via marketplace (recommended):** Team members add the marketplace once, then install by name:
```
/plugin marketplace add konraddzbik/critical-reviewer-skill
/plugin install critical-reviewer
```

**Fork (for customization):** Fork this repo, adjust skill/agent/quality-standards to your team's conventions, install from your fork URL.

## Languages

English and Polish. Direct technical critique in both. Language auto-detected from user input.

## Contributing

Contributions are welcome. To get started:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-change`)
3. Make your changes — follow the same artifact-focused, direct style used in the skill itself
4. Submit a pull request with a clear description of what changed and why

**What makes a good PR:**
- Changes to quality standards or anti-patterns should include a rationale
- New trigger phrases should cover a real user intent, not just synonyms
- Keep the skill and agent self-consistent — if you update the verdict scale in one, update it in both

**Issues and ideas:** Open an issue on GitHub. Bug reports, feature requests, and suggestions for new quality standards are all welcome.

## License

This project is licensed under the [MIT License](LICENSE).

Permission is hereby granted, free of charge, to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of this software. See the LICENSE file for full terms.
