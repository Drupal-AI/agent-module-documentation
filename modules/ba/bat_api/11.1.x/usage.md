<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
BAT API exposes the Booking and Availability Toolkit's units and events/availability over an HTTP JSON API, shaped for a FullCalendar front end, so a decoupled or JavaScript calendar can read BAT data without rendering Drupal pages.

---

BAT (Booking and Availability Toolkit) models the hard part of any reservation system: what is available when, across units, with overlapping events and states. Its data is normally consumed inside Drupal; this module puts a slice of it behind an HTTP JSON API so a calendar UI — typically FullCalendar — can fetch the units to show as resources and the events to show as availability. In this branch the live surface is two Drupal core REST resources: `GET /bat_api/rest/calendar-units` returns the units of a type as FullCalendar resources (`{id, title}`), and `GET /bat_api/rest/calendar-events` returns the events for the requested unit types and date window, run through BAT's fixed/open state event formatters. The module also still ships four older `@ServiceDefinition` plugins (events, calendar-events, calendar-units and matching-units indexes) for the contrib Services module, but Services is not a dependency of this branch and no endpoint config ships, so those are inert unless you wire Services up yourself.

It depends on the BAT stack (`bat_event`, `bat_fullcalendar`) and on REST UI (`restui`) for turning the core REST resources on and off, and it is only meaningful on a site already running BAT. It provides no settings form, no permissions and no Drush of its own: the endpoints are enabled and gated through core REST configuration and existing BAT event permissions. For a decoupled or integrated booking calendar built on BAT, this is the data interface — the booking logic and the front end live elsewhere.

---

- Expose BAT availability over an HTTP JSON API.
- Feed a FullCalendar calendar with BAT resources and events.
- Fetch the units of a type as calendar resources.
- Fetch events/availability for a date window.
- Build a decoupled booking calendar on BAT.
- Read booking data from a JavaScript front end.
- Query availability from an external system.
- Serve calendar-events JSON at `/bat_api/rest/calendar-events`.
- Serve calendar-units JSON at `/bat_api/rest/calendar-units`.
- Filter events by unit type and event type.
- Restrict a query to specific unit ids.
- Return FullCalendar background events for availability.
- Enable the REST resources with REST UI.
- Reshape the calendar JSON with an alter hook.
- Merge continuous non-blocking background events.
- Integrate BAT with a mobile or web app.
- Provide a booking data interface for a headless site.
- Run BAT behind a JavaScript booking widget.
- Keep the old Services endpoints available for migration.
- Connect BAT availability to another service.
- Format events with BAT's fixed or open state formatters.
- Expose per-unit-type matching availability segments.
- Read events over HTTP for a decoupled UI.
