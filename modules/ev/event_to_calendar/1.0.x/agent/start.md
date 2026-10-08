<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Event to Calendar (event_to_calendar) — agent index

**iCal/vCal/CSV downloads, RSS feed and Google/Outlook/Yahoo add-to-calendar links for event nodes via configured date/location field mappings.**

- **Version:** 1.0.x  •  core: `^10`  •  package: Custom  •  depends on `node`, `views`, `field`.
- **Routes (all `_permission: 'access content'`):** `/event/{event_id}/ical|google|outlook|yahoo|rss|vcs|csv` → `EventToCalendarController`; settings `/admin/config/event-to-calendar` (`administer site configuration`).
- **Config:** `content_types` + per-type `{type}_start_date` / `_end_date` / `_location` field names. Block `AddToCalendarBlock`.
