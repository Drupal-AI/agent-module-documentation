<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Sentinel Drush commands

Inspection commands use their exit code for health (non-zero = attention). Maintenance commands mirror cron work.

## Core module (`mcp_sentinel`)
- `mcp-sentinel:status` (`mcps:status`) — print readiness contract, active policy, audit, and lock state. Non-zero exit if the source contract or config-governance floor is not ready.
- `mcp-sentinel:verify` (`mcps:verify`) — secure-install evidence document. Posture checks always run (never write). `--live` adds hostile-input probes (still no writes: allowed draft, denied publication, mass read, config change, live-content edit). Options: `--live`, `--content-target=UUID`, `--bundle=TYPE`, `--json`. A **skipped** check fails the run; `n/a` does not. See `docs/verification.md`.
- `mcp-sentinel:audit-verify` (`mcps:audit-verify`) — walk the tamper-evident hash chain; non-zero exit + first broken row id on tamper. Persists the outcome to state for the dashboard widget.
- `mcp-sentinel:audit-purge` (`mcps:audit-purge`) — delete audit rows past retention (0 = forever = no-op).
- `mcp-sentinel:role-audit` (`mcps:role-audit`) — **deploy gate**: non-zero exit if any governed role holds a permission its profile forbids (`forbidden_role_permissions`). Run after `config:import`.
- `mcp-sentinel:sql-query` (`mcps:sqlq`) — the ONLY governed raw-SQL path (`drush sql:query` bypasses all governance). Three fail-closed gates: governance on, audit on; profile `allow_raw_sql` (ships FALSE); `McpRawSqlGuard` accepts the statement (single SELECT over entity tables, no `SELECT *` on a redacted-column table, no denied types/columns). Every run — refused ones too — is written to the chain with its statement text.
- `mcp-sentinel:lock-clear` (`mcps:lock-clear`) — release expired content locks.
- `mcp-sentinel:webhook-prune` (`mcps:webhook-prune`) — delete webhook delivery rows past retention.
- `mcp-sentinel:webhook-replay <deliveryId>` (`mcps:webhook-replay`) — reset a delivery row to pending and re-queue (replays the stored payload byte-for-byte).

## Approval submodule (`mcp_sentinel_approval`)
- `mcp-sentinel:break-glass` (`mcps:break-glass`) — grant a time-boxed, HMAC-sealed, single-use `mcp_admin` role. Refuses on uid 1, an existing `is_admin` account, a missing signing key, or a role outside the shipped permission allowlist.

## Server submodule (`mcp_sentinel_server`)
- `mcp-sentinel:setup` (`mcps:setup`) — production setup; requires OAuth by default and preflights every Tool.
- `mcp-sentinel:agent-provision` (`mcps:provision`) — create/own the Consumer/account/profile designation (enables client_credentials grant, binds default user); never creates or rotates secrets.
- `mcp-sentinel:agent-reconcile` (`msar`) — idempotently re-provision every declared principal (`agent_provision_tiers`); a wiped principal heals on the next run.
- `mcp-sentinel:teardown` (`mcps:teardown`) — remove the provisioned wiring.
