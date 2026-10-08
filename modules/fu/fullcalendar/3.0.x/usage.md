<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FullCalendar integrates the FullCalendar.io v6 JavaScript library as a Views style plugin, rendering any View of date-bearing entities as an interactive month/week/day/list calendar.

---

The module's core deliverable is the `fullcalendar` Views style plugin (`@ViewsStyle`, title "FullCalendar"), chosen in a View's *Format* section. It reads one or more date/date-range fields from the View's results and plots each row as an event on a FullCalendar.io calendar. It requires core `views` and `datetime`, and pulls in the FullCalendar.io assets via the `drupal/fullcalendar_io` Composer library (v6.1+). The style has an extensive option set (stored under `views.style.fullcalendar` config schema): which views to enable (month / timeGrid / dayGrid / list), header/footer toolbars, title formatting, the field mappings for title / URL / date, per-bundle and per-taxonomy-term event colors, business hours, week numbers, now-indicator, time-axis slot settings, timezone conversion, Google Calendar API integration, and interactive options (drag-and-drop update, navLinks, double-click-to-create with a chosen bundle/form mode/modal). Interactivity is backed by two AJAX routes and controllers: `fullcalendar.update` (`/fullcalendar/ajax/update/drop/{entity_type}/{entity}`) persists drag-and-drop date changes, and `fullcalendar.results` (`/fullcalendar/ajax/results/{view}/{display_id}`) fetches events for navigation. It defines a plugin type — FullCalendar "option" plugins (`FullcalendarOption` annotation, manager `plugin.manager.fullcalendar`, directory `Plugin/fullcalendar/type`) — so other modules can add option handlers; the module's own `fullcalendar` type plugin builds the option form and processes settings. It ships one permission, `update any fullcalendar event`, and four alter/extension hooks (`hook_fullcalendar_classes`, `hook_fullcalendar_classes_alter`, `hook_fullcalendar_droppable`, `hook_fullcalendar_process_dates_alter`). A `fullcalendar_legend` submodule adds a Views area handler that prints a color legend.

---

- Display a View of event nodes as an interactive monthly calendar.
- Show a week/day time-grid calendar of appointments from a datetime field.
- Render a list-view agenda of upcoming events for a landing page.
- Map a Date Range field so multi-day events span the correct days.
- Color-code calendar events by content type (bundle) on the calendar.
- Color-code events by a taxonomy term reference (e.g. event category).
- Let editors drag-and-drop events to reschedule them (persisted via AJAX).
- Require confirmation before a drag-and-drop update is saved.
- Enable double-click on a day to create a new event of a chosen bundle in a modal.
- Use AJAX navigation so month/week changes fetch events without a full page reload.
- Add a header/footer toolbar with prev/next/today and view-switch buttons.
- Restrict the calendar to business hours and emphasize working time slots.
- Show week numbers and a "now" indicator line on time-grid views.
- Convert event times from other timezones for display.
- Configure slot duration, min/max time, and scroll time on the time axis.
- Embed a calendar block/attachment of a View on a dashboard.
- Link calendar days to the day view via navLinks.
- Set the initial view (e.g. `dayGridMonth`) and first day of week.
- Integrate a Google Calendar feed via the Google Calendar API key options.
- Provide a color legend beneath the calendar with the fullcalendar_legend submodule.
- Filter which entities appear using standard Views filters (e.g. published, date range).
- Show a taxonomy-filtered calendar (e.g. only "Holidays") using a contextual filter.
- Give a title format and range separator for the calendar heading.
- Choose which form mode and modal width to use when creating events inline.
- Add custom CSS classes to events via `hook_fullcalendar_classes[_alter]()`.
- Alter event start/end dates before rendering with `hook_fullcalendar_process_dates_alter()`.
- Present a multi-view calendar toggling month, week, day, and list from the toolbar.
- Grant trusted users the `update any fullcalendar event` permission to move any event.
