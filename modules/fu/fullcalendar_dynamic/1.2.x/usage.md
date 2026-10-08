Fullcalendar Dynamic is a Views style plugin that renders a View of date-bearing content as an interactive [FullCalendar](https://fullcalendar.io/) calendar (month/week/day/list views), with per-taxonomy event colors, tooltips, recurring events (rrule), timezone handling, and AJAX-loaded events for the visible date range.

---

The module adds a Views **style** plugin `fullcalendar_dynamic` (theme `views_view_fullcalendar_enanced`) and a companion Views **display** plugin `fullcalendar_dynamic` ("FullCalendar Page", pager-less, provides a routed page/menu link). You build a View of an entity with a date/datetime field, choose the FullCalendar style, and map View fields to calendar semantics through the style options: `start`, `end`, `title`, `duration`, `rrule` (recurring rule field), `date_filter`, tooltip content/title/theme, default date/source, the toolbar buttons (`right_buttons`), and taxonomy-driven colors (`bundle_type`, `tax_field`, `vocabularies`, `color_bundle`, `color_taxonomies`). `FullcalendarViewPreprocess` turns View result rows into event data and pushes calendar config into `drupalSettings.fullCalendarView[<index>]`; `js/fullcalendar_view.js` instantiates FullCalendar. A dedicated AJAX endpoint `POST /fullcalendar-view/events` (`CalendarEventSourceController`, extends core `ViewAjaxController`) re-renders the View for the date window the user navigates to — it enforces `$view->access($display_id)` before returning JSON (unauthorized displays get 403). Third-party JS libraries (FullCalendar, moment, rrule, JSFrame, popper, tippy themes) are declared in `libraries.yml` and loaded from `/libraries/…` locally or swapped to a CDN by `hook_library_info_alter`. Supporting services: `TimezoneService` (timezone conversion), `TaxonomyColor` (term→color mapping), and a `fullcalendar_dynamic_processor` plugin manager (`Plugin/FullcalendarViewProcessor`) intended for pluggable event post-processing. No module config UI or permissions — everything is configured on the View.

---

- Show nodes/entities with a date field as a month/week/day/list calendar.
- Build an events calendar page with its own URL and menu link (FullCalendar Page display).
- Render a start–end date range as timed calendar events.
- Color-code events by a taxonomy term (e.g. event category) using per-term colors.
- Add hover tooltips to events showing a chosen field's content.
- Choose a tooltip theme (tippy.js light/border/material/translucent).
- Display recurring events from an rrule field.
- Only load events for the date range currently visible, via the AJAX event source, for large data sets.
- Filter events by a datetime View filter mapped to the visible window (`date_filter`).
- Configure which FullCalendar toolbar buttons appear (month/week/day/list year).
- Set the calendar's default landing date or use "now".
- Convert stored UTC datetimes to the site/user timezone for display.
- Embed a calendar block by placing the FullCalendar style on a block display.
- Present a room/resource booking overview as a calendar.
- Show an editorial content schedule (publish dates) as a calendar.
- Combine with contextual filters/arguments to scope the calendar (e.g. per group).
- Link each event to its entity page.
- Serve the calendar JS libraries from a local `/libraries` copy or from CDN via library alter.
- Provide a read-only public events calendar (recurring events render read-only).
- Extend event data processing by implementing a `fullcalendar_dynamic_processor` plugin.
