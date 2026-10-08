<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Ultimate Cron (mcp_tools_ultimate_cron) — agent index

Submodule of **mcp_tools**. Adds Tool API plugins for managing **Ultimate Cron** jobs —
list, inspect, read logs, enable, disable, and run individual jobs — from an MCP/AI
connection. Package *MCP Tools*. Core `^10.3 || ^11 || ^12`. Depends on **mcp_tools** and
**ultimate_cron**. No routes, forms, or config of its own.

- **The six tools, inputs/outputs, scopes and enforcement** →
  [tools/ultimate-cron-tools.md](tools/ultimate-cron-tools.md)

## What it provides

- Six `tool` plugins in `src/Plugin/tool/Tool/`, all extending `McpToolsToolBase` with
  `MCP_CATEGORY = 'ultimate_cron'`: `ListJobs` (`mcp_ultimate_cron_list_jobs`, Read),
  `GetJob` (`mcp_ultimate_cron_get_job`, Read), `GetJobLogs` (`mcp_ultimate_cron_logs`, Read),
  `EnableJob` (`mcp_ultimate_cron_enable`, Write), `DisableJob` (`mcp_ultimate_cron_disable`,
  Write), `RunJob` (`mcp_ultimate_cron_run`, Write).
- One service `mcp_tools_ultimate_cron.ultimate_cron_service`
  (`Service/UltimateCronService.php`) over `@entity_type.manager` (the `ultimate_cron_job`
  storage), `@database`, `@logger.factory`.
- One permission: **`mcp_tools use ultimate_cron`** (`restrict access: true`).

## Access model (inherited)

Gated by `McpToolsToolBase::checkAccess()` — `mcp_tools use ultimate_cron` + operation scope
(Read→read, Write→write) + write-kind (`ultimate_cron` → **ops**) + read-only switch. Write
tools re-check `AccessManager::checkWriteAccess()` in `executeLegacy()`. See
[tools/ultimate-cron-tools.md](tools/ultimate-cron-tools.md).

## Operate

```bash
drush en mcp_tools_ultimate_cron -y
```

Requires the Ultimate Cron module. Grant `mcp_tools use ultimate_cron` to the executor role.
