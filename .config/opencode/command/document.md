---
description: Generate documentation for what was implemented during the current session. Analyzes session history, modified files, and code to produce clear, structured documentation. Best run after a successful execute or commit.
agent: documentation
---

# Generate Session Documentation

You are tasked with generating comprehensive documentation for everything implemented during this session.

## Process

### Step 1: Session Context Discovery

1. **Review the conversation history** to understand what was built, changed, or fixed:
   - Identify the main feature, fix, or refactor that was implemented
   - Note the ticket or plan that drove the implementation (if any)
   - Collect the key decisions made during implementation

2. **Inspect git changes** to get a concrete picture of what changed:
   - Run `git status` to see the current state of the working tree
   - Run `git log --oneline -10` to see recent commits
   - Run `git diff HEAD~1` (or against the relevant base commit) to see the actual diff
   - If no commits yet, use `git diff` for staged/unstaged changes

3. **Read all modified files fully** (no limit/offset) to understand the final implementation:
   - Focus on new files and the most changed files
   - Understand public APIs, exported symbols, and entry points
   - Identify non-obvious patterns, design decisions, or caveats worth documenting

### Step 2: Identify Documentation Scope

Based on the session analysis, determine what type(s) of documentation are needed:

| Type | When to generate |
|------|-----------------|
| **API / Interface docs** | New functions, classes, modules, or HTTP endpoints were added/changed |
| **Architecture / Design notes** | New subsystems, patterns, or structural decisions were introduced |
| **Usage guide** | New CLI commands, configuration options, or user-facing features |
| **Inline code comments** | Complex logic, non-obvious algorithms, or tricky edge cases in modified code |
| **Changelog entry** | Any user-facing or developer-facing change worth recording |
| **ADR (Architecture Decision Record)** | A significant design decision was made that future maintainers should understand |

Ask the user which types are relevant if unclear, otherwise include all that apply.

### Step 3: Spawn Research Tasks (if needed)

For large or complex implementations, spawn parallel agents to gather context:

- **codebase-analyzer** — to understand how the new code fits into the broader system
- **codebase-pattern-finder** — to find existing documentation examples to model after
- **thoughts-locator** — to find any existing design docs, ADRs, or notes in `thoughts/`

Wait for all agents to complete before writing.

### Step 4: Write the Documentation

#### 4a. Inline Code Comments

For complex or non-obvious code blocks in the modified files:
- Add `AIDEV-NOTE:` comments explaining *why* something works the way it does
- Do NOT explain *what* the code does — only add comments where the reason is not obvious
- Keep comments concise (1–3 lines max per comment)
- Never remove existing `AIDEV-NOTE`, `AIDEV-TODO`, or `AIDEV-QUESTION` comments

#### 4b. Formal Documentation File

Write a documentation file to `thoughts/docs/{descriptive_name}.md`:

```markdown
---
date: [Current date and time with timezone in ISO format]
git_commit: [current HEAD SHA from `git rev-parse HEAD`]
branch: [current branch from `git branch --show-current`]
repository: [repo name from `git remote get-url origin` or directory name]
topic: "[Short description of what was documented]"
tags: [docs, relevant-component-names, feature|fix|refactor]
session_type: [feature|fix|refactor|debt]
last_updated: [same as date, initially]
---

# [Feature / Fix / Refactor Name] — Documentation

## Overview

[1–3 sentence summary of what was implemented and why.]

## What Changed

### [Component or File Group 1]
**Files**: `path/to/file.ext`, `path/to/other.ext`

[Description of what changed and the reasoning behind the approach.]

```[language]
// Representative example or key snippet (only if it aids understanding)
```

### [Component or File Group 2]
**Files**: `path/to/file.ext`

[Description of what changed.]

---

## API Reference

> Only include this section if new public APIs, interfaces, or endpoints were added.

### `functionName(param: Type): ReturnType`

[Description of what this function does, its parameters, return value, and any important side effects.]

**Parameters:**
- `param` — [description]

**Returns:** [description]

**Example:**
```[language]
// Usage example
```

---

## Architecture Notes

> Only include this section if a significant structural or design decision was made.

[Describe the design choice, why it was made, and what alternatives were considered.]

---

## Usage Guide

> Only include this section for user-facing features, CLI commands, or new configuration options.

### [Feature / Command Name]

[Step-by-step instructions or configuration examples.]

```[language]
// Example usage
```

---

## Configuration

> Only include this section if new environment variables, config options, or feature flags were introduced.

| Variable / Key | Type | Default | Description |
|---------------|------|---------|-------------|
| `EXAMPLE_VAR` | string | `""` | What this controls |

---

## Known Limitations & Edge Cases

- [Any known limitation, gotcha, or edge case developers should be aware of]
- [Performance considerations if relevant]

---

## Testing

### How to Verify

```bash
# Commands to verify the implementation works
```

### Manual Verification Steps
1. [Step to verify feature works end-to-end]
2. [Edge case to test manually]

---

## References

- Plan: `thoughts/plans/[related-plan].md` (if applicable)
- Ticket: `thoughts/tickets/[related-ticket].md` (if applicable)
- Research: `thoughts/research/[related-research].md` (if applicable)
- Related code: `[file:line]`
```

#### 4c. Changelog Entry

Append an entry to `CHANGELOG.md` (or create it if it doesn't exist) following the [Keep a Changelog](https://keepachangelog.com) format:

```markdown
## [Unreleased]

### Added
- [New feature or capability — user-facing description]

### Changed
- [Modification to existing behavior]

### Fixed
- [Bug fix — what was broken and what it does now]

### Removed
- [Removed functionality]
```

Only include subsections that apply. Skip this step if the project has no `CHANGELOG.md` and the change is purely internal/refactor.

### Step 5: Review & Confirm

Present a summary to the user:

```
I've generated the following documentation for this session:

📄 **Formal doc**: `thoughts/docs/[filename].md`
✏️  **Inline comments**: Added AIDEV-NOTE comments to [N] files
📝 **Changelog**: Appended entry to CHANGELOG.md (if applicable)

Key decisions documented:
- [Decision 1]
- [Decision 2]

Is there anything I missed, or would you like me to expand on any section?
```

Iterate based on feedback.

### Step 6: Update Ticket/Plan Status (if applicable)

If the session was driven by a ticket or plan:
- Update the ticket's frontmatter `status` to `documented`
- Update the plan file if any new information warrants it

Use the todowrite tool to create a structured task list for the 6 steps above, marking each as pending initially.

---

## Important Guidelines

1. **Document the *why*, not just the *what***:
   - The code itself shows *what* it does; documentation explains *why* it works that way
   - Capture design tradeoffs, rejected alternatives, and non-obvious constraints

2. **Be concise but complete**:
   - Avoid padding — every sentence should add value
   - Include code examples only when they genuinely aid understanding

3. **Stay accurate**:
   - Only document what was actually implemented — never speculate
   - Cross-reference the git diff to ensure nothing is missed or fabricated

4. **Follow existing conventions**:
   - Match the style of existing docs in `thoughts/` and the codebase
   - Use the same terminology as the codebase (see Domain Glossary in AGENTS.md)

5. **Anchor comments**:
   - Add `AIDEV-NOTE:` where code is complex, surprising, or carries important caveats
   - Never delete or alter existing `AIDEV-*` comments

6. **Do not use task subagents for simple sessions**:
   - If the session was small (< 5 files changed), do all work directly in main context
   - Only spawn sub-agents for large or complex implementations

**session_context**

$ARGUMENTS
