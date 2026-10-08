# Date iCal — manual setup guide

**Date iCal** (`date_ical`) exports your date and event content as RFC‑5545
**iCalendar (.ics)** feeds that calendar apps can subscribe to or download. Its
main deliverable is a **Views feed** display that renders your results as a
VCALENDAR of events, driven by a row plugin that maps Views fields to iCal
properties — start and end dates, summary, description, location, recurrence
rules, attendees, geo coordinates, attachments, and more. Publish it at a path
like `/events/ical` and people can subscribe to a live calendar of your events.

Beyond the Views feed, the module ships three extras: an **"Add to calendar"**
field formatter that turns a single date field into a downloadable `.ics` link, a
**CKEditor 5** button that lets editors insert per‑event download links inside body
text, and an optional **Feeds** parser for importing external `.ics` feeds into
your content. Under the hood it uses the `kigkonsult/icalcreator` PHP library to
build spec‑compliant output, and it automatically populates the VTIMEZONE block for
your site's timezone.

The module has no settings form and no permissions. Its only hard requirement is
the `kigkonsult/icalcreator` Composer library (installed automatically); Views is
part of core, and the Feeds and CKEditor 5 integrations are optional. The feed and
download routes are open, but the feed controller enforces entity‑ and field‑level
**view** access before emitting any data, so users can't pull fields they aren't
allowed to see. There are no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the field→property
mapping table, the reusable `date_ical.feed` service, and the alter hooks — read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   iCalcreator library) and enable the module.

## Where it lives in the admin menu

There is no dedicated settings page. You build feeds in the **Views** editor
(`/admin/structure/views`) and configure the "Add to calendar" link on an entity's
**Manage display** tab.

## How to use it

### Build a Views iCal feed

1. Add or edit a view whose content has a date field (events, nodes, etc.).
2. Add a **Feed** display.
3. Set **Format → iCal Feed** and **Show → iCal Fields** (the feed requires this
   row plugin).
4. Add the view **fields** you want to expose (date, title, body, location, …) —
   only fields added to the display are available to map.
5. Give the Feed display a **path**, e.g. `/events/ical`; that becomes the feed
   URL.
6. In the row plugin settings, map at least the **Date field** (start date /
   DTSTART; this is required) and any optional properties — end date, summary,
   description, location, recurrence (a frequency/count picker or a raw RRULE
   field), organizer, attendees, status, alarms, attachments, and so on.
7. In the style (iCal Feed) settings you can name the calendar, omit the calendar
   name so events merge into an existing calendar, force a file download instead of
   a `webcal://` subscription, exclude DTSTAMP, and work around client quirks.

### Add an "Add to calendar" link to a field

1. On the entity's **Manage display** tab, set a date field's format to **Date
   iCal**.
2. In the formatter settings, map the same optional properties (summary, location,
   recurrence, etc.) and choose whether to download directly or subscribe.

The date then renders with a small calendar link that downloads a single‑event
`.ics` file.
