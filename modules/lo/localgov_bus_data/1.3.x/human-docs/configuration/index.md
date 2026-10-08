# Configuration

All of LocalGov Bus Data's settings live in the `localgov_bus_data.settings`
configuration and are managed from one form at
**`/admin/config/localgov-bus-data/settings`**. There are **no council‑specific
defaults** — every value must be set after installation, and until you provide a
feed URL and switch imports on, nothing is imported.

You need the **Administer LocalGov bus data** permission
(`administer localgov bus data`) to reach this form.

## Data source and area

- **Bulk GTFS URL** (`source.bulk_gtfs_url`, default empty) — the URL of a
  regional bulk GTFS ZIP from the BODS timetable download page. This is the main
  feed the importer downloads from, so the server must be able to reach it.
- **Boundary GeoJSON** (`source.boundary_geojson`, default empty) — a GeoJSON
  Polygon or MultiPolygon used to filter the national feed down to your area. If
  set, it **takes precedence** over the bounding box.
- **Bounding box** (`source.bounding_box`, default empty) — north/south/east/west
  coordinates used to filter the feed to your area when you are not using a GeoJSON
  boundary.
- **Enabled** (`source.enabled`, default `false`) — the master switch that allows
  imports to run at all (both scheduled cron imports and manual ones). Leave this
  off until the feed URL and area filter are configured.

## Import scheduling and logs

- **Import schedule** (`import.schedule`, default `0 3 * * *`) — a cron expression
  for the automatic daily import. Note: it supports only `*` and exact integers —
  **not** ranges or steps.
- **Log retention** (`import.log_retention`, default `30`) — how many days to keep
  import log entries before they are pruned.

## NaPTAN enrichment

NaPTAN enrichment adds richer stop details (indicator, street, locality) and
populates the locality data the homepage submodule relies on.

- **NaPTAN enabled** (`naptan.enabled`, default `false`) — turn on the NaPTAN
  enrichment step.
- **NaPTAN URL** (`naptan.url`, default empty) — the URL of the NaPTAN
  access‑nodes CSV. As with the GTFS feed, the server fetches this URL, so it must
  be reachable.

## After saving

Save the form, then either wait for the scheduled cron import or trigger an import
manually. Once data has been imported, check the visitor pages (`/buses/routes`,
`/buses/stops`, `/buses/map`). If you plan to use the homepage submodule, enable
NaPTAN and let enrichment run first, since the interchange and area‑browse features
depend on the locality data it produces.
