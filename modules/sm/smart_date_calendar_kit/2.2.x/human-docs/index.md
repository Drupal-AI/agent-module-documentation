# Smart Date Calendar Kit — manual setup guide

**Smart Date Calendar Kit** (`smart_date_calendar_kit`) installs a
ready-to-use view that displays your [Smart
Date](https://www.drupal.org/project/smart_date) field values in a **FullCalendar**
calendar. It's a starting point rather than a finished product: enable it and you
get a working monthly/weekly event calendar with almost no setup, which you can
then evaluate, demo, or build a more customised solution on top of.

It builds on and requires the **Smart Date Starter Kit**, so review that module's
notes too — the calendar view is layered on the Event content type and "When"
field that the Starter Kit provides. Enabling this module pulls in everything it
needs (Smart Date, FullCalendar, the Starter Kit and a couple of helper modules)
and wires an Events content type and related views together with tab navigation.

Two nice touches come configured out of the box: users with the right permissions
can **drag and drop** events on the calendar to reschedule them, and
**double-clicking** a date or time opens the "add event" form with that time
pre-filled. Recurring events are supported by the configuration but not switched on
by default — you enable them separately if you need them (see below).

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   create your first event so the calendar has something to show.

## How to use it

The calendar won't render until there's content to show, so the first step after
enabling is to **create at least one event** at `/node/add/event`. Then visit
`/events/calendar` to see your calendar. From there you can drag events to
reschedule them (with the necessary permissions) or double-click an empty slot to
create a new event at that time.

### Recurring events

Recurring events (available in Smart Date since its 8.x-2.0 release) aren't enabled
by default, but the configuration is built to support them. To turn them on, enable
the **Smart Date Recur** module, then go to
`/admin/structure/types/manage/event/fields/node.event.field_when` and enable
recurring values for the "When" field.

### Prefer a recipe?

If your site is Drupal 10.3 or newer, you can get a very similar result by applying
the **Events Calendar** recipe instead of this module.
