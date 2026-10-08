# Fullcalendar library — agent index

Registers two Drupal **asset libraries** for the legacy FullCalendar **v3** JS calendar.
No routes, config, permissions, plugins, Drush, or hooks you implement. Just attach the
library. Its only "state" is whether the assets are served from a local `/libraries/…`
copy or from the jsDelivr CDN fallback.

- **The two libraries, how to attach them, local-vs-CDN fallback, versions** →
  [api/libraries.md](api/libraries.md)

Key facts:
- Attach `fullcalendar_library/fullcalendar` (core) or `fullcalendar_library/fullcalendar-scheduler`
  (Scheduler add-on; depends on the core lib).
- Local files live under the **web root** at `/libraries/fullcalendar/…` and
  `/libraries/fullcalendar-scheduler/…`. If a file is missing, `hook_library_info_alter()`
  replaces it with a CDN URL (FullCalendar 3.10.2 / Scheduler 1.10.1 / Moment 2.27.0).
- `hook_requirements()` shows on `/admin/reports/status` whether local or CDN is active.
- This is FullCalendar **v3** (`$.fullCalendar(...)` + Moment), not the v5/v6 ESM API.
