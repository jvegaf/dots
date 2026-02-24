---
description: Bump the project's minor version, commit all pending changes, create the corresponding git tag, and push everything to the remote. Run this command when a set of features is ready to be released as a new minor version.
agent: git-committer
---

# Release — Minor Version Bump

You are tasked with performing a clean minor version release: bump the version, commit everything, tag, and push.

## Process

Use the todowrite tool to create a structured task list for the steps below, marking each as pending initially.

---

### Step 1: Pre-flight Checks

Before touching anything, verify the environment is safe:

1. **Check the current branch:**
   - Run `git branch --show-current`
   - ⚠️ WARN the user and ask for confirmation if not on `main` or `master`

2. **Check remote sync status:**
   - Run `git status` and `git fetch origin`
   - If the local branch is **behind** the remote, STOP and tell the user:
     ```
     ⛔ Your branch is behind origin. Please pull first before releasing.
     ```
   - If there are **merge conflicts**, STOP and tell the user to resolve them

3. **Summarise pending changes:**
   - Run `git status -s` to list all tracked and untracked changes
   - Run `git log origin/$(git branch --show-current)..HEAD --oneline` to list commits not yet pushed
   - Present both to the user so they can confirm the release scope

---

### Step 2: Detect Versioning File

Search for a versioning source in this priority order:

| Priority | File | How to read version | How to bump |
|----------|------|---------------------|-------------|
| 1 | `package.json` (root) | `jq -r '.version' package.json` | `npm version minor --no-git-tag-version` |
| 2 | `pyproject.toml` | `grep '^version' pyproject.toml` | Edit `version = "X.Y.Z"` field directly |
| 3 | `Cargo.toml` | `grep '^version' Cargo.toml` | Edit `version = "X.Y.Z"` field directly |
| 4 | `VERSION` file | `cat VERSION` | Edit the file directly |
| 5 | Latest git tag | `git describe --tags --abbrev=0` | Compute next tag manually |

- If **none** of the above are found, ask the user where the version is stored before proceeding.
- If the version cannot be parsed as semver (`MAJOR.MINOR.PATCH`), STOP and ask for clarification.

---

### Step 3: Compute the New Version

Given the current version `MAJOR.MINOR.PATCH`, the new minor version is:

```
MAJOR.(MINOR + 1).0
```

Example: `1.3.7` → `1.4.0`

Present the version bump to the user:

```
Current version : 1.3.7
New version     : 1.4.0

Pending changes to be committed:
  M  src/foo.ts
  M  src/bar.ts
  ?? docs/new-guide.md

Commits not yet pushed:
  a1b2c3d feat: add new export format
  d4e5f6g fix: correct null check in parser

I will:
  1. Bump version to 1.4.0 in package.json
  2. Commit all pending changes with message: "chore: release v1.4.0 [AI]"
  3. Create annotated tag: v1.4.0
  4. Push commits + tag to origin

Shall I proceed? (yes / no)
```

**Wait for explicit user confirmation before continuing.**

---

### Step 4: Bump the Version

Once confirmed, apply the version bump to the versioning file identified in Step 2:

- **`package.json`**: Run `npm version minor --no-git-tag-version`
  - This edits `package.json` (and `package-lock.json` if present) but does NOT create a git commit or tag — we handle that ourselves.
- **`pyproject.toml` / `Cargo.toml` / `VERSION`**: Edit the file directly using the Edit tool, replacing the old version string with the new one.

Verify the bump was applied:
- Re-read the version field and confirm it matches the expected new version.

---

### Step 5: Commit All Changes

Stage and commit **all modified and untracked files** that are part of the release:

1. Run `git status -s` to get the full list of changed files
2. Stage files explicitly — **never use `git add -A` or `git add .`**:
   - Stage the version file first (e.g., `git add package.json`)
   - Stage all other changed project files (skip lock files, generated artifacts, `.env` files, and secrets)
   - If unsure whether a file should be included, ask the user
3. Create a single release commit:
   ```
   git commit -m "chore: release v{NEW_VERSION} [AI]"
   ```
4. Confirm the commit was created:
   ```
   git log --oneline -3
   ```

---

### Step 6: Create the Annotated Tag

Create an annotated tag pointing at the release commit:

```bash
git tag -a "v{NEW_VERSION}" -m "Release v{NEW_VERSION}"
```

- Always use the `v` prefix (e.g., `v1.4.0`)
- Always use an **annotated** tag (`-a`), never a lightweight tag
- Confirm the tag was created: `git tag --sort=-v:refname | head -5`

---

### Step 7: Push Commits and Tag

Push both the branch and the tag to origin:

```bash
git push origin $(git branch --show-current)
git push origin "v{NEW_VERSION}"
```

- Push the branch first, then the tag separately — avoids ambiguous ref issues
- If the push fails (e.g., rejected), STOP immediately and report the error to the user without retrying automatically

---

### Step 8: Confirm and Report

Print a final summary:

```
✅ Release v{NEW_VERSION} complete!

  Branch  : {branch} → pushed to origin
  Tag     : v{NEW_VERSION} → pushed to origin
  Commit  : {short SHA} — chore: release v{NEW_VERSION} [AI]

Next steps (optional):
  - Run /document to generate release documentation
  - Create a GitHub Release at: https://github.com/{owner}/{repo}/releases/new?tag=v{NEW_VERSION}
```

---

## Safety Rules

| Rule | Reason |
|------|--------|
| ❌ Never `push --force` | History rewrite risk |
| ❌ Never skip `--no-git-tag-version` on `npm version` | Prevents npm from creating its own uncontrolled commit/tag |
| ❌ Never commit `.env`, secrets, or lock files without asking | Security and noise |
| ❌ Never auto-push if push is rejected | Could mask a real conflict |
| ❌ Never proceed without user confirmation in Step 3 | Prevents accidental releases |
| ✅ Always use annotated tags | Carries metadata; plays well with `git describe` |
| ✅ Always push tag separately after the branch | Avoids ambiguous ref resolution |

---

## Semver Reference

| Type | When to use | Example |
|------|------------|---------|
| **Major** (`X+1.0.0`) | Breaking changes | `1.3.7` → `2.0.0` |
| **Minor** (`X.Y+1.0`) | New features, backward-compatible | `1.3.7` → `1.4.0` ← *this command* |
| **Patch** (`X.Y.Z+1`) | Bug fixes only | `1.3.7` → `1.3.8` |

**context**

$ARGUMENTS
