# Configuration

## Open the settings form

1. Log in as a user with the **Administer GTFS schedule**
   (`administer gtfs_schedule`) permission.
2. Go to **`/admin/gtfs_schedule/settings`**.

## What to configure

- **Local or remote source** — choose whether the timetable reads a GTFS Core
  install on this same site, or a remote GTFS Core over its REST API.
- **Server connection** — for remote mode, the address of the GTFS server the
  module should query.
- **Feed alias and agency** — identify which feed and which transit agency the
  timetables are for. The module requests schedules per route from
  `agencies/{agency}/routes/{route}/schedules` on the server.
- **Public base path** — the URL segment where timetables are served. Routes then
  appear at `/<base_url>/{route_id}`; the default pattern is
  `/gtfs/routes/{route_id}/schedules`.
- **Time format** — how times are displayed in the cells.
- **"No schedule" message** — your own wording shown for a route that has no
  service.
- **Route naming** — whether routes are labelled by ID or by name.
- **Timepoints vs. full stop list** — by default only timepoints are shown to keep
  long routes readable; the full stop list is available when you want it.

## Stop‑order overrides

For routes where the feed's own stop sequence doesn't match how riders read the
line, you can set a manual order. Stop‑order overrides live at
**`/admin/gtfs_schedule/schedule-order-override`**.

## The cache‑regenerate endpoint — set a key

Schedule responses are cached to files for performance, and the module exposes a
POST endpoint at **`/gtfs_schedule/regenerate_cache`** to invalidate that cache
(useful as a deploy webhook). The endpoint is protected by a **Bearer token** that
it compares against the `regenerate_cache_key` setting.

> **Important:** the token check only runs when a key is set. If
> `regenerate_cache_key` is left **empty**, the check is skipped and the endpoint
> is reachable **without authentication**. It only invalidates the file cache (it
> does not disclose data), but you should still **set a non‑empty
> `regenerate_cache_key`** so the endpoint cannot be triggered anonymously.

## Debugging

A debug form at **`/admin/gtfs_schedule/debug`** (same permission) helps you
inspect schedule requests when a timetable isn't rendering as expected.

## Extending behaviour (for developers)

Several alter hooks let other modules adjust the integration:
`hook_gtfs_schedule_request_arguments_alter()` (change the request arguments),
`hook_gtfs_schedule_version_alter()` (switch the schedule source version), and
`hook_gtfs_schedule_title_alter()` (change the page title). Query parameters such
as `direction_id` and `service_id` can also filter the displayed schedule.
