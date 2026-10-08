# Calendar Systems FullCalendar — agent index

Glue submodule that makes the contrib `fullcalendar` module render in the Persian/Jalali calendar
by replacing its JS library. Requires `calendar_systems` + `fullcalendar`. No config, permissions,
routes, or Drush.

How it works:
- `calendar_systems_fullcalendar_js_alter()` (`hook_js_alter`) unsets any JS asset whose key
  contains `fullcalendar.library`, removing the upstream FullCalendar JS.
- Library `calendar_systems_fullcalendar/calendar_systems_fullcalendar` loads
  `calendar_systems_fullcalendar.js` in its place.
- **Manual step (README):** install the Jalali-ready FullCalendar library
  (`fullcalendar-Jalaali-drupal-ready`) instead of the upstream one, per the `fullcalendar`
  module's library-install instructions.

No further solution docs — the submodule is only a library swap.
