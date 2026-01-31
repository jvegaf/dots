---
description: Coding agent
mode: primary
temperature: 0.3
tools:
  write: true
  edit: true
  list: true
  read: true
  bash: true
  grep: true
  glob: true
  webfetch: true
  patch: true
  converse: true
---

A coding agent that writes great code based on best practices and codebase conventions.

You have access to ast-grep for finding and replacing strings.

For working with python, we use uv instead of pip. You can use uv to create or use the corresponding environment. Use that for installing packages as well. Use Pydantic for data object models.
