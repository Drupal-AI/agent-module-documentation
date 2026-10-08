<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Moderation Scheduler (moderation_scheduler) — agent index

**Adds a scheduled-time field to nodes and publishes moderated content at that time via cron.**

- **Version:** 9.2.x
- **Core:** `>=8`
- **Depends:** datetime, field, node, views
- **Configure:** `moderation_scheduler.settings` → `/admin/moderation-scheduler`
- **Routes:** `moderation_scheduler.settings` (perm `administer moderation_scheduler module`, restricted); `moderation_scheduler.publish_form` `/admin/content/scheduled/publish` (perm `edit moderation scheduler field`).
- **Service:** `moderation_scheduler.services` (`ModerationSchedulerService::publishScheduled()` run from `hook_cron`). Views field/query plugins, queue workers, `ModerationSchedulerEvent`.
- **Install:** adds `field_scheduled_time` datetime field to every node type.

**Security:** both routes permission-gated (admin perm marked `restrict access`); no anonymous or unauthenticated mutating endpoint; publishing runs server-side on cron. See [configure/settings.md](configure/settings.md). No security findings.
