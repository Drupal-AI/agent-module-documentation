# fullcalendar_view — agent start

Views style plugin `fullcalendar_view_display` ("Full Calendar Display", `FullCalendarDisplay`)
that renders date-bearing View results as a FullCalendar month/week/day/list calendar. No admin
settings page — it is configured per-View in the Format settings. Depends on core `views` and
`datetime`. Enable: `drush en fullcalendar_view -y`.

- Configure the calendar (fields, views, colors, drag-drop) → [configure/fullcalendar_view.md](configure/fullcalendar_view.md)
- Front-end library, AJAX date-change route, theming → [theming/fullcalendar_view.md](theming/fullcalendar_view.md)
- Processor plugin type + preprocess/color services to extend → [api/fullcalendar_view.md](api/fullcalendar_view.md)
- Submodule: Drush view generator → [../../modules/fullcalendarview_generator/5.2.x/agent/start.md](../../modules/fullcalendarview_generator/5.2.x/agent/start.md)
