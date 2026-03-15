---
name: linear-mcporter
description: Use Linear from this repository through MCPorter. Trigger this when Codex, Claude Code, or similar coding agents need to list, read, create, or update Linear issues, projects, documents, comments, cycles, or status updates for Brew work from the liquid-glass-resources repo.
---

# Linear MCPorter

Use Linear through the repo-local MCPorter config.

## Config

Preferred working directory:

```bash
cd /Users/agent/Code/liquid-glass-resources
```

Project config:

```text
config/mcporter.json
```

If you are outside the repo root, pass the config explicitly:

```bash
mcporter --config /Users/agent/Code/liquid-glass-resources/config/mcporter.json call linear.list_teams --output json
```

## Rules

- Prefer `--output json`.
- Prefer `team=Brew` unless told otherwise.
- Do not guess IDs or status names; query first.
- Fetch existing issues/projects before updating them.
- If auth fails, tell the user MCPorter auth may need a reset.

## Common commands

```bash
mcporter config list
mcporter call linear.list_teams --output json
mcporter call linear.list_issues team=Brew --output json
mcporter call linear.list_issues team=Brew assignee=me --output json
mcporter call linear.list_issues team=Brew query="liquid glass" --output json
mcporter call linear.get_issue id=<issue-id> --output json
mcporter call linear.save_issue team=Brew title="Add X" description="..." priority=2 --output json
mcporter call linear.save_issue id=<issue-id> state="In Progress" --output json
mcporter call linear.save_comment issueId=<issue-id> body="Implemented in commit abc123" --output json
mcporter call linear.list_projects --output json
mcporter call linear.list_documents query="Liquid Glass" --output json
mcporter call linear.list_issue_statuses team=Brew --output json
mcporter call linear.list_issue_labels --output json
mcporter call linear.list_users --output json
```

## Brew defaults

- Team name: `Brew`
- Team id: `fdb2cc6d-5f45-4c45-a4b6-614821dc2a5b`
