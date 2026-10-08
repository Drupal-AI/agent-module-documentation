<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scheduler tools

Plugins in `src/Plugin/tool/Tool/`, delegating to `mcp_tools_scheduler.scheduler`
(`SchedulerService`). `MCP_CATEGORY = 'scheduler'` → permission **`mcp_tools use scheduler`**,
write-kind **content**.

| Tool id | Class | Op / scope | Inputs | Does |
|---|---|---|---|---|
| `mcp_scheduler_get_scheduled` | `GetScheduledContent` | Read / read | `type` (string, default `all`), `limit` (int, default 50) | Lists entities with a pending `publish_on`/`unpublish_on`. |
| `mcp_scheduler_get_schedule` | `GetSchedule` | Read / read | `entity_type` (default `node`), `entity_id` (int, required) | Returns the `publish_on`/`unpublish_on` timestamps for one entity. |
| `mcp_scheduler_publish` | `SchedulePublish` | Write / write | `entity_type` (default `node`), `entity_id` (int, required), `timestamp` (string, required) | Sets `publish_on` so Scheduler publishes the entity at that time. |
| `mcp_scheduler_unpublish` | `ScheduleUnpublish` | Write / write | `entity_type` (default `node`), `entity_id` (int, required), `timestamp` (string, required) | Sets `unpublish_on`. |
| `mcp_scheduler_cancel` | `CancelSchedule` | Write / write | `entity_type` (default `node`), `entity_id` (int, required), `type` (string, default `all`) | Clears the `publish_on` and/or `unpublish_on` schedule. |

## Access enforcement

`McpToolsToolBase::checkAccess()` applies `mcp_tools use scheduler` + the operation scope +
`content` write-kind policy + read-only switch. In `SchedulerService`, each mutating method
(`schedulePublish`, `scheduleUnpublish`, `cancelSchedule`) starts with
`if (!$this->accessManager->canWrite())` and returns `getWriteAccessDenied()` otherwise;
successful writes are audit-logged. The actual publish/unpublish is performed later by the
Scheduler module's own cron, not by these tools.

## Notes

- The target bundle must have Scheduler's `publish_on`/`unpublish_on` fields enabled or the
  set will not take effect.
- Timestamps are parsed by `SchedulerService`; pass an ISO date/time or epoch as the tool's
  input schema documents.
