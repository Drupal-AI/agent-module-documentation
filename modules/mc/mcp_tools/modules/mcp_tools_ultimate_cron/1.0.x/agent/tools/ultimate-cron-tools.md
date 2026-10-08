<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ultimate Cron tools

Plugins in `src/Plugin/tool/Tool/`, delegating to
`mcp_tools_ultimate_cron.ultimate_cron_service` (`UltimateCronService`), which loads the
`ultimate_cron_job` config entity storage. `MCP_CATEGORY = 'ultimate_cron'` → permission
**`mcp_tools use ultimate_cron`**, write-kind **ops**.

| Tool id | Class | Op / scope | Inputs | Does |
|---|---|---|---|---|
| `mcp_ultimate_cron_list_jobs` | `ListJobs` | Read / read | — | Lists all Ultimate Cron jobs with status/schedule. |
| `mcp_ultimate_cron_get_job` | `GetJob` | Read / read | `id` (string, required) | Detail for one job. |
| `mcp_ultimate_cron_logs` | `GetJobLogs` | Read / read | `id` (string, required), `limit` (int, default 50) | Recent execution log entries for a job (via `@database`). |
| `mcp_ultimate_cron_enable` | `EnableJob` | Write / write | `id` (string, required) | Enables a disabled job. |
| `mcp_ultimate_cron_disable` | `DisableJob` | Write / write | `id` (string, required) | Disables a job so it will not run. |
| `mcp_ultimate_cron_run` | `RunJob` | Write / write | `id` (string, required) | Executes one job immediately. |

## Access enforcement

`McpToolsToolBase::checkAccess()` applies `mcp_tools use ultimate_cron` + the operation scope
+ `ops` write-kind policy + read-only switch. In `executeLegacy()`, `EnableJob`, `DisableJob`,
and `RunJob` re-call `AccessManager::checkWriteAccess('enable'|'disable'|'run',
'ultimate_cron_job')` — all three map to the generic **write** bucket (write scope), not the
admin scope.

## Notes

- Jobs are `ultimate_cron_job` config entities; `id` is the job machine name (e.g.
  `system_cron`).
- Enable/disable persist to config; run triggers the job's callback immediately.
