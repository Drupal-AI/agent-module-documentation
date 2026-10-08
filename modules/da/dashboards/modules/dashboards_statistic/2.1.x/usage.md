<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dashboards statistics adds a Dashboards widget that charts the most-visited content per type using core's Statistics node view counters.

---

This submodule of Dashboards provides a single Dashboard plugin, `node_most_readed` ("Show most visited.", category "Statistics"), exposed as the block `dashboards_block:dashboard:node_most_readed`. It renders a chart (via the shared `ChartTrait`) of rows `[node type, view count]`, queried from core's `node_counter` table joined to `node_field_data` and grouped by node type. A `count` setting selects which counter column is summed: `totalcount` (all-time views) or `daycount` (today's views). Results are cached in the module's `dashboards` cache bin (tagged `node_list`). It requires core's `statistics` module (which must be recording content hits) and `dashboards`. Place it into a dashboard's Layout Builder to visualize which content types get the most traffic.

---

- Chart the most-visited content by content type on an admin dashboard.
- See which bundles (Article, Page, …) attract the most page views.
- Show all-time view totals per node type (`count: totalcount`).
- Show today's view counts per node type (`count: daycount`).
- Add the widget as a block via Layout Builder (`dashboards_block:dashboard:node_most_readed`).
- Pair it with the comment-statistics widget for an engagement overview.
- Identify high-traffic content types to prioritize editorially.
- Spot content types with low readership that may need promotion.
- Give editors a visual of traffic distribution without querying `node_counter` by hand.
- Track readership shifts after a homepage or navigation change.
- Build a "content performance" dashboard for stakeholders.
- Group the widget under the "Statistics" category in the block picker.
- Cache expensive view-count aggregations automatically.
- Reuse the widget on multiple dashboards with different count settings.
- Visualize using the dashboard's configured colormap/theme.
- Combine with node statistics and webform widgets for a full reporting dashboard.
- Monitor daily traffic momentum per content type.
- Confirm core Statistics counting is working by watching the chart populate.
- Present traffic metrics to non-technical stakeholders as a chart.
