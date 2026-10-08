# GTFS Schedule — manual setup guide

**GTFS Schedule** (`gtfs_schedule`) turns transit schedule data into a readable
public timetable: stops down the side, trips across the top, times in the cells.
It renders one timetable page per route, at a URL pattern you control, and it gets
its data from a Drupal **GTFS Utilities** install — either on the same site, or a
remote one reached over that site's REST API.

That local‑or‑remote choice is the module's most useful feature. You can run the
timetable on the same site that holds and imports the feed, or you can point a
public‑facing website at a *separate* site's GTFS API — handy when the importer
and the public site are different builds on different release cycles. In remote
mode the module has no hard dependency on GTFS Utilities, so a front‑end‑only site
can install it alone.

It is built for real timetables, not raw data dumps. By default it shows only the
route's timepoints (so a long route doesn't become an unreadable wall of numbers),
with the full stop list available when you want it. You can override the stop
order for routes where the feed's own sequence doesn't match how riders read the
line, choose your own time format and "no service" wording, name routes by ID or
by name, and link stop headings through to their own pages so the timetable
becomes a way into the rest of the site.

> **New in 3.0.x.** This major release is a rewrite that reads schedule data over
> the GTFS REST API through a dedicated client, rather than reading GTFS storage
> directly. The old file‑cache layer, the `regenerate_cache` POST endpoint, and
> the debug form have been removed, and the settings form has moved to
> **`/admin/gtfs/schedule/settings`**. See [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (plus GTFS Utilities if you are running in local mode).
2. [Configuration](configuration/index.md) — connect to the GTFS server, choose
   the agency, and set the public URL pattern.

## Where it lives in the admin menu

The settings form is under **GTFS › Schedule Settings** at
**`/admin/gtfs/schedule/settings`**, gated by the **Administer GTFS Schedules**
(`administer gtfs_schedule`) permission. Timetables themselves are served at the
public path you configure — `/<base_url>/{route_id}` — gated by the **View GTFS
Schedules** (`view gtfs_schedule`) permission.

## Related modules

GTFS Schedule is one piece of a family that all read from **GTFS Utilities** (the
entities, importer, and API): **GTFS Realtime** (trip updates, vehicle positions,
alerts), **GTFS Display** and **GTFS Display Map** (public screens and maps),
**GTFS 511**, and **GTFS+**.
