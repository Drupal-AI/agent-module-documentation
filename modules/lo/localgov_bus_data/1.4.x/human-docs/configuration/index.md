# Configuration

All of LocalGov Bus Data's settings live in the `localgov_bus_data.settings`
configuration and are managed from one form at
**`/admin/config/localgov-bus-data/settings`**. There are **no council‑specific
defaults** — every value must be set after installation, and until you provide a
feed URL and switch imports on, nothing is imported.

You need the **Administer LocalGov bus data** permission
(`administer localgov bus data`) to reach this form, the custom‑data form, and the
import log.

## Data source and area

- **Bulk GTFS URL** (`source.bulk_gtfs_url`, default empty) — the URL of a
  regional bulk GTFS ZIP from the BODS timetable download page. This is the main
  feed the importer downloads from, so the server must be able to reach it. The
  form lists every DfT region's download URL to copy from.
- **Boundary GeoJSON** (`source.boundary_geojson`, default empty) — a GeoJSON
  Polygon or MultiPolygon (Feature, FeatureCollection, and GeometryCollection
  wrappers are accepted) used to filter the national feed down to your area. If
  set, it **takes precedence** over the bounding box.
- **Bounding box** (`source.bounding_box`, default empty) — north/south/east/west
  coordinates used to filter the feed to your area when you are not using a GeoJSON
  boundary. Provide all four, or leave all four empty.
- **Enabled** (`source.enabled`, default `false`) — the master switch that allows
  imports to run at all (both scheduled cron imports and manual ones). Leave this
  off until the feed URL and area filter are configured.

Below these fields, the **Import now** button runs a full download‑and‑reimport
immediately (as a batch); it stays disabled until you have saved a feed URL.

## Import scheduling and logs

- **Import schedule** (`import.schedule`, default `0 3 * * *`) — a cron expression
  for the automatic daily import. Note: it supports only `*` and exact integers —
  **not** ranges, steps, or lists. If the expression cannot be parsed, the module
  falls back to a fixed early‑morning window. Daily cron runs are incremental
  (only changed rows), and a full re‑import runs about once a week.
- **Log retention** (`import.log_retention`, default `30`) — how many days to keep
  import log entries before they are pruned. View the log at
  `/admin/config/localgov-bus-data/import-log`.

You can also import from the command line: `drush bus-times:import` (incremental),
`drush bus-times:import --full` (full truncate‑and‑reimport), or
`--dry-run` to preview.

## NaPTAN enrichment

NaPTAN enrichment adds richer stop details (indicator, street, locality) and
populates the locality data the homepage submodule relies on.

- **NaPTAN enabled** (`naptan.enabled`, default `false`) — turn on the NaPTAN
  enrichment step.
- **NaPTAN URL** (`naptan.url`, default empty) — the URL of the NaPTAN
  access‑nodes CSV. As with the GTFS feed, the server fetches this URL, so it must
  be reachable. No API key is required. A **Update stop details now** button runs
  enrichment on demand without a full re‑import.

## Custom CSV data

At **`/admin/config/localgov-bus-data/custom-data`** you can upload your own
GTFS‑format CSV files (agency, routes, stops, calendar, trips, stop times) to
supplement rows missing from the bulk feed — for example a community transport
service not registered with BODS. Uploads are validated **all‑or‑nothing**: if any
row in any file fails, the whole upload is rejected with a per‑row report and
nothing is saved. Custom data supplements the feed and never overrides an ID that
already exists in it. An import must have run first, because uploads are validated
against the staged feed. Disabling **Enable custom data** keeps the stored files
but skips the merge step at the next import.

## Front‑end messages

Two visitor‑facing notices are edited under **Front‑end messages** on the settings
form (`messages.bank_holiday_notice` and `messages.specific_dates_notice`). Both
accept standard Drupal admin HTML tags and are XSS‑filtered on output; leaving
either empty hides that notice. The bank holiday notice is rendered by a Views
area handler, so it can also be placed in the header, footer, or no‑results area
of any view.

## After saving

Save the form, then either wait for the scheduled cron import or trigger an import
manually. Once data has been imported, check the visitor pages (`/buses/routes`,
`/buses/stops`, `/buses/map`). If you plan to use the homepage submodule, enable
NaPTAN and let enrichment run first, since the interchange and area‑browse features
depend on the locality data it produces.

> **Config deployment note:** several settings here (and the 1.3.x → 1.4.x update
> hooks) write to active configuration. On a site that deploys config from a
> repository, run `drush config:export` and commit after changing settings or
> running `drush updatedb`, or the next `drush config:import` will revert them.
