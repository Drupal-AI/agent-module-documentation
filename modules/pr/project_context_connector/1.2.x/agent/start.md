<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Project Context Connector — agent index

**Exposes sanitized, read-only project-context JSON endpoints + a Drush command** (for Slack/Teams prompt
building). Depends on `tool`, `mcp_server`. Provides permissions. Version **1.2.0**. Core `^10||^11`.

Developer/integration — snapshot gated by `access project context snapshot`; a signed endpoint uses a **signature
access check**. Context is project/infra metadata (keep the permission to trusted users, secure the signing secret,
verify sanitized output has no secrets).
