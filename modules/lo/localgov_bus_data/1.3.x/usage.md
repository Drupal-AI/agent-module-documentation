<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Bus Data imports UK bus timetable (GTFS-style) data into entities with map/Views display.

---

LocalGov Bus Data brings UK bus timetable data into Drupal as entities (routes, stops, calendars, trips, stop-times) and Views — imported via Migrate from CSV sources and displayed with Leaflet maps — so local council websites can present bus timetables and stop maps to residents.

It exposes CRUD permissions per bus-data entity type (route/stop/calendar/trip/stop_time) plus `administer localgov bus data`. Depends on core `datetime`/`file`/`migrate`/`views`, `geofield`, `leaflet` (+ views/markercluster), `migrate_plus`, and `migrate_source_csv`; supports Drupal 10.2+ and 11.

---

- Import UK bus timetable data.
- Model routes/stops/calendars/trips/stop-times as entities.
- Display data in Views.
- Show stops on Leaflet maps.
- Import via Migrate from CSV.
- Serve council/resident use cases.
- Expose per-entity CRUD permissions.
- Gate `administer localgov bus data`.
- Depend on core `migrate`/`views`, `geofield`, `leaflet`.
- Depend on `migrate_plus` and `migrate_source_csv`.
- Support Drupal 10.2+ and 11.
- Present timetables.
- Map bus stops
- Support local government.
- Manage bus entities.
- Import CSV sources.
- Display geospatial data.
- Serve transit info
