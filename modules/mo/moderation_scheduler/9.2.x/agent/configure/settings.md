<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Moderation Scheduler — configure

## Enable & field
Enabling the module adds a `field_scheduled_time` (datetime) field to **all** node types. Editors set it on the node edit form.

## Permissions
- `administer moderation_scheduler module` — settings form (restricted).
- `edit moderation scheduler field` — allowed to set the scheduled time and use the publish form.

## Routes
- `/admin/moderation-scheduler` — settings (`ModerationScheduleForm`).
- `/admin/content/scheduled/publish` — manual publish form (`ModerationSchedulePublishForm`).

## Cron
`moderation_scheduler_cron()` → `ModerationSchedulerService::publishScheduled()` finds nodes whose `field_scheduled_time` is due and transitions them to the published moderation state (new revision). Run cron for scheduling to take effect.

## Extending
`ModerationSchedulerEvents` defines events dispatched via `@event_dispatcher` around processing; subscribe to `ModerationSchedulerEvent` to add custom logic when content is scheduled/published.
