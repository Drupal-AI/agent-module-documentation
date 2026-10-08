Renders the data collected by Content Reporting as column, bar and pie charts on a dedicated charts dashboard, using the contrib Charts module.

---

Content Reporting Charts is a small submodule of Content Reporting. It adds one controller, one theme hook and one Twig template that turn the rows in `content_reporting_reports` and `content_reporting_interactions` into three visualisations on a charts dashboard at `/content-reporting/charts-dashboard`: a column chart of views per page, a bar chart of average time-spent for anonymous versus authenticated visitors, and a pie chart of average time-spent per page. All rendering is delegated to the contrib Charts module through its render elements, so the submodule ships no chart library itself — the graphs are drawn by whatever library (Chart.js, Highcharts, ApexCharts, etc.) the Charts module is configured to use. It requires the `content_reporting` parent module and `charts:charts`.

---

- Add graphical dashboards on top of Content Reporting's tabular data.
- Enable it with `drush en content_reporting_charts` after installing the Charts module.
- View a column chart of total views per page, sorted by page title.
- View a bar chart comparing average time-spent between anonymous and authenticated visitors.
- View a pie chart of average time-spent per page across all tracked nodes.
- Reach the charts dashboard from a "Charts Dashboard" local tab next to the main reporting dashboard.
- Reuse whichever chart library the Charts module is already configured with, keeping one rendering backend site-wide.
- Present engagement trends to non-technical stakeholders in a visual form rather than a data table.
- Complement the CSV export with an at-a-glance visual overview.
- Spot the most- and least-viewed content quickly from the column chart.
- Compare how long different visitor types stay on the site.
- Identify pages that hold attention longest from the per-page time pie chart.
- Keep all analytics visualisation first-party and inside the Drupal site.
- Theme or extend the dashboard via the `content_reporting_charts_dashboard` theme hook and its Twig template.
- Drive the charts from live data that Content Reporting's queue workers write on cron.
