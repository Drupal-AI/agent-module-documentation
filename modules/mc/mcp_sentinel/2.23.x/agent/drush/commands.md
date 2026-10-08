<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands (top-level module)

Provided by `McpSentinelCommands` and `McpSentinelSqlCommands` (`src/Drush/Commands/`). Submodules add their own
(`mcp-sentinel:break-glass` in approval; `mcp-sentinel:setup`/`teardown`/`agent-provision`/`agent-reconcile` in server).

- `mcp-sentinel:status` (`mcps:status`) — print source-contract readiness, active policy, audit, and lock state.
- `mcp-sentinel:verify` (`mcps:verify`) — read-only posture checks. `--live` also runs hostile-input probes (nothing
  is saved); `--content-target=UUID --json` adds JSON evidence.
- `mcp-sentinel:audit-verify` (`mcps:audit-verify`) — verify the tamper-evident audit-log hash chain.
- `mcp-sentinel:role-audit` (`mcps:role-audit`) — exit non-zero if a governed role holds a permission its policy
  profile forbids (escape-hatch detection); mirrors the status-report ERROR.
- `mcp-sentinel:audit-purge` (`mcps:audit-purge`) — delete audit entries past retention now (also on cron).
- `mcp-sentinel:lock-clear` (`mcps:lock-clear`) — release expired content locks now (also on cron).
- `mcp-sentinel:webhook-prune` (`mcps:webhook-prune`) — delete webhook delivery rows past retention.
- `mcp-sentinel:webhook-replay <id>` (`mcps:webhook-replay`) — reset a delivery to pending and re-queue it.
- `mcp-sentinel:sql-query '<SELECT …>'` (`mcps:sqlq`) — run a **governed** raw SQL read inside Drupal. Off unless the
  resolved profile sets `allow_raw_sql: true`. `McpRawSqlGuard` fail-closes: statement length cap, dangerous functions
  refused anywhere (`load_file`, `sleep`, `benchmark`, …), unmapped tables refused, and any redacted column refused in
  the select list, WHERE, or ORDER BY. Deny lists, DLP, exfiltration budgets, and the audit chain still apply.
  Supports `--profile=<id>`.

Note `drush sql:query` (core) is **not** governed — it bootstraps below where module command files load, so no hook
can fire. Use `mcp-sentinel:sql-query` for a governed read; host shell/DB credentials are outside this module's
threat model.
