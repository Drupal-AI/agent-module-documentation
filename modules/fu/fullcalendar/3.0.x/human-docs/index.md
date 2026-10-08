# FullCalendar — manual setup guide

**FullCalendar** (`fullcalendar`) brings the popular FullCalendar.io v6
JavaScript calendar to Drupal as a **Views style plugin**. Point it at any View of
date-bearing entities — event nodes, appointments, anything with a date or
date-range field — and it renders them as an interactive month / week / day / list
calendar, right on your site.

You build a normal View, include your date field, and in the View's *Format*
section switch the style to **FullCalendar**. From there an extensive set of
options controls which calendar views are available (month, time-grid week/day,
list), the header/footer toolbars, how each row maps to an event's title, link and
date, and much more. Events can be color-coded by content type or by a taxonomy
term, restricted to business hours, shown with week numbers and a "now" indicator,
and converted between time zones.

FullCalendar is also interactive when you want it to be: editors can drag and drop
events to reschedule them (persisted over AJAX, optionally behind a confirmation),
double-click a day to create a new event of a chosen type in a modal, and navigate
months without full page reloads. It can even pull in a Google Calendar feed. For
developers there's a small plugin type for adding calendar options and a handful
of alter hooks; a `fullcalendar_legend` submodule prints a color legend beneath
the calendar.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, the
   FullCalendar.io library, and enable the module.
2. [Configuration](configuration/index.md) — set the FullCalendar style on a
   View, map the date field, and work through the main option groups.

## Where it lives in the admin menu

FullCalendar has no settings page of its own. You configure every calendar inside
a View, under **Structure → Views** (`/admin/structure/views`) — choose the
**FullCalendar** format on the display you want. The one permission it adds is set
on the **People → Permissions** page.

## How to use it

Create or edit a View whose rows are date-bearing entities, add the date field(s)
to the display, and in **Format** switch the style to **FullCalendar**. In its
settings, map at least the **Date** field and enable the calendar views you want
(month / week / day / list). Optionally turn on AJAX for smooth navigation, add
color-coding, and enable drag-and-drop or click-to-create. See
[Configuration](configuration/index.md) for the full option walkthrough.
