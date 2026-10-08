<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Cron (mcp_tools_cron) — agent index

Submodule of **mcp_tools**. Adds Tool API plugins that let an MCP/AI connection run and
inspect Drupal cron and queue workers. Package *MCP Tools*. Core `^10.3 || ^11 || ^12`.
Depends on **mcp_tools** only. No routes, no forms, no config of its own.

- **The five tools, their inputs/outputs, scopes and how access is enforced** →
  [tools/cron-tools.md](tools/cron-tools.md)

## What it provides

- Five `tool` plugins in `src/Plugin/tool/Tool/`, all extending
  `Drupal\mcp_tools\Tool\McpToolsToolBase` with `MCP_CATEGORY = 'cron'`:
  `GetCronStatus` (`mcp_cron_get_status`, Read), `RunCron` (`mcp_cron_run`, Write),
  `RunQueue` (`mcp_cron_run_queue`, Write), `UpdateCronSettings`
  (`mcp_cron_update_settings`, Write), `ResetCronKey` (`mcp_cron_reset_key`, Write).
- One service `mcp_tools_cron.cron_service` (`Service/CronService.php`) wrapping core
  `@cron`, `@state`, `@config.factory`, `@module_handler`, `@queue`, and the queue-worker
  plugin manager.
- One permission (`mcp_tools_cron.permissions.yml`): **`mcp_tools use cron`**
  (`restrict access: true`).

## Access model (inherited)

Every tool is gated by `McpToolsToolBase::checkAccess()` — permission `mcp_tools use cron`
plus the connection scope for the tool's operation (Read→read scope, Write→write scope) plus
the write-kind policy (`cron` maps to write-kind **ops**) plus the global read-only switch.
Write tools additionally re-check `AccessManager::checkWriteAccess()` inside `executeLegacy()`.
See [tools/cron-tools.md](tools/cron-tools.md).

## Operate

```bash
drush en mcp_tools_cron -y
```

Then grant `mcp_tools use cron` to the role/executor account the MCP connection runs as. The
tools appear in the MCP tool list once the module is enabled.
