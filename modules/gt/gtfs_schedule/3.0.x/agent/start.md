<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GTFS Schedule (gtfs_schedule) — agent index
**Renders transit route timetables by consuming a Drupal GTFS REST API (v2) for a configured agency — local site or a remote GTFS server.**

- **Version:** 3.0.x (major rewrite; 3.0.0 installed)
- **Core:** ^10.3 || ^11
- **Routes:**
  - dynamic `gtfs_schedule.schedule` at the configured `base_url` pattern `/<base_url>/{route_id}` (perm `view gtfs_schedule`) — built by `Routing\GTFSScheduleRouter::routes()`, served by `Controller\GTFSScheduleController::content()`
  - `gtfs_schedule.settings` at `/admin/gtfs/schedule/settings` (perm `administer gtfs_schedule`)
  - `entity.gtfs_row.route_stop_order` at `/admin/gtfs/{gtfs_filename}/{gtfs_row}/stop_order/{override_id}` (requires `_entity_access: gtfs_row.update` + a custom access callback restricting to the `routes` file)
- **Configure:** `gtfs_schedule.settings`
- **Permissions:** `view gtfs_schedule`, `administer gtfs_schedule`
- **Service:** `gtfs_schedule.api_client` (`GtfsApiClient`) — centralises all outbound GTFS REST calls (Guzzle).
- **Config entity:** `route_stop_order` — a per route/service/direction/date manual stop ordering, stored as config (survives re-imports).
- **Alters:** `gtfs_schedule_title`, `gtfs_schedule_output`, `gtfs_schedule_header`, `gtfs_schedule_data`.

## How it works
The module holds **no GTFS storage of its own**. It reads schedule data over the GTFS REST API v2
(`/gtfs/api/v2/feeds/{feed_alias}/…`). Two modes, set by the `use_local` toggle:
- **Local** — `baseUrl()` is this site's own scheme+host; the viewer's `Cookie` header is forwarded so
  the REST call runs with the viewer's session. Requires [GTFS Utilities](https://www.drupal.org/project/gtfs) (`gtfs`) 3.x on the same site.
- **Remote** — `baseUrl()` is the admin-set `endpoint_base_url`; no local GTFS dependency (front-end-only site).

`GtfsApiClient` fans out concurrent Guzzle GET requests (services + direction labels), decodes the `data`
envelope, and the controller renders a themed table (stops as columns, trips as rows, times in cells).
Stop headings link to local `stop` nodes (`field_stop_id`) when present. Manual `route_stop_order`
overrides take precedence over the API's stop order.

## Changes from 2.0.x (major bump — re-derive, do not assume 2.x facts)
- Rewritten to consume the **GTFS REST API v2** through the `gtfs_schedule.api_client` service; the old
  in-module request helper is gone.
- **Removed** the file-cache layer, the `/gtfs_schedule/regenerate_cache` POST endpoint (and its Bearer
  token), and the `/admin/gtfs_schedule/debug` form.
- Settings path moved `/admin/gtfs_schedule/settings` → `/admin/gtfs/schedule/settings`.
- Alter hooks replaced: old `*_request_arguments_alter` / `*_version_alter` → `gtfs_schedule_title`,
  `gtfs_schedule_output`, `gtfs_schedule_header`, `gtfs_schedule_data`.
- New `route_stop_order` config entity + stop-order override task route.
- New config keys `use_local`, `endpoint_base_url`, `timepoints_only_default`.
- Core requirement raised to `^10.3 || ^11` (drops 8/9).

**Security:** display route is `view gtfs_schedule` (public transit info); config and stop-order routes
are admin/entity-access gated. Outbound REST paths are `rawurlencode`d (no path injection); no raw SQL,
no zip/feed import, no stored credentials. Remote `endpoint_base_url` is admin-only config.
