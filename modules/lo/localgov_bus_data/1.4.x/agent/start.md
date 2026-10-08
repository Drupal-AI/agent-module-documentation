<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Bus Data — agent index

**UK bus timetable data** (GTFS + NaPTAN) as entities + Views + Leaflet maps. Version **1.4.0**. Core `^10.2 || ^11`, PHP 8.3+, MySQL/MariaDB only (uses `GROUP_CONCAT`).

Imports a regional bulk **GTFS** ZIP from an admin-configured URL (UK DfT BODS), filters it to a council area (GeoJSON boundary or bounding box), stages CSVs to `public://bus-times/gtfs/`, and runs five Migrate migrations into entities: route, stop, calendar, trip, stop_time. Optional **NaPTAN** CSV enrichment (indicator/street/locality). No API key is required for either feed.

## Entities & permissions
Per-entity CRUD perms for each of `localgov_bus_route` / `localgov_bus_stop` / `localgov_bus_calendar` / `localgov_bus_trip` / `localgov_bus_stop_time`, plus `administer localgov bus data` (`restrict access: true`) gating all settings, import triggers, custom-CSV upload, and structure/content admin pages.

## Import triggers (all admin/CLI)
- Drush: `bus-times:import` (incremental add/update/delete), `--full` (truncate+reimport), `--dry-run`; `bus-times:seed` (dev fixtures).
- `hook_cron()`: runs when the config cron expression matches (`import.schedule`, default `0 3 * * *`; only `*` and exact integers, else a 02:00–04:00 window fallback). Weekly full import; 3600 s overlapping-run guard via state.
- Settings form **Import now** button (batch, full reimport); **Update stop details now** (NaPTAN only).

## Public (`_access: TRUE`) surface — read-only
- Views pages under `/buses/*`: `/buses/routes`, `/buses/routes/{agency_id}/{route_short_name}/{slug}` (timetable grid, `BusTimetableStyle`), `/buses/stops`, `/buses/stops/{atco}`, `/buses/map`.
- `/bus-times/autocomplete/stops` and `/bus-times/autocomplete/operators` — JSON, parameterised queries (`escapeLike`/entity query with `accessCheck(TRUE)`), 128-char cap, names only.
- `/buses/routes/{agency_id}/{route_short_name}` — legacy 2-segment redirect controller (302 to the 3-segment timetable, or to filtered search).
- Optional submodule `localgov_bus_data_homepage`: public `/buses` landing page (config-driven intro/search/interchange/area-browse).

## Key services (`src/Service/`)
`GtfsDownloader` (Guzzle, config URL, range/chunk), `GtfsFilter` (geo filter on local staged files), `GtfsImportService` (pipeline/batch), `NaptanImportService` (CSV enrich, batched CASE UPDATE with placeholders), `CustomCsvManager`/`CustomCsvValidator` (all-or-nothing custom GTFS upload at `/admin/config/localgov-bus-data/custom-data`), `RoutePolylineService` (route map line, shape geometry or straight fallback), `AgencyNameResolver`, `DatabaseKeepalive`.

## Diff 1.3.x → 1.4.x
- Version `1.3.0` → `1.4.0`.
- Timetable URL gained a third **slug** segment (`/buses/routes/{agency_id}/{route_short_name}/{slug}`) so distinct GTFS routes sharing an operator+number no longer merge onto one grid; old 2-segment URLs 302-redirect via `BusRouteRedirectController` + `BusRouteRedirectRouteSubscriber` (updates 10011/10012 rewrite the view args; export config after `updatedb`). README calls this the pre-1.4.x behaviour it fixes.
- Route maps draw a connecting line following `shapes.txt` shape geometry when present, straight stop-to-stop segments otherwise (`RoutePolylineService`, `hook_leaflet_views_features_alter`).
- Bank-holiday and specific-dates notices moved from hard-coded Views/`t()` text into `localgov_bus_data.settings` (`messages.*`), rendered via the `localgov_bus_data_bank_holiday_notice` Views area handler; XSS-filtered admin HTML (update 10009).
- Operator (bus company) search + autocomplete on the routes page and homepage (`OperatorAutocompleteController`).
- Custom CSV supplement upload (six GTFS files, all-or-nothing validation; config `custom_data.*`, update 10008).
- Incremental import with change detection (`track_changes`), weekly full re-import, overlapping-run guard, `DatabaseKeepalive`; config gained `import.schedule_window`.
- Drush commands now provided (`bus-times:import`, `bus-times:seed`) — `data.json` `provides_drush_commands` corrected to `true`.
