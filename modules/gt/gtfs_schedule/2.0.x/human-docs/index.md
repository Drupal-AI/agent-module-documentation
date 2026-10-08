# GTFS Schedule — manual setup guide

**GTFS Schedule** (`gtfs_schedule`) turns transit schedule data into a readable
public timetable: stops down the side, trips across the top, times in the cells.
It renders one timetable page per route, at a URL pattern you control, and it gets
its data from a Drupal **GTFS Core** install — either on the same site, or a
remote one reached over that site's REST API.

That local‑or‑remote choice is the module's most useful feature. You can run the
timetable on the same site that holds and imports the feed, or you can point a
public‑facing website at a *separate* site's GTFS API — handy when the importer
and the public site are different builds on different release cycles.

It is built for real timetables, not raw data dumps. By default it shows only the
route's timepoints (so a long route doesn't become an unreadable wall of numbers),
with the full stop list available when you want it. You can override the stop
order for routes where the feed's own sequence doesn't match how riders read the
line, choose your own time format and "no service" wording, name routes by ID or
by name, and link stop headings through to their own pages so the timetable
becomes a way into the rest of the site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (plus GTFS Core if you are running in local mode).
2. [Configuration](configuration/index.md) — connect to the GTFS server, choose
   the agency, set the public URL pattern, and secure the cache‑regenerate
   endpoint.

## Where it lives in the admin menu

The settings form is under Drupal's administration at
**`/admin/gtfs_schedule/settings`** and a debug form at
**`/admin/gtfs_schedule/debug`**, both gated by the **Administer GTFS schedule**
(`administer gtfs_schedule`) permission. Timetables themselves are served at the
public path you configure — `/<base_url>/{route_id}` — gated by the **View GTFS
schedule** (`view gtfs_schedule`) permission.

## Related modules

GTFS Schedule is one piece of a family that all read from **GTFS Core** (the
entities, importer, and API): **GTFS Realtime** (trip updates, vehicle positions,
alerts), **GTFS Display** and **GTFS Display Map** (public screens and maps),
**GTFS 511**, and **GTFS+**.
