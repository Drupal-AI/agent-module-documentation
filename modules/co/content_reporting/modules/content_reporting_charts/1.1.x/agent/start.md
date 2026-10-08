<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Reporting Charts (content_reporting_charts) — agent index

Submodule of **Content Reporting**. Renders the tracked engagement data as charts on a dedicated
dashboard. Depends on `content_reporting` and `charts:charts`. Core `^9 || ^10 || ^11`,
version 1.1.0-beta23.

## What it provides
- **Route** (`content_reporting_charts.routing.yml`): `content_reporting_charts.dashboard`
  (`/content-reporting/charts-dashboard`) → `ContentReportingChartsController::dashboard`,
  requirement `_permission: 'access content'`, `_admin_route: TRUE`.
- **Controller** `src/Controller/ContentReportingChartsController.php` (DI: `database`). Reads the
  `content_reporting_reports` / `content_reporting_interactions` tables and builds three Charts
  render elements.
- **Theme** `content_reporting_charts_dashboard` (`content_reporting_charts.module`), template
  `templates/content-reporting-charts-dashboard.html.twig` — loops `charts` and prints each.
- **Local task** `content_reporting.charts_dashboard_tab`
  (`content_reporting_charts.links.task.yml`), base route `content_reporting.dashboard`.

No entities, permissions, services, config or schema of its own. Chart rendering is delegated to the
contrib **Charts** module — no chart library is bundled here.

## Solution docs
- Charts dashboard, data queries & routes: `reporting/charts.md`
