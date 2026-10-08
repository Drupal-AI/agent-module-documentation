<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GTFS Schedule renders public-transit timetables for a route by querying a Drupal GTFS REST API (v2) for a configured agency and displaying the schedule as a themed table — stops as columns, trips as rows, times in the cells. Version 3.0.x is a rewrite that consumes the REST API through a dedicated client service rather than reading GTFS storage directly, so a single front-end can render schedules served by either the local site or a remote GTFS server.
---
The module builds a dynamic public route from the `base_url` setting (`GTFSScheduleRouter::routes()`), giving `/<base_url>/{route_id}` (permission `view gtfs_schedule`), served by `GTFSScheduleController::content()`. The controller resolves the route via the `gtfs_schedule.api_client` service (`GtfsApiClient`), then fetches service/direction combinations, per-service and direction-label records (fanned out concurrently with Guzzle), and the selected schedule matrix — all as GTFS REST API v2 requests under `/gtfs/api/v2/feeds/{feed_alias}/…`. Every route/service/direction/agency segment is `rawurlencode`d into the request path. Responses are rendered with Drupal's `table` theme; stop headings link to local `stop` nodes (matched on `field_stop_id`, with `accessCheck(TRUE)`) when they exist. Four alter hooks — `gtfs_schedule_title`, `gtfs_schedule_output`, `gtfs_schedule_header`, `gtfs_schedule_data` — let other modules adjust the title, the whole build, the selector header, and the times grid.

Two data-source modes are chosen by the `use_local` toggle. In **local** mode `baseUrl()` returns this site's own scheme+host and forwards the viewer's `Cookie` header so the REST call runs with the viewer's own session; it expects GTFS Utilities (`gtfs`) 3.x on the same site. In **remote** mode `baseUrl()` returns the admin-set `endpoint_base_url` (validated as an absolute URL in the settings form) and no local GTFS module is required. Admin configuration lives at `/admin/gtfs/schedule/settings` (`GTFSScheduleConfigForm`, permission `administer gtfs_schedule`): route-name type, base URL pattern, feed alias, agency ID, local/remote toggle, remote endpoint, time format, empty placeholder, timepoints-only default, and the no-schedule message. Manual stop-order overrides are stored as `route_stop_order` **config entities** (per route/service/direction/date) through the `entity.gtfs_row.route_stop_order` task route, gated by `gtfs_row.update` entity access plus a custom check restricting it to the `routes` file; an override takes precedence over the API's stop order and survives re-imports.

Compared with 2.0.x this major release removes the file-cache layer, the `/gtfs_schedule/regenerate_cache` POST endpoint (and its Bearer token), and the debug form; it moves the settings path and replaces the old request/version alter hooks. Typical setup: pick local or remote, set the agency ID (required) and feed alias, set the base URL pattern (must start with `/` and contain `{route_id}`), then link riders to `/<base_url>/<route_id>`.
---
- Show a bus or train route's timetable on a public page.
- Serve schedules from a GTFS Utilities install on the same site (local mode).
- Point a front-end-only site at a remote GTFS server's REST API (remote mode).
- Decouple the public timetable site from the feed importer's release cycle.
- Configure the agency ID and feed alias the timetables are for.
- Set the public base path/URL pattern where schedules are served.
- Name routes in the URL by route ID, short name, or long name.
- Show timepoints only by default to keep long routes readable.
- Choose the displayed time format for schedule cells.
- Print a custom placeholder in cells that have no stoptime.
- Display a custom "no schedule" message when a route has no service.
- Override a route's stop order manually when the feed sequence reads wrong.
- Keep stop-order overrides as config so they survive feed re-imports.
- Link stop headings through to local `stop` node pages.
- Filter the displayed grid by `direction_id`, `service_id`, and `date` query args.
- Grant `view gtfs_schedule` to anonymous or authenticated roles for public riders.
- Restrict configuration to `administer gtfs_schedule` holders.
- Alter the schedule page title via `hook_gtfs_schedule_title_alter()`.
- Alter the whole render build via `hook_gtfs_schedule_output_alter()`.
- Alter the service/direction selector header via `hook_gtfs_schedule_header_alter()`.
- Alter the times grid via `hook_gtfs_schedule_data_alter()`.
- Render schedules for many routes under one configurable base path.
- Run one public front-end against several agencies' feeds by feed alias.
- Expand calendar-date services into one selectable entry per upcoming date.
