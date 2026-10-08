<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Timetable Cron (timetable_cron) — agent index

Replaces the core `cron` service with a subclass so each `hook_cron` implementation runs on its
own unix-crontab-style schedule (minute/hour/day/month/weekday, `*` and `*/N`). Schedules are
`timetable_cron` **config entities**; last-run and force flags live in Drupal **state**.
Version dir **8.x-1.x** (packaged `8.x-1.7`). Core `^9 || ^10 || ^11`. No module dependencies.

## How it takes over cron
`TimetableCronServiceProvider::alter()` calls `setClass()` on the `cron` service definition,
pointing it at `Drupal\timetable_cron\TimetableCron` (extends `Drupal\Core\Cron`). Only
`invokeCronHandlers()` is overridden — it decides, per job, whether "now" matches the schedule.
This is a full service-class swap, so it is **incompatible with Elysia/Ultimate Cron** — use one.

## Entities / classes
- Config entity `timetable_cron` — `src/Entity/TimetableCronEntity.php` (config_prefix
  `timetable_cron`; exported keys: id, status, minute, hour, day, month, weekday, desc).
- `TimetableCron` — overridden cron service; `TimetableCronRuntime` — state helper
  (`STATE_KEY = timetable_cron.runtime`); `ProxyClass/TimetableCron` — lazy service proxy.
- Forms: `TimetableCronForm` (add/edit), `TimetableCronForceForm`, `TimetableCronDeleteForm`.
- `TimetableCronListBuilder` — the admin list (adds last-run + force columns).

## Routes (all require permission `configure timetable_cron`, `restrict access: TRUE`)
`/admin/config/system/timetable_cron` (collection) · `/add` · `/{timetable_cron}` (edit) ·
`/{timetable_cron}/delete` · `/{timetable_cron}/force`. The force route is a confirm form
(POST) that only sets a state flag; no route runs cron on GET. Configure link:
`entity.timetable_cron.collection`.

## Solution docs
- [agent/architecture/cron-override.md](architecture/cron-override.md) — service swap, the
  per-job match logic, `*/N` intervals, auto-creation of entities, force/last-run state.
- [agent/config/settings.md](config/settings.md) — config entity + schema, the schedule form
  fields, routes, permission, list builder, delete/force forms.
