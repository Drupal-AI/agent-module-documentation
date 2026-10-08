<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Scheduler (mcp_tools_scheduler) — agent index

Submodule of **mcp_tools**. Adds Tool API plugins that drive the contrib **Scheduler**
module — schedule content to publish/unpublish at a date/time, inspect and cancel schedules —
from an MCP/AI connection. Package *MCP Tools*. Core `^10.3 || ^11 || ^12`.
Depends on **mcp_tools** and **scheduler**. No routes, forms, or config of its own.

- **The five tools, inputs/outputs, scopes and enforcement** →
  [tools/scheduler-tools.md](tools/scheduler-tools.md)

## What it provides

- Five `tool` plugins in `src/Plugin/tool/Tool/`, all extending `McpToolsToolBase` with
  `MCP_CATEGORY = 'scheduler'`: `GetScheduledContent` (`mcp_scheduler_get_scheduled`, Read),
  `GetSchedule` (`mcp_scheduler_get_schedule`, Read), `SchedulePublish`
  (`mcp_scheduler_publish`, Write), `ScheduleUnpublish` (`mcp_scheduler_unpublish`, Write),
  `CancelSchedule` (`mcp_scheduler_cancel`, Write).
- One service `mcp_tools_scheduler.scheduler` (`Service/SchedulerService.php`) over
  `@entity_type.manager`, `@current_user`, `@mcp_tools.access_manager`,
  `@mcp_tools.audit_logger`, `@datetime.time`. It sets Scheduler's
  `publish_on` / `unpublish_on` entity fields.
- One permission: **`mcp_tools use scheduler`** (`restrict access: true`).

## Access model (inherited)

Gated by `McpToolsToolBase::checkAccess()` — `mcp_tools use scheduler` + operation scope
(Read→read, Write→write) + write-kind (`scheduler` → **content**) + read-only switch. Write
methods in `SchedulerService` additionally guard with `AccessManager::canWrite()`. See
[tools/scheduler-tools.md](tools/scheduler-tools.md).

## Operate

```bash
drush en mcp_tools_scheduler -y
```

Requires the Scheduler module and its `publish_on`/`unpublish_on` fields enabled on the target
bundle. Grant `mcp_tools use scheduler` to the executor role.
