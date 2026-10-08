<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dashboards webform adds a Dashboards widget that charts webform submission counts over time, optionally scoped to a single webform.

---

This submodule of Dashboards provides a single Dashboard plugin, `webform_submissions` ("Submission statistic.", category "Webform"), exposed as the block `dashboards_block:dashboard:webform_submissions`. It renders a time-series chart (via the shared `ChartTrait`) of submission counts grouped by date, queried from the `webform_submission` table. Its settings form offers: `webform` (an optional entity-autocomplete to limit to one webform), `period` (`hour`, `day`, `week`, or `month` buckets), `date` (the time range: today, yesterday, this week, this month, last 3/6 months, this year), and `chart_type` (bar, line, etc.). Rows are one series per webform id across the chosen buckets, cached in the module's `dashboards` cache bin. It requires `dashboards` and `webform`. Place it into a dashboard's Layout Builder to monitor form activity.

---

- Chart webform submissions over time on an admin dashboard.
- Track submissions for a specific webform by setting the `webform` option.
- Bucket submissions by hour, day, week, or month with the `period` setting.
- Scope the chart to today, yesterday, this week/month, last 3/6 months, or this year via the `date` setting.
- Choose a bar or line chart with the `chart_type` setting.
- Add the widget as a block via Layout Builder (`dashboards_block:dashboard:webform_submissions`).
- Monitor a contact form's daily submission volume.
- Compare submission trends across multiple webforms (one series each).
- Spot spikes or drops in form activity after a campaign.
- Build a lead-generation dashboard showing form conversions over time.
- Watch weekly submission momentum for a survey.
- Present submission metrics to stakeholders as a chart.
- Detect a broken or spammed form by unusual submission patterns.
- Combine with node/comment statistics widgets for a full activity dashboard.
- Group the widget under the "Webform" category in the block picker.
- Cache expensive submission aggregations automatically.
- Reuse the widget on multiple dashboards with different period/date/webform settings.
- Visualize using the dashboard's configured colormap/theme.
- Report monthly submission totals for the current year.
