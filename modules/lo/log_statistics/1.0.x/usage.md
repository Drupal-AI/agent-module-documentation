<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Aggregates database log (watchdog) entries by day and severity and shows the trend as a chart.
---
The core `dblog` report lists individual log entries but gives no trend over time. This module maintains its own `log_statistics` table with per-day counts for each RFC severity (emergency, alert, critical, error, warning, notice, info, debug). `\Drupal\log_statistics\LogInsert` (service `log_statistics.insert`, injected with state, time, database, and logger factory) tallies entries, and `\Drupal\log_statistics\LogData` (`log_statistics.data`) reads back the latest rows (paged, 10 per page, newest first).

The page at `/log-statistics` (`LogGraphController::buildGraph`) attaches the aggregated data to `drupalSettings` and renders it with the shipped `line_chart.js` (Google line chart). The route is gated by the core `administer content` permission. A Drush command class (`log_statistics.commands`, `LogStatisticsCommands`) is provided to populate/backfill statistics. Setup is: enable the module (requires `dblog`), let cron/inserts accumulate counts, then view the graph. Queries use the database query builder with an explicit field list and a pager — no raw string concatenation of user input.
---
- View a line chart of log volume by severity over time.
- Track error/warning trends across days.
- Spot spikes in critical or emergency log entries.
- Backfill historical statistics with the Drush command.
- Monitor site health from an aggregate dashboard.
- Page through recent daily statistics (10 per page).
- Break down log counts by RFC severity level.
- Correlate deployment dates with error spikes.
- Provide ops/editors a lightweight logging overview.
- Keep aggregate counts without retaining full log text.
- Feed the chart data via `drupalSettings` to `line_chart.js`.
- Restrict the report to users with `administer content`.
- Complement core dblog with a time-series view.
- Report notice/info/debug volume for noisy modules.
- Use the `log_statistics.data` service in custom code.
- Insert counts programmatically via `log_statistics.insert`.
- Automate stat collection on cron.
- Audit warning growth after a config change.