<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Bus Data imports UK bus timetable (GTFS) data and NaPTAN stop details into entities, and displays them as searchable Views with Leaflet route maps.

---

LocalGov Bus Data brings UK bus timetable data into Drupal as entities (routes, stops, calendars, trips, stop-times) and Views. It downloads a regional bulk GTFS ZIP from an administrator-configured BODS URL, filters it to a council area with a GeoJSON boundary or bounding box, stages the CSVs, and runs five Migrate migrations. Optional NaPTAN enrichment adds stop indicator, street, and locality. Imports run via Drush (`bus-times:import`, with `--full` and `--dry-run`), on cron against a configurable schedule (incremental daily, full weekly), or from the settings form's "Import now" button. Custom GTFS-format CSV files can supplement the feed with all-or-nothing validation.

Visitor pages live under `/buses`: a route list with route-number and operator search, a per-route timetable grid (`/buses/routes/{agency_id}/{route_short_name}/{slug}`) with day/direction filters and a Leaflet map that traces the service using GTFS shape geometry (or straight stop-to-stop lines where shapes are absent), a stop search, per-stop scheduled departures, and a stop map. Old two-segment route URLs 302-redirect to the new three-segment ones. It exposes per-entity CRUD permissions for each bus-data entity type plus `administer localgov bus data`; depends on core `datetime`/`file`/`migrate`/`views`, `geofield`, `leaflet` (+ views/markercluster), `migrate_plus`, and `migrate_source_csv`; supports Drupal 10.2+ and 11 on MySQL/MariaDB (SQLite and PostgreSQL are not supported).

---

- Import UK bus timetable data from a bulk GTFS feed.
- Fetch the regional GTFS ZIP from a configured BODS URL.
- Filter the national feed to a council area by GeoJSON boundary.
- Filter to an area by N/S/E/W bounding box instead.
- Enrich stops with NaPTAN indicator, street, and locality.
- Model routes, stops, calendars, trips, and stop-times as entities.
- Supplement the feed with custom GTFS-format CSV uploads.
- Validate custom CSV data all-or-nothing before import.
- Run incremental imports that add, update, and delete rows.
- Force a full truncate-and-reimport when needed.
- Schedule automatic imports via cron expression.
- Trigger an import on demand from the settings form.
- Import from the command line with Drush `bus-times:import`.
- Seed development fixtures with `bus-times:seed`.
- Display a searchable list of all bus routes.
- Search routes by route number or by operator name.
- Show a timetable grid (stops x trips) per route.
- Filter timetables by day type and direction.
- Draw the route line on a Leaflet map from shape geometry.
- Search bus stops by name or ATCO code.
- Show scheduled departures for a single stop.
- Map all stops with coordinates.
- Provide a public `/buses` landing page (homepage submodule).
- Autocomplete stop and operator names on search forms.
- Gate imports and configuration behind `administer localgov bus data`.
- Serve UK local council and resident transit-information use cases.
