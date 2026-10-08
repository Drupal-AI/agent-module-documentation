<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Moderation Scheduler lets editors set a future date/time on a node so cron transitions it to the published moderation state automatically.

---

Editorial teams often prepare content ahead of time and want it to go live at a specific moment without someone manually clicking publish. On install the module adds a `field_scheduled_time` datetime field to every node type. Editors fill that field (with the "edit moderation scheduler field" permission), and `hook_cron()` (`moderation_scheduler_cron()`) calls `ModerationSchedulerService::publishScheduled()` to find nodes whose scheduled time has passed and move them to the published state, creating a new revision.

The module exposes a settings form at `/admin/moderation-scheduler` (permission "administer moderation_scheduler module", restricted) and a bulk publish form at `/admin/content/scheduled/publish` (permission "edit moderation scheduler field"). It ships a Views view (`moderation_scheduler_content`) with custom field/query plugins to list scheduled content, plus queue workers and a `ModerationSchedulerEvent` dispatched around processing so other modules can react. Both routes are permission-gated; scheduling happens server-side on cron. Note the install step alters every node type by adding the scheduled-time field.

---

- Schedule a node to publish at a specific future date and time.
- Let cron publish due content without manual action.
- Grant editors the "edit moderation scheduler field" permission to schedule.
- Configure module behaviour at /admin/moderation-scheduler.
- Review scheduled content in the provided Views listing.
- Bulk-publish due items via /admin/content/scheduled/publish.
- Move a node into the published moderation state on schedule.
- Create a new revision when publishing scheduled content.
- React to scheduling with ModerationSchedulerEvent subscribers.
- Integrate scheduled processing with queue workers.
- Add field_scheduled_time to all node types on install.
- Run cron to process the scheduling queue.
- Restrict administration to trusted roles via the admin permission.
- Combine with content moderation workflows.
- Prepare campaign content to go live overnight.
- Coordinate timed releases across content types.
- Audit which nodes are pending publication.
- Use the datetime field to set publish time in the node form.
