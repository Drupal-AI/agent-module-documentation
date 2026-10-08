<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
yasm_charts is an optional YASM submodule that renders the statistics tables on the contents, users, files and groups dashboards as charts using the Charts module.

---

yasm_charts extends four of YASM's dashboard controllers (Contents, Users, Files, Groups) so that, after the normal statistics tables are built, the same tabular data is turned into charts (pie, bar/column, line, …) via the contrib Charts module and whatever chart library is configured there (Chart.js, Google Charts, Highcharts, etc.). It adds no new routes or permissions: a route subscriber simply swaps those YASM controllers for chart-aware subclasses, keeping the original permissions and access checks intact. The `YasmChartsBuilder` service walks each render build for tables flagged as chartable and produces Charts render arrays from their rows. It requires the parent `yasm` module and `drupal/charts`, and you must pick a chart library in the Charts settings for anything to draw.

---

- Add pie charts of nodes by content type.
- Show published vs. unpublished nodes as a chart.
- Chart nodes by language on multilingual sites.
- Plot nodes created and updated per month as line charts.
- Show top content creators as a ranking bar chart.
- Visualise users by role.
- Visualise users by status (active vs. blocked).
- Chart users by email domain.
- Chart files by type or MIME.
- Show disk-usage breakdowns visually.
- Chart group contents and members.
- Keep the existing sortable data tables alongside the charts.
- Reuse the site's configured Charts library across all YASM dashboards.
- Switch chart engines (Chart.js, Google, Highcharts) via Charts settings without touching YASM.
- Present statistics to stakeholders in a visual format.
- Turn a report table into a chart without exporting data.
- Preserve YASM's per-page permissions while adding visuals.
- Enable charts only on the dashboards where you want them.
- Complement the DataTables CSV/Excel/PDF export with on-screen charts.
- Give admins a quick visual read of site composition.
