# Calendar Events — manual setup guide

**Calendar Events** (`calendar_events`) displays your event content as a visual,
interactive calendar widget on a page. It is built on the PickMeUp JavaScript
calendar and is tied to a `content_calendar_events` content type that the module
installs for you — each event is authored as a normal node with a start date and
an end date, and the calendar links each day to its associated event.

You can show between one and three linked calendars side by side (useful for
multi-month displays), and the look is customisable through the module's CSS and
template overrides. It is aimed at simple event showcases — surfacing what's on
in a friendly month/day view — rather than at booking or reservation systems.

The calendar is rendered entirely through a block: there are no custom routes,
controllers, or permissions, and nothing that changes state. You place the
block, author your events as content, and the block queries the published event
nodes and feeds them to the PickMeUp calendar.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Calendar Events does not add a settings page. You place its calendar from
**Structure → Block layout** (`/admin/structure/block`), and you author events
as normal content of the `content_calendar_events` type at **Content → Add
content** (`/node/add`).

## How to use it

1. Enable the module — this installs the `content_calendar_events` content type
   with its start-date and end-date fields.
2. Create event nodes of that type.
3. Go to **Structure → Block layout**, place the **Calendar Events** block in
   your chosen region, and configure it (including how many calendars, 1–3, to
   show).
4. The block renders the published events on the PickMeUp calendar, with each
   day linking to its event. Restyle it by overriding the module's CSS library
   or the templates under its `templates/` folder.
