<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Statistics adds "Statistics" tabs to the webform submissions area that report submission counts and latest-submission dates per webform, filterable by date range, with optional D3.js charts.

---

The module is entirely Views-driven: it ships one View (`webform_statistics`) with four page displays — a general table plus per-day, per-week, and per-month breakdowns — mounted as local tasks under the webform submissions collection (`/admin/structure/webform/submissions/statistics*`) and gated by the core `administer webform submission` permission. It registers no config of its own (`configure` is null, no `.permissions.yml`, no schema). Four Views field plugins are added on the `webform_submission` base table via `hook_views_data_alter`: `created_groupable` (group submissions by creation day), `webform_latest_submission_date`, `webform_submission_label` (title with optional language suffix), and `webform_submission_language`. A `webform_statistics_d3_chart` Views **style** plugin renders results as a bar/line/spline/area chart using D3 v7 (loaded from the jsDelivr CDN via the `d3` asset library). The exposed filter form is enhanced (`hook_form_views_exposed_form_alter`) with HTML5 date inputs and a "Time range" quick-select (last 24h/7d/30d/90d/180d/365d, default 90d) whose JS fills the from/to dates. A `hook_query_TAG_alter` (`created_by_day`) adds a `DATE_FORMAT(FROM_UNIXTIME(created), '%Y-%m-%d')` grouping expression. Charts were migrated off the Charts module to bundled D3 in 2.x, so no chart dependency remains.

---

- Show total submission counts per webform in an admin table.
- See the date/time of the most recent submission for each webform.
- Filter submission statistics to a custom start/end date range.
- Use the "Time range" quick-select (last 24 hours, week, month, 3/6/12 months) to set the range.
- View submissions grouped and counted by day.
- View submissions grouped and counted by week.
- View submissions grouped and counted by month.
- Render a per-day submission trend as a D3 spline/line chart.
- Render submission counts as a horizontal bar chart.
- Render an area chart of submissions over time.
- Break down submission counts by submission language.
- Display webform titles with a language suffix in reports.
- Add the "Statistics" tabs directly onto the webform submissions management screen.
- Restrict statistics access to roles holding `administer webform submission`.
- Add the `created_groupable` field to a custom View to group any webform-submission report by day.
- Reuse the `webform_latest_submission_date` field in a custom View or report.
- Build a bespoke Views display and render it with the bundled D3 chart style.
- Serve chart rendering with zero external chart-module dependency (D3 from CDN).
- Monitor form engagement trends over specific promotional or campaign windows.
- Export/clone the shipped View as a starting point for custom submission analytics.
