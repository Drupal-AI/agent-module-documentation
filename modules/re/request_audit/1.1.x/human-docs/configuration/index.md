# Configuration

Request Audit has two screens: a **settings form** that controls whether and how
telemetry is collected, and a **charts page** that visualizes the collected
latency data. Both require the **Administer site configuration** permission.

## Open the settings form

Go to **Configuration → System → Request audit settings**
(`request_audit.settings`).

### Settings, field by field

- **Log activity** (`active`) — the master switch. When off, the module records
  nothing. Turn it on to begin collecting request latency telemetry.
- **Log destination** (`log_to`) — where the telemetry goes:
  - **`watchdog`** — the timing payload is written to Drupal's standard logger
    (viewable wherever your logger backends surface Watchdog entries).
  - **`database`** — request timing and aggregated latency are stored in the
    module's own database tables, which is what powers the charts page and the
    per-URL reporting.
- **Log database activity** (`database_log`) — when using the database
  destination, controls whether database activity is recorded as part of the
  telemetry.
- **Log queries list** (`save_queries`) — whether the list of queries is stored
  alongside the request timing. This captures more detail (and more data), so
  enable it only while you actively need that level of insight.

Choose the **database** destination if you want to use the charts and per-URL
tables; choose **watchdog** if you only need the timing in your normal logs.

Save the form to apply your choices.

> **Privacy/retention:** request data can include paths and query parameters that
> reveal sensitive information. Capture only what you need, keep an eye on how much
> data accumulates in the database tables, and restrict who can read the settings
> and reports.

## The charts / reporting page

Go to **Reports → Request Audit Charts**
(`/admin/reports/request-audit-charts`). This page reads the database telemetry
and includes:

- **A URL pattern control** — a glob-like filter (for example `/pay2/*`) to focus
  on a subset of URLs.
- **A time window selector** — choose the period the chart and table cover.
- **An auto-refreshing, zoomable Chart.js chart** — with drag-zoom and pan
  support.
- **A URL table** — the URLs matching the current filter and range.
- **A "Top 10 slow URLs" section** — computed from average latency across recent
  buckets.

### Chart series

The chart derives these series from the visible buckets:

- **Avg latency (ms)** — the average latency of the shown buckets (the main line).
- **p25–p75** — the middle 50% of bucket values, showing the typical spread.
- **Median** — the middle value of the distribution; more robust than the average
  when there are spikes.
- **Mean** — arithmetic average of displayed buckets; sensitive to large outliers.
- **p95** — the value below which 95% of buckets fall; useful for slow-tail
  latency.
- **p99** — the value below which 99% of buckets fall; useful for severe tail
  latency and rare spikes.

### The URL table

The table under the chart refreshes automatically — on initial load, when the
filter pattern changes, when the time window changes, and when you zoom into or
reset a range. For each URL it shows its position in the result set, the URL path,
the number of requests, and the average, minimum, and maximum latency.
