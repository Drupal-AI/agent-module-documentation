# Feeds Ical — manual setup guide

**Feeds Ical** (`feeds_ical`) adds an **Ical Parser** to the **Feeds** module so you
can import events from iCalendar sources — the `.ics` / `.ical` files and feed URLs
that calendars like Google Calendar and Outlook produce — into Drupal entities. Once
it is set up, you can map calendar fields such as the start and end times, summary,
description, and location onto your own content type (say, an Event node) and keep
them in sync on a schedule.

It fits into the normal Feeds workflow. On a Feeds **feed type** you pick where the
data comes from (a remote URL, an uploaded file, or pasted text) using one of
Feeds' own **fetchers**, and you choose **Ical Parser** as the parser. Feeds Ical
itself never fetches anything — it only parses the bytes the fetcher hands it, using
the well‑known `johngrogg/ics-parser` library. Each calendar event becomes a feed
item with normalized fields ready to map: start/end as UNIX timestamps (plus
timezone‑aware and raw variants), UID, summary, description, location, status,
recurrence rule, and more.

The parser has two settings — **Filter Days Before** (ignore events older than a
number of days; 0 means import everything) and **Skip Recurrence** (skip parsing
RRULE recurrence rules) — and offers a generous set of mapping sources in the Feeds
UI. One thing to know: the current version stores the raw RRULE string but does not
yet expand recurring events into separate items.

Feeds Ical requires the contributed **Feeds** module (`^3.0`) and the
`johngrogg/ics-parser` library (`^3.4`), both of which Composer installs for you. It
works on Drupal 9, 10, and 11, and has no admin page, permission, or configuration
of its own — everything is configured on the Feeds feed type.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, Feeds, and the
   ics‑parser library with Composer, then enable it.
2. [Configuration](configuration/index.md) — building a feed type with the Ical
   Parser, its two settings, and the mapping sources.

## Where it lives in the admin menu

Feeds Ical has no page of its own. You use it inside Feeds at **Structure → Feed
types** (`/admin/structure/feeds`), by choosing **Ical Parser** as the parser on a
feed type.

## How to use it

1. Create a Feeds **feed type** and choose a **fetcher** for your source (Download
   from URL, Upload file, and so on).
2. Choose **Ical Parser** as the **parser**, and set **Filter Days Before** and
   **Skip Recurrence** as needed.
3. On the **Mappings** tab, map the iCal sources (start/end date, title, body,
   location, UID, …) onto your target entity's fields.
4. Add a feed and import — optionally on a schedule via Feeds' cron settings.

See [Configuration](configuration/index.md) for the field‑by‑field walkthrough.
