<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Cumulative Field adds two "Global" Views field handlers that compute a per-row **running cumulative total** (and a repeated grand/group total) of another numeric field in the same view — ideal for charts and financial-style running sums.

---

The module registers two handlers via `hook_views_data` under the `Global` group: **Cumulative Field**
(`field_cumulative_field`, class `CumulativeField`) which prints the running sum accumulated down the
rows, and **Cumulative Total Field** (`field_cumulative_total`, class `CumulativeTotalField`) which
repeats the final grand/group total on every row. Both extend core `NumericField`, so all the standard
number-format options apply. In each handler's settings you choose a **Data Field** (any other numeric
field already added to the view — chosen from radios), a **Total Type** (`grand` = one running total for
the whole result set, or `group` = reset per *Format → Grouping* value), and a **Summation Method**:
`php` iterates `$view->result` in PHP and accumulates per group signature, while `database` injects a
SQL window function (`SUM(<field>) OVER (PARTITION BY … ORDER BY …)`) into the query. The database
method auto-falls back to PHP when Views aggregation (GROUP BY) is on, because the window-function alias
would otherwise be forced into the GROUP BY clause. PHP mode pulls each row's number from the entity
field, a rewritten value, aggregated handler value, or (special-cased) Commerce price fields. There is
no config UI, permissions, or Drush — you only add and configure the field inside a View, so its use is
gated by `administer views`.

---

- Show a running total column in a table View (e.g. cumulative sales down a list of orders).
- Feed a cumulative series into the Charts module for a "growth over time" line chart.
- Display a running sum of donations, points, or votes per row.
- Reset the running total per group (e.g. restart the sum for each month or category) via Total Type = group.
- Print the grand total of a numeric field on every row using the Cumulative Total Field handler.
- Compute a per-group total that repeats on each row within that group.
- Use a SQL window function for efficient cumulative sums on large result sets (Summation Method = database).
- Fall back to PHP calculation automatically when the View uses aggregation.
- Order the running total by the View's configured sorts (the window ORDER BY follows the sort handlers).
- Build a cumulative column in a View that already uses Views aggregation (GROUP BY) via PHP mode.
- Show cumulative revenue from a Commerce price field (Commerce price fields are handled specially).
- Apply standard numeric formatting (decimals, thousands separator, prefix/suffix) to the cumulative value.
- Create a "percent of running total" style display by combining with rewritten fields.
- Track cumulative inventory movements across rows in a report.
- Produce a burn-down / burn-up style data column for project dashboards.
- Add a cumulative distance/time total to an activity log View.
- Show running headcount or membership growth per row.
- Compute cumulative quantities in an export View (CSV/Excel) for downstream analysis.
- Use a rewritten (altered) field as the data source when the numeric value comes from rewrite text.
- Reset cumulative subtotals per taxonomy term or per author using group totals.
