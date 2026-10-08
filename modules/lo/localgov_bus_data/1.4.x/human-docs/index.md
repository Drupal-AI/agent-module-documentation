# LocalGov Bus Data — manual setup guide

**LocalGov Bus Data** (`localgov_bus_data`) brings UK bus timetable data into
Drupal so a local council website can show residents bus routes, stops, and
timetables. It is built for the **LocalGov Drupal** distribution (the shared
Drupal platform used by many UK councils). It imports bulk **GTFS** timetable
feeds, enriches stop data from **NaPTAN**, and exposes everything as Drupal
entities and Views — including Leaflet maps of stops and route lines.

The imported data is modelled as entities (routes, stops, calendars, trips, and
stop‑times) and surfaced through several visitor‑facing pages:

- **`/buses/routes`** — a searchable list of all routes (service number and name),
  with search by route number and by operator (bus company).
- **`/buses/routes/%/%/%`** — a timetable grid for a route (the three segments are
  the agency ID, route short name, and a **slug**), with day and direction filters
  and a Leaflet map that traces the route. The slug keeps two distinct routes that
  share an operator and route number on separate pages; older two‑segment URLs
  redirect to the right place.
- **`/buses/stops`** — a stop search by name or ATCO code (with indicator, street,
  and locality once NaPTAN enrichment has run).
- **`/buses/stops/%`** — scheduled departures for a single stop (the segment is the
  ATCO stop code), with a day filter and a map.
- **`/buses/map`** — all stops with coordinates, in table format.

**A note on outbound network access (egress):** this module fetches data from
external URLs on the server — a regional bulk GTFS ZIP from the UK Department for
Transport's **Bus Open Data Service (BODS)**, and a NaPTAN access‑nodes CSV. Those
URLs are configured by an administrator, and imports run on cron and on demand, so
the site's server must be able to reach them. Neither feed needs an API key.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, meet the
   database and PHP requirements, enable the module, and optionally add the
   homepage submodule.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   feed URL, area filtering, import schedule, NaPTAN enrichment, custom CSV data,
   and front‑end messages.

## Where it lives in the admin menu

The module's settings form is at **`/admin/config/localgov-bus-data/settings`**.
Custom CSV uploads are at **`/admin/config/localgov-bus-data/custom-data`**, the
import log at **`/admin/config/localgov-bus-data/import-log`**, and the optional
homepage submodule adds its own settings at
**`/admin/config/localgov-bus-data/homepage`**. There are **no council‑specific
defaults** — every value must be configured after installation before imports will
do anything.

## How to use it

1. Install the module and its dependencies (see
   [Installation](installation/index.md)).
2. Open the [settings form](configuration/index.md) and provide a BODS bulk GTFS
   feed URL, restrict it to your area (GeoJSON boundary or bounding box), enable
   imports, and — if you want richer stop details — enable and configure NaPTAN
   enrichment.
3. Let the daily cron import run, or trigger an import manually (or run
   `drush bus-times:import`), then visit `/buses/routes`, `/buses/stops`, and
   `/buses/map` to see the data.
4. Optionally enable the **LocalGov Bus Data Homepage** submodule for a
   public‑facing `/buses` landing page.
