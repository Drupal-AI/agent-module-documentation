<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Date Format SQL formats timestamp date fields in the SQL query (via the database's `DATE_FORMAT`) instead of in PHP at render time, so the formatted date can be used as a GROUP BY key for aggregation.

---

Core Views formats dates in `render()` (PHP `format_date`), which means two rows with the same month but different days are distinct values and cannot be aggregated together. This module moves the formatting into `query()` using the database's date-format SQL, so e.g. a `Y-m` format collapses every timestamp in a month to the same string and Views aggregation can group and count by it. It works by swapping the default handler on timestamp fields: `hook_views_data_alter()` replaces the `id` of any Field-API `timestamp` field/argument with `views_date_format_sql_field` / `views_date_format_sql_argument` (file tables are skipped). The field handler extends core's `EntityField`; when its per-handler "Use SQL to format date" checkbox is on, `query()` builds the formula with `$query->getDateFormat($field, $formatString, FALSE)` (respecting the field's chosen date format / custom pattern and a timezone offset) and adds it as an aggregated, grouped column. The argument handler extends core's `NumericArgument`, adds a free-text "Date Format" string plus the same checkbox, and filters rows with `DATE_FORMAT(...) = :placeholder` (the contextual argument value is a bound placeholder). A config schema stores the `format_date_sql` boolean (and, for the argument, the `format_string`). There are no permissions, no Drush, and no global settings — everything is per-handler inside a View.

---

- Group a View of nodes by month using a `Y-m` date format so counts aggregate per month.
- Build a monthly or yearly report (count of content created per period) with Views aggregation.
- Aggregate log/timestamp rows by day for a daily-totals table.
- Produce a "posts per year" summary by formatting `created` as `Y` and grouping.
- Chart-ready data: emit one aggregated row per time bucket instead of per record.
- Format a `changed` timestamp field to `Y-m-d` in SQL so it can be a GROUP BY column.
- Use the SQL-formatted date as a Views argument (contextual filter) to page by month/year.
- Filter a View to a specific month via a contextual filter formatted as `Y-m`.
- Keep date formatting consistent with the field's configured core date format, done in SQL.
- Apply a timezone offset to the SQL date formatting for correct local-time bucketing.
- Avoid loading and PHP-formatting every entity just to group by a coarse date granularity.
- Turn a stream of events into a calendar-style monthly rollup.
- Report unique visitors/orders/etc. per week or month directly from a timestamp field.
- Sort a grouped View by the SQL-formatted date column (click-sort supported).
- Provide "activity by day of week" style reports by choosing an appropriate format token.
- Reduce result-set size by aggregating at query time rather than post-processing in PHP.
- Add month/year buckets to an exposed-filter-driven report without custom SQL.
- Replace a hand-written custom Views handler that did SQL date grouping.
- Support MySQL, PostgreSQL and SQLite (formatting delegates to core's per-driver DateSql).
