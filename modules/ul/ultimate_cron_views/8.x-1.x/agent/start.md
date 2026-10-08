<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ultimate Cron Views (ultimate_cron_views) — agent index

**Exposes Ultimate Cron job-log data (start/end/duration) to Views for read-only cron run reporting.**

- **Version:** 8.x-1.x
- **Core:** ^8.7.7 || ^9 || ^10 || ^11 — depends on `ultimate_cron:ultimate_cron`, `views:views`
- **Routes** (all `_permission: administer ultimate cron`):
  - `/admin/config/system/cron/views/summary` → Controller::summary
  - `/admin/config/system/cron/views/detail` → Controller::detail
  - `/admin/config/system/cron/views/settings` → settings form
- **Plugins:** Views query `CronLogSqlQuery` + fields `CronLogJobStartDate/EndDate/Duration` (map to `start_time`/`end_time` via FROM_UNIXTIME/ROUND).
- **Config:** `ultimate_cron_views.settings` (view_name/view_display for summary & detail, date format); bundled `views.view.ultimate_cron_views`.

**Security:** All routes admin-permission-gated (`administer ultimate cron`); no `_access: TRUE`, no `access content`. Purely read-only — no route runs/enables/disables/deletes cron jobs. SQL fragments in `CronLogSqlQuery` interpolate only Views-internal table/field names (not request input). No security findings.
