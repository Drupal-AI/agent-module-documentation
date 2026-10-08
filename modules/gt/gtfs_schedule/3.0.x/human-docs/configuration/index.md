# Configuration

## Open the settings form

1. Log in as a user with the **Administer GTFS Schedules**
   (`administer gtfs_schedule`) permission.
2. Go to **`/admin/gtfs/schedule/settings`** (GTFS › Schedule Settings).

## What to configure

- **Use the local GTFS server** — when checked, schedule data is fetched from the
  GTFS REST API on *this* site. Uncheck it to read a remote GTFS server instead.
- **Remote GTFS server base URL** — remote mode only. The scheme and host of the
  other site's GTFS server, for example `https://gtfs.example.com`. The form
  requires this to be a valid absolute URL when local mode is off.
- **Feed alias** — which feed to read (the `{feed_alias}` segment of the REST API
  path). Leave empty to use the server's default feed.
- **Agency ID** — the GTFS `agency_id` whose routes these timetables cover
  (required).
- **Base URL for schedule pages** — the URL pattern where timetables are served.
  It **must start with `/`** and **contain `{route_id}`**. Routes then appear at
  `/<base_url>/{route_id}`; the default is `/gtfs/routes/{route_id}/schedules`.
- **Route Name Type** — whether the `{route_id}` in the URL is the route ID, the
  route short name, or the route long name.
- **Time format** — a PHP date format string for the times in the cells.
- **Empty Value Placeholder** — what to print in a cell that has no stoptime.
- **Timepoints only** — show only stops flagged as timepoints by default, to keep
  long routes readable.
- **No Schedule Message** — your own wording shown for a route with no service.

## Stop‑order overrides

For routes where the feed's own stop sequence doesn't match how riders read the
line, you can set a manual order. An override applies to the timetable only — it
does not modify imported data, and because it is stored as **configuration** rather
than content, it survives re‑imports.

The stop‑order screens are reached from a route's **Stop Order** tab and are
provided together with GTFS Utilities, so they are available in **local mode
only**. In remote mode the timetable follows whatever order the remote API returns.

## Extending behaviour (for developers)

Four alter hooks let other modules adjust the rendered timetable:
`hook_gtfs_schedule_title_alter()` (the page title),
`hook_gtfs_schedule_output_alter()` (the whole render build),
`hook_gtfs_schedule_header_alter()` (the service/direction selector), and
`hook_gtfs_schedule_data_alter()` (the times grid). Query parameters
`direction_id`, `service_id`, and `date` select which matrix is shown.

> **Changed in 3.0.x.** Earlier versions cached schedule responses to files and
> exposed a `regenerate_cache` POST endpoint and a debug form. Those have been
> removed in this release — there is no cache key to set and no debug form to
> visit.
