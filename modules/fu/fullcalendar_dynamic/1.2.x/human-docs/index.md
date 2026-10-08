# Fullcalendar Dynamic — manual setup guide

**Fullcalendar Dynamic** (`fullcalendar_dynamic`) is a Views style plugin that
displays a View of date-bearing content as an interactive
[FullCalendar](https://fullcalendar.io/) calendar — month, week, day, or list
views, with the navigation toolbar you would expect. It is a good fit for events
listings, editorial schedules, room or resource bookings, or any content that has
a date field.

Beyond the basic calendar it supports colour-coding events by a taxonomy term,
hover tooltips, recurring events (from an iCal RRULE field), timezone conversion,
and — for large data sets — loading only the events for the date range currently
in view via an AJAX event source. It also ships a companion "FullCalendar Page"
Views display that gives you a ready-made calendar page with its own URL and menu
link.

Everything is configured on the View itself; there is no separate admin settings
page and no permissions of its own. The calendar's own access is governed by the
View display's access settings, as usual.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and provide the JavaScript libraries.

## How to use it

You build a calendar entirely inside the Views UI
(**Configuration → Content authoring → Views**):

1. **Create a View** of an entity that has a date/datetime field. Add that date
   field, plus a title and any fields you want to show or link.
2. **Choose the format.** Either set the display's **Format** to **FullCalendar
   Display**, or add a **FullCalendar Page** display, which pre-selects the style,
   drops the pager, and gives you a routed page with a URL and menu link.
3. **Map fields to calendar roles** in the style settings. The key options are:
   - **Start** *(required)* — the field holding the event start date.
   - **End** — the field holding the event end date.
   - **Title** — the field used as the event label.
   - **Duration** — a field expressing event length.
   - **RRULE** — a field holding a recurring-event rule (rendered read-only).
   - **Date filter** — the View's datetime filter that gets narrowed to the
     visible window as the user navigates (drives the AJAX "load only what's
     visible" behaviour).
   - **Default date / source** — open on "now" or a fixed date.
   - **Tooltip content / title / theme** — fields for the hover tooltip and a
     tippy.js theme (light, light-border, material, translucent).
   - **Toolbar buttons** — which view buttons appear (month / week / day / list).
   - **Taxonomy colours** — the bundle, taxonomy reference field, vocabulary, and
     per-term colour map used to colour events.
4. **Save** and view the calendar. As the visitor pages to another month or week,
   the calendar quietly reloads just the events for that window.

You can also place the FullCalendar style on a block display to embed a calendar
block, or combine it with contextual filters to scope the calendar (for example,
per group).
