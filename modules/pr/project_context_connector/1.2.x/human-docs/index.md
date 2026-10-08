# Project Context Connector — manual setup guide

**Project Context Connector** (`project_context_connector`) exposes a **safe,
read-only JSON snapshot** of your Drupal site so external tools — AI agents,
Slack/Teams bots, CI/CD scripts, monitoring dashboards — can programmatically ask
"what Drupal version is running?", "which modules need security updates?", or
"what PHP version is production on?". It is read-only by design: no write
operations, no remote code execution, no telemetry.

The snapshot reports things like Drupal core version, PHP version, database
driver/version, active modules and themes with versions and security-update
status, and configuration flags such as maintenance mode, caching, error display,
and cron status. It deliberately excludes personal data, credentials, and
secrets.

You can reach the snapshot four ways: a permission-gated REST endpoint
(`GET /project-context-connector/snapshot`), an HMAC-signed endpoint that needs no
Drupal user (`GET /project-context-connector/snapshot/signed`), a Drush command
(`drush pcc:snapshot`), and — with the `mcp_server` module — a native
Model Context Protocol tool for AI assistants such as Claude Desktop.

Because the snapshot is effectively **project and infrastructure metadata**, treat
access to it as sensitive even though it is sanitized: keep the snapshot
permission to trusted users, protect the HMAC signing secret, and confirm the
output contains nothing sensitive for your particular setup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its `tool` / `mcp_server` dependencies.
2. [Configuration](configuration/index.md) — permissions, the signing secret,
   rate limiting, CORS, and what to expose.

## Where it lives in the admin menu

The module's settings are gated by the **Administer project context connector**
permission, and snapshot access by the **Access project context snapshot**
permission — grant both at **People → Permissions**
(`/admin/people/permissions`). See [Configuration](configuration/index.md) for the
details.
