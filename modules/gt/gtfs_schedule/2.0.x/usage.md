<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GTFS Schedule renders public-transit timetables for a route by querying a Drupal GTFS Server API for a configured agency and displaying the schedule as a themed table.
---
The module exposes a configurable public path (`base_url` setting) with a dynamic route `/<base_url>/{route_id}` (permission `view gtfs_schedule`) that calls `GTFSScheduleController::content()`. That controller looks up the route, requests `agencies/{agency}/routes/{route}/schedules` from the GTFS server via a `gtfs_schedule_request()` helper, applies time-format and timepoint filters, and renders `gtfs_schedule_table`/`gtfs_schedule_header` templates. Admin forms at `/admin/gtfs_schedule/settings` and `/admin/gtfs_schedule/debug` (permission `administer gtfs_schedule`) configure the server, agency, formats, and messages. Schedule responses are cached to files under a cache location and can be invalidated.

A cache-regeneration endpoint `/gtfs_schedule/regenerate_cache` (`RegenerateCacheController`) accepts POST + `application/json` and is gated by a custom `access()` method that compares a `Bearer` token against the `regenerate_cache_key` config value. **Note:** the token comparison is only enforced `if ($lock && ...)` — when `regenerate_cache_key` is empty/unset the check is skipped and the endpoint is reachable unauthenticated (it invalidates the file cache, not data disclosure). Multiple `hook_alter` points let other modules adjust the request arguments, version, and title.

Typical setup: configure the GTFS server + agency and the public base path in settings, set a non-empty `regenerate_cache_key`, then link to `/<base_url>/<route_id>`.
---
- Show a bus/train route's timetable on a public page.
- Integrate a Drupal GTFS Server as the schedule data source.
- Configure the agency and server connection via the settings form.
- Set the public base path where schedules are served.
- Filter schedules to timepoints only by default.
- Choose the displayed time format.
- Display a "no schedule" message when data is missing.
- Cache schedule responses to files for performance.
- Invalidate/regenerate the schedule cache via a POST endpoint.
- Protect the regenerate endpoint with a Bearer secret key.
- Debug schedule requests via the debug form.
- Alter request arguments with `hook_gtfs_schedule_request_arguments_alter()`.
- Alter the page title with `hook_gtfs_schedule_title_alter()`.
- Switch schedule source version via `hook_gtfs_schedule_version_alter()`.
- Filter by `direction_id`/`service_id` query parameters.
- Grant `view gtfs_schedule` to anonymous or authenticated roles.
- Restrict configuration to `administer gtfs_schedule` holders.
- Theme the schedule table via the provided templates.
- Serve schedules for multiple routes under one base path.
- Rebuild caches on a deploy via an authenticated webhook.
