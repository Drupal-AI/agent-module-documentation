<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cron & queue tools

All plugins live in `src/Plugin/tool/Tool/` and delegate to
`mcp_tools_cron.cron_service` (`CronService`). `MCP_CATEGORY = 'cron'` on every one, so all
require the **`mcp_tools use cron`** permission. Category `cron` → write-kind **ops**.

| Tool id | Class | Op / scope | Inputs | Does |
|---|---|---|---|---|
| `mcp_cron_get_status` | `GetCronStatus` | Read / read | — | `CronService::getCronStatus()`: last run (`state system.cron_last`), autorun threshold (`config system.cron` `threshold.autorun`, default 10800), overdue flag, and the list of modules implementing `hook_cron`. |
| `mcp_cron_run` | `RunCron` | Write / write | — | `CronService::runCron()` calls core `@cron->run()`, returns duration and whether `system.cron_last` advanced. |
| `mcp_cron_run_queue` | `RunQueue` | Write / write | `queue` (string, required), `limit` (int, default 100) | Claims and processes up to `limit` items of one named queue via the queue-worker plugin manager; returns `processed` / `remaining`. |
| `mcp_cron_update_settings` | `UpdateCronSettings` | Write / write | `threshold` (int, required, seconds ≥ 0) | `CronService::updateSettings()` writes `system.cron` `threshold.autorun` (editable config). |
| `mcp_cron_reset_key` | `ResetCronKey` | Write / write | — | Generates a new `state system.cron_key` (invalidates the old `/cron/<key>` URL). |

## Access enforcement

Two layers apply to the Write tools:

1. `McpToolsToolBase::checkAccess()` — `mcp_tools use cron` + the operation scope + `ops`
   write-kind policy + not read-only mode.
2. Inside `executeLegacy()` each tool re-calls `AccessManager::checkWriteAccess($op, $entity)`:
   `RunCron`/`RunQueue` pass `'run'` and `UpdateCronSettings` passes `'update'` (both map to
   the generic **write** bucket), while `ResetCronKey` passes `'admin'` (requires
   `AccessManager::canAdmin()`, i.e. the **admin** scope). Successful writes are recorded via
   `mcp_tools.audit_logger`.

## Notes

- These are operational (not entity) actions; there is no per-entity access check because the
  operations are site-global.
