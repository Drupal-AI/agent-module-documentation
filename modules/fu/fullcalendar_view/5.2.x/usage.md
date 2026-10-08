Full Calendar View adds a Views style plugin ("Full Calendar Display") that renders any date-bearing content as an interactive month/week/day/list calendar powered by the FullCalendar JavaScript library.

---

The module registers a Views style plugin with id `fullcalendar_view_display` (`FullCalendarDisplay`) that you pick as the Format of a View. You map View fields to calendar semantics — a start-date field (required), an optional end-date field, a title field, an optional RRULE field for recurring events, and an optional duration field — then choose default view (`dayGridMonth`, `timeGridWeek`, `timeGridDay`, `listYear`), header buttons, first day of week, time format, and a separate default view/width for mobile. Events can be colored by content type/bundle or by a taxonomy field via the `fullcalendar_view.taxonomy_color` service. When "Update allowed" is on, editors drag-and-drop or resize events and the JS posts the new dates to the `fullcalendar_view.update_event` route (`/fullcalendar-view-event-update`), which validates a CSRF token and writes the changed start/end back to the entity; double-click on empty space opens the `fullcalendar_view.add_event` route to create a new event. The FullCalendar, Moment.js and RRule libraries load from CDN by default (via `hook_library_info_alter`) or from `/libraries/...` if you host them locally. A `FullcalendarViewProcessor` plugin type lets other modules alter the calendar's preprocess variables, and the core `fullcalendar_view.view_preprocess`, `fullcalendar_view.taxonomy_color` and timezone-conversion services can be decorated. The bundled `fullcalendarview_generator` submodule adds a Drush command to scaffold calendar Views. It depends only on core `views` and `datetime`.

---

- Show a content type's events on a monthly calendar by adding a Full Calendar Display View.
- Present nodes with a Date field as calendar entries mapped from a start-date field.
- Add an optional end-date field so multi-hour or multi-day events span correctly.
- Switch between month (`dayGridMonth`), week (`timeGridWeek`), day (`timeGridDay`) and list (`listYear`) views via header buttons.
- Serve a different default view and layout on mobile below a configurable width (default 768px).
- Let editors reschedule events by dragging and dropping them on the calendar (Update allowed).
- Resize all-day events to change their duration directly on the calendar.
- Pop up a confirmation dialog before saving a dragged event change (updateConfirm).
- Color-code events by content type / bundle so each type is visually distinct.
- Color-code events by a taxonomy term field using the taxonomy color service.
- Render recurring events from an RRULE string field (weekly, with exclusions, until a date).
- Set each recurring instance's length with an optional duration field (e.g. `05:00`).
- Create a new event by double-clicking an empty day/time slot, prefilled with that date.
- Open event links in a modal dialog or off-canvas panel instead of a full page.
- Open event details in a new browser tab when preferred.
- Choose the initial date the calendar lands on: current date, first result, or a fixed date.
- Configure header buttons, first day of week, time format, and event display limit per day.
- Restrict the visible time window and slot granularity for week/day views (minTime, maxTime, slotDuration).
- Localize the calendar and optionally let visitors switch language at runtime.
- Fetch and overlay public holidays from Google Calendar (with an API key).
- Combine the calendar with View filters, contextual filters and a pager to scope events.
- Host the FullCalendar/Moment/RRule libraries locally under `/libraries` instead of the CDN.
- Alter the calendar's rendered variables from another module via a FullcalendarViewProcessor plugin.
- Decorate or override the view-preprocess service to inject custom event business logic.
- Scaffold a calendar View from the command line with the `fullcalendarview_generator` Drush command.
