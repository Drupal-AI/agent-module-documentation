# Full Calendar View — manual setup guide

**Full Calendar View** (`fullcalendar_view`) adds a Views *style plugin* — "Full
Calendar Display" — that renders any date‑bearing content as an interactive
month, week, day, or list calendar, powered by the popular FullCalendar
JavaScript library. If you can build a view of your events, you can present them
as a proper calendar, complete with drag‑and‑drop rescheduling.

You choose "Full Calendar Display" as a view's **Format**, then map your view's
fields to calendar meaning: a start‑date field (required), and optionally an
end‑date field, a title field, an RRULE field for recurring events, and a duration
field. From there you pick the default view (month / week / day / list), header
buttons, first day of the week, time format, and even a separate default view and
width for mobile. Events can be color‑coded by content type or by a taxonomy
field.

When "Update allowed" is turned on, editors can drag‑and‑drop or resize events and
the new dates are written straight back to the entity (a confirmation dialog is
optional); double‑clicking empty space opens a form to create a new event.
The FullCalendar, Moment.js, and RRule libraries load from a CDN by default, or
from your `/libraries` directory if you host them locally. The module depends only
on core **Views** and **Datetime**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (plus the optional generator submodule).

## Where it lives in the admin menu

There is **no separate admin settings page**. Full Calendar View is configured
entirely inside the **Views** UI (`/admin/structure/views`), in the **Format**
settings of the individual view you turn into a calendar.

## How to use it

To turn content into a calendar:

1. Create or edit a **view** of your date‑bearing content (a content type with a
   Date field, for example), using the **fields** row style.
2. Set the view's **Format** to **Full Calendar Display** and open its settings.
3. **Map the fields**: choose the start‑date field (required), and optionally an
   end‑date, title, RRULE, and duration field. Make sure each field you map has
   been added to the view's field list.
4. Configure the calendar's appearance and behavior:
   - **Default view** — `dayGridMonth` (month), `timeGridWeek` (week),
     `timeGridDay` (day), or `listYear` (list), plus which header buttons to show.
   - **First day of week, time format, events per day limit**, and the time window
     and slot granularity for week/day views (min/max time, slot duration).
   - **Mobile** — a different default view and layout below a configurable width
     (default 768px).
   - **Colors** — color events by content type/bundle, or by a taxonomy term
     field.
   - **Recurring events** — render from an RRULE string field, with each instance's
     length set by the optional duration field.
   - **Editing** — turn on **Update allowed** to let editors drag, drop, and resize
     events (optionally with a confirmation dialog), and double‑click empty slots to
     create new events. Choose whether event links open in a modal, an off‑canvas
     panel, a new tab, or a full page.
   - **Starting date, localization, and Google Calendar holidays** (with an API
     key) are available too.
5. Save the view and visit its page to see the calendar. Combine it with view
   filters, contextual filters, and a pager to scope which events appear.

**Hosting the libraries locally:** by default FullCalendar, Moment.js, and RRule
load from a CDN. To serve them from your own site instead, place them under
`/libraries` and the module will pick them up.

**Extending it (developers):** a `FullcalendarViewProcessor` plugin type lets
other modules alter the calendar's rendered variables, and the preprocess and
color services can be decorated for custom event logic. The bundled
`fullcalendarview_generator` submodule adds a Drush command to scaffold calendar
views — see the [`agent/`](../agent/start.md) docs.
