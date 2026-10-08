<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Charts dashboard, data queries & routes

## Install
`drush en content_reporting_charts -y`. Requires the parent `content_reporting` module and the
contrib `charts` module (`charts:charts`). The charts library actually used (Chart.js, Highcharts,
ApexCharts, Google Charts, etc.) is whatever is selected in the Charts module's settings — this
submodule only emits Charts render elements, it bundles nothing.

## Route
`content_reporting_charts.dashboard` → `/content-reporting/charts-dashboard`, controller
`Drupal\content_reporting_charts\Controller\ContentReportingChartsController::dashboard`,
requirement `_permission: 'access content'`, `options: _admin_route: TRUE`. A "Charts Dashboard"
local task (`content_reporting_charts.links.task.yml`) sits under the parent
`content_reporting.dashboard` base route.

## dashboard()
Returns a render array `{'#theme' => 'content_reporting_charts_dashboard', '#charts' => [...],
'#attached' => {library: content_reporting/content_reporting.styles}}`. The theme hook
`content_reporting_charts_dashboard` (variable `charts`) and template
`templates/content-reporting-charts-dashboard.html.twig` loop the charts and print each with
`{{ chart }}`.

Three charts are built from protected data methods (all plain `database->select()` query-builder
calls, no string-concatenated SQL):

| Chart | `#chart_type` | Source method | Data |
|-------|---------------|---------------|------|
| Views per Page | `column` | `getPageViewsData()` | `content_reporting_reports` (title, views, gdpr_consent), ordered by title. |
| Average Time Spent (user type) | `bar` | `getUserViewsData()` | `content_reporting_interactions` (uid, duration); groups Anonymous vs Authenticated by testing each uid against `users_field_data`, then averages duration. |
| Average Time Spent per Page | `pie` | `getAverageTimeSpentPerPage()` | `content_reporting_interactions` (nid, duration); averages per nid; `getNodeTitle($nid)` (`Node::load`) supplies the slice label, "No Title" when the node is gone. |

Each chart is assembled from Charts render elements: `#type => chart` with nested
`#type => chart_data` (series), `#type => chart_xaxis` (labels) and `#type => chart_yaxis` (title).
Series data is mapped with `array_map`/`array_values`; chart titles and axis titles go through
`$this->t()`.

## Notes
- The controller reads only aggregate columns (titles, view counts, durations, uid) — it does not
  read the interaction `element` string.
- Node titles are re-resolved live via `Node::load()` for the pie chart rather than from the stored
  `title` column.
