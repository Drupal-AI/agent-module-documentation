<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI: dashboard, drilldowns, tabs, routes & permissions

All routes in `content_telemetry.routing.yml`. Controllers in `src/Controller/`. Unless noted,
every UI route requires **`view content telemetry`**.

## Permissions (`content_telemetry.permissions.yml`)

- `view content telemetry` — all UI pages, tabs and the JSON API.
- `administer content telemetry` — the settings form only.
- `clear content telemetry` — declared, **not wired to any route/controller** in this release.

## Routes

| Route id | Path | Controller::method | Requirement |
|---|---|---|---|
| `content_telemetry.dashboard` | `/admin/reports/content-telemetry` | `DashboardController::overview` | view |
| `content_telemetry.settings` | `/admin/config/system/content-telemetry` | `Form/SettingsForm` | administer |
| `content_telemetry.node_performance` | `/node/{node}/performance` | `EntityPerformanceController::node` | view (`node: \d+`) |
| `content_telemetry.view_performance` | `/admin/structure/views/view/{view}/performance` | `ViewPerformanceController::view` | view |
| `content_telemetry.block_performance` | `/admin/structure/block/manage/{block}/performance` | `BlockPerformanceController::block` | view |
| `content_telemetry.route_report` | `/admin/reports/content-telemetry/routes` | `RoutePerformanceController::overview` | view |
| `content_telemetry.view_report` | `/admin/reports/content-telemetry/views` | `ViewPerformanceReportController::overview` | view |
| `content_telemetry.view_drilldown` | `/admin/reports/content-telemetry/views/{view}/{display}` | `ViewDrilldownController::overview` | view |
| `content_telemetry.route_drilldown` | `/admin/reports/content-telemetry/routes/{route}` | `RouteDrilldownController::overview` | view (`route: .+`) |
| `content_telemetry.block_report` | `/admin/reports/content-telemetry/blocks` | `BlockReportController::overview` | view |
| `content_telemetry.test_route` | `/ctpi-test` | `TestRouteController::page` | `administer site configuration` |
| `content_telemetry.api_insights_entity` | `/api/content-telemetry/insights/{entity_type}/{entity_id}` | `InsightApiController::entity` | view (`no_cache`) |
| `content_telemetry.api_insights_dashboard` | `/api/content-telemetry/insights/dashboard` | `InsightApiController::dashboard` | view (`no_cache`) |

(API endpoints: see [../api/insights-api.md](../api/insights-api.md).)

## Menu links & tabs

- `content_telemetry.links.menu.yml`: dashboard under *Reports*; settings under *Config → System*;
  the route/view/block reports as children of the dashboard.
- `content_telemetry.links.task.yml`: a *Performance* local task on `entity.node.canonical`
  (weight 50) → the per-node performance tab. The view/block performance routes attach on the Views
  and Block-layout admin UIs.

## What each page shows

- **DashboardController::overview** — site-wide health-score widget, an "Overview" list of tracked
  entities with per-row health badge (0-100) and trend pill, and the dashboard insight panel
  (`InsightService::analyzeDashboard()`).
- **EntityPerformanceController::node** — per-node: status label, 24-hour inline SVG sparkline,
  metric tiles (avg/max render, avg DB, cache-hit) and the node's insight panel. Returns an
  "unavailable" message when no aggregate data exists yet.
- **RoutePerformanceController::overview** — all tracked routes ranked by avg render, each with a
  mini sparkline, status badge, trend and a link into the route drilldown.
- **RouteDrilldownController::overview** — one route: full 24h sparkline, baseline trend widget,
  block-level contribution rows and insights. The `{route}` value is reflected via a `t()` `@route`
  placeholder (escaped).
- **ViewPerformanceReportController / ViewDrilldownController** — Views displays and their
  block-level breakdown. Note view render times are recorded as 0 (see engine doc), so view metrics
  are coarse.
- **BlockPerformanceController::block** — per-block performance for one block config.
- **BlockReportController::overview** — top slowest blocks site-wide; resolves human labels/types
  from the block plugin manager, shows the CRC32 masked id, avg/max render and samples. Falls back
  to the raw table if the aggregate table is absent.

## Rendering & data provenance

Pages build render arrays from aggregate-table rows via `EntityPerformanceProvider` and the block
report's own query. Displayed labels (route machine names, block plugin labels/types) are
system/admin-derived, not end-user free text; dynamic values go through `t()` placeholders or core
`Link`/`Markup` on module-generated SVG. `Service/SparklineRenderer` produces the inline SVG.
Library `content_telemetry/entity-performance` (CSS only, `css/entity-performance.css`) is attached
for styling.
