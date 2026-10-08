# Content Telemetry & Performance Insights — manual setup guide

**Content Telemetry & Performance Insights** (`content_telemetry`, often
abbreviated CTPI) gives you always‑on, request‑level performance telemetry for
your Drupal site and then translates it into insights an editor can act on.
Instead of asking a content team to read raw metrics, it tells them which pages
and content are slow and what is likely dragging them down. It instruments every
page request at the PHP level — recording render time, database time, cache‑hit
ratio, and entity metadata — aggregates that data hourly and daily via cron, and
surfaces the results in a purpose‑built admin UI.

A design goal worth calling out up front: **everything stays inside your
database.** There are no external services, no JavaScript trackers, no personal
data collected, and no ongoing costs. That also means there is nothing to
configure for secrets or outbound connections — the module makes no external
API calls, so there is no API key to store and no egress to worry about.

On top of the raw data sits a deterministic, rule‑based **insight engine**. Six
rules fire when configurable thresholds are crossed — for example an average
render time over your performance budget, a database‑heavy request, a low
cache‑hit ratio, a regression against a 7‑day baseline, or a single block
dominating a page's render time. Each insight carries a severity and feeds a
0–100 health score (labelled *Good*, *Needs attention*, or *Critical*). Reports
include a site‑wide dashboard, a per‑node performance tab, and route, Views, and
block breakdowns, plus two read‑only JSON endpoints for monitoring scripts and
CI health checks.

The module depends on core **Node**, **Views**, and **System**, needs
**PHP 8.1+**, and runs on Drupal 10 and 11. It is actively maintained and under
active development. It works as soon as you enable it and run the database
updates, but it does have a real settings form for tuning sampling and the
insight thresholds — see Configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   run the database updates.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   sampling rate, the force‑sample toggle, the render budget, and the insight‑
   rule thresholds.

## Where it lives in the admin menu

- **Dashboard** — **Reports → Content Telemetry**
  (`/admin/reports/content-telemetry`): the site‑wide health score, per‑entity
  health badges, trend indicators, and an insight panel.
- **Per‑node performance** — the **Performance** tab on any node
  (`/node/{id}/performance`): a 24‑hour sparkline, a health badge, metric tiles,
  and per‑node insights.
- **Route, Views, and Block reports** — reachable from the dashboard, plus
  inline performance tabs in **Structure → Views** and **Structure → Block
  layout**.
- **Settings** — **Configuration → System → Content Telemetry**
  (`/admin/config/system/content-telemetry`), covered in
  [Configuration](configuration/index.md).

Access to the reports and the JSON API is gated by the **view content
telemetry** permission; administering settings needs **administer content
telemetry**, and clearing collected data needs **clear content telemetry**.
