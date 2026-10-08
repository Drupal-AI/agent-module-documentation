# Request Audit — manual setup guide

**Request Audit** (`request_audit`) instruments the incoming requests your site
handles and records **latency telemetry** — how long each request took — so you
can monitor performance over time. It can log request timing either to Drupal's
standard log (**Watchdog**) or into its own **database tables**, and it comes with
a charts page that visualizes latency trends and highlights your slowest URLs.

When you enable database logging, the module records per-request timing plus
aggregated latency buckets, and a **Reports → Request Audit Charts** page renders
that data as an interactive Chart.js chart: average latency over time, percentile
bands (p25–p75, median, mean, p95, p99), a filterable table of URLs, and a
"Top 10 slow URLs" section. The chart supports zoom and pan, and refreshes the
URL table as you change the filter, time window, or zoom range.

It supports Drupal 10, 11, and 12. The charting relies on **Chart.js** and a
couple of its plugins being available through the configured library paths.

Because request data can include sensitive information (paths and query
parameters), be deliberate about what you capture and how long you keep it, and
restrict who can reach the settings and reports. All of the module's admin routes
require the strong **Administer site configuration** permission.

> **Note:** Request Audit is minimally maintained and does **not** carry official
> security-advisory coverage. Keep it updated and treat its data as
> operations-sensitive.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and run database updates.
2. [Configuration](configuration/index.md) — the settings form (logging on/off
   and destination) and the charts/reporting page.

## Where it lives in the admin menu

- **Settings:** **Configuration → System → Request audit settings**
  (`request_audit.settings`).
- **Reports:** **Reports → Request Audit Charts**
  (`/admin/reports/request-audit-charts`).

Both require the **Administer site configuration** permission.
