<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The MCP tools (`audit_chain_mcp`)

Four `drupal/tool` plugins in `src/Plugin/tool/Tool/`, each declared with a `#[Tool(...)]` attribute
and extending `AuditChainToolBase`. They are discovered and executed through MCP Sentinel's governed
tool runner. All read from the parent module's own services — they never query the log table directly.

## Shared base — `AuditChainToolBase`

Extends `McpGovernedToolBase` (with `McpEntityToolTrait`). Every subclass implements `run(array
$values): array`; the base's `doExecute()`:

1. Re-checks `checkAccess()` for direct PHP callers (`ToolBase::execute()` does not call `access()`).
2. Resolves an MCP Sentinel governance profile (`governancePolicyResolver->resolve()`); NULL → refuse.
3. Applies the profile **rate limit** (`checkRateLimit()`).
4. Runs `run()`, then enforces a **response-size cap** = `min(MAX_RESULT_BYTES = 131072, profile
   response-size cap)` via the optional `mcp_sentinel.exfiltration_guard`.
5. On any `Throwable`, logs only the exception **class/file/line** (never the message, which could
   carry caller input) and returns the one fixed refusal `ExecutableResult::failure(...)`.

Access (`checkGovernedAccess()` / `checkGovernedDiscoveryAccess()`): `allowedIfHasPermissions` over
`use audit chain mcp tools` plus any `extraPermissions()`, `setCacheMaxAge(0)`.

**Field-by-field reduction** keeps internals out of results: `verdictFields()` emits `time, ok,
reason, keyed, broken_at, unkeyed_rows, unkeyed_through, verified_from, sealed_through, seal_intact`;
`successorFields()` emits `segment_ok, historical_ok, reason, verified_rows`. Reasons outside the
known `REASON_*` / successor sets become `"other"`; the incident reference, segment id, historical
verdict, and any key identifier are dropped.

## Permissions (`audit_chain_mcp.permissions.yml`, both `restrict access: true`)

- **`use audit chain mcp tools`** — required by all four tools (read status, window counts, export
  status). Never returns rows, metadata, IPs, UAs, hashes, MACs or key ids.
- **`run audit chain verification via mcp`** — additionally required by `audit_chain_verify_now`.

## The tools

| Tool id | Class | Operation | Extra perm | Returns |
|---|---|---|---|---|
| `audit_chain_status` | `StatusTool` | Read | — | `verification` (status/reason/last_run_time/rows), `last_run` (verdict fields), `signing.keyed` (bool only), `seal` (sealed_through_id/row_count/sealed_at or null), `recovery` (successor fields). Reads state; does **not** walk the chain. |
| `audit_chain_window_counts` | `WindowCountsTool` | Read | — | `windows` → per-window `{total, keyed, unkeyed}`. Optional `window` input (`24h`/`7d`/`30d`, `Choice`-constrained); omit for all three. An unknown window is **refused** (not silently mapped to 24h). Counts only. |
| `audit_chain_export_status` | `ExportStatusTool` | Read | — | `enabled`, `configured`, `destination` (`{kind, host}` — https/http/file, host only, no path/port/creds/query), `channel_filtered`, `channel` (only if it matches `^[a-z0-9_]{1,64}$`), `checkpoint` (`last_id`/`time`), `waiting`. Cannot export or change the destination. |
| `audit_chain_verify_now` | `VerifyNowTool` | **Trigger** | `run audit chain verification via mcp` | `ran` (bool) + verdict fields + `successor`. Calls `ScheduledVerifier::runNow()` **only** when the last recorded run is ≥ `MIN_INTERVAL` (60s) old; otherwise returns that run with `ran: false`. A real run is recorded exactly as cron's (logs failures, fires the verification-failed event); verification never changes the chain. |

Injected services: `StatusTool` uses `audit_chain.metrics`, `audit_chain.logger`, `state`;
`WindowCountsTool` uses `audit_chain.metrics`; `ExportStatusTool` uses `audit_chain.evidence_exporter`
+ `config.factory`; `VerifyNowTool` uses `audit_chain.scheduled_verifier`, `state`, `datetime.time`.
