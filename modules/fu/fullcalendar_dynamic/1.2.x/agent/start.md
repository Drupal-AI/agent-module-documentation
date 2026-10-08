# Fullcalendar Dynamic — agent index

A Views **style** + **display** that renders date-bearing content as an interactive FullCalendar
calendar (month/week/day/list), with taxonomy colors, tooltips, recurring (rrule) events, timezone
conversion, and AJAX-loaded events per visible date range. Configured entirely on the View; no module
config UI (`configure` null), no permissions. Depends on `views` + `datetime`.

- **Set up the calendar: the Views style & display plugins and every style option (start/end/title/rrule/date_filter/colors/tooltips/toolbar)** →
  [configure/views-style.md](configure/views-style.md)
- **Plugin type `fullcalendar_dynamic_processor`, the AJAX event-source route, and the helper services** →
  [plugins/processor.md](plugins/processor.md)

Key facts:
- Views style plugin id `fullcalendar_dynamic` (theme `views_view_fullcalendar_enanced`,
  `display_types = {"fullcalendar"}`); Views display plugin id `fullcalendar_dynamic`
  ("FullCalendar Page", `getType() = 'fullcalendar'`, pager-less, routed).
- `FullcalendarViewPreprocess` builds events + `drupalSettings.fullCalendarView[<i>]`; `js/fullcalendar_view.js` renders.
- AJAX endpoint: `POST /fullcalendar-view/events` → `CalendarEventSourceController::ajaxView`
  (`_access: 'TRUE'`, but enforces `$view->access($display_id)` → 403 otherwise).
- Services: `fullcalendar_dynamic.timezone_conversion_service`, `fullcalendar_dynamic.taxonomy_color`,
  `fullcalendar_dynamic.view_preprocess`; plugin manager `plugin.manager.fullcalendar_dynamic_processor`.
- JS libs (FullCalendar/moment/rrule/JSFrame/popper/tippy) load from `/libraries/…`, CDN-swappable via
  `hook_library_info_alter`.
