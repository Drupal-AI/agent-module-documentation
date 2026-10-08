<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Sentinel permissions

## Core module (`mcp_sentinel.permissions.yml`)
- **`administer mcp sentinel`** (`restrict access: true`) — configure MCP access, audit logs, webhook settings. Gates the settings form, verify-chain, and all webhook-delivery admin routes.
- **`view mcp sentinel audit log`** — view the audit log / dashboard / export and the banner-dismiss route.
- **`access mcp sentinel context`** (`restrict access: true`) — access the OAuth-authenticated `/drupal-mcp/context` and `/drupal-mcp/readiness` endpoints. **Grant to the MCP API user (agent principal) only.**

`/drupal-mcp/health` is intentionally public (`_access: TRUE`) — returns only an ok/disabled status and the module name, no data.

## Approval submodule (`mcp_sentinel_approval.permissions.yml`)
- **`approve mcp sentinel operations`** (`restrict access: true`) — approve or deny governed destructive operations queued for human approval. Held by a standing second person; deliberately **excluded** from the shipped break-glass `mcp_admin` role (separation of duties). The requester of an operation cannot approve their own request.

## Break-glass `mcp_admin` role (shipped in approval `config/optional`)
A non-admin, time-boxed elevation role with five permissions: access administration pages, view the administration
theme, access site reports, view mcp sentinel audit log, administer mcp sentinel. Its permission set must stay
identical to `McpBreakGlassManager::ALLOWED_PERMISSIONS`; an `is_admin` or over-permissioned `mcp_admin` is an ERROR
on the status report and is refused at grant time. Active grants are force-revoked on cron if the role becomes unsafe.
