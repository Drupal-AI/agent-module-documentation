# Views Cumulative Field — manual setup guide

**Views Cumulative Field** (`views_cumulative_field`) adds two "Global" Views
field handlers that compute a **running cumulative total** of another numeric
field in the same View. If you have a list of orders, donations, votes, or
inventory movements, you can add a column that shows the sum accumulated down the
rows — the classic "running total" — which is especially handy for feeding a
"growth over time" line into the Charts module or building financial‑style
reports.

There are two handlers. **Cumulative Field** prints the running sum: each row
shows the total up to and including that row. **Cumulative Total Field** instead
prints the grand (or per‑group) total, repeated identically on every row. Both
build on core's numeric field, so all the usual number‑formatting options —
decimals, thousands separators, prefixes and suffixes — apply.

The module has **no settings page, no permissions, and no Drush commands**.
Everything is configured inside the Views UI when you add the field to a View, so
using it is gated by the core *Administer views* permission like any other Views
work.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated admin page. The two handlers appear inside the Views UI
(**Structure → Views**, then editing a View) when you add a field — look under the
**Global** group for *Cumulative Field* and *Cumulative Total Field*.

## How to use it

1. Edit a View under **Structure → Views** and make sure it already has a field
   that outputs numbers — this is your **data field** (say, an order total or a
   donation amount).
2. Click **Add** in the Fields section and add **Global: Cumulative Field** (for a
   running sum) or **Global: Cumulative Total Field** (for a repeated grand/group
   total).
3. In the field's settings, choose:
   - **Data Field** — pick the numeric field in the View you want to accumulate
     (the handler lists the other fields you've added).
   - **Total Type** — **Grand** keeps one running total for the whole result set;
     **Group** resets the total for each *Format → Grouping* value (for example,
     restart the sum for each month or category).
   - **Summation Method** — **PHP** accumulates the values in code while the View
     renders; **Database** injects a SQL window function
     (`SUM(...) OVER (PARTITION BY ... ORDER BY ...)`) which is more efficient on
     large result sets. If your View uses Views aggregation (GROUP BY), the
     database method automatically falls back to PHP, because a window‑function
     alias can't coexist with GROUP BY.
4. Because the handlers extend core's numeric field, set decimals, separators, and
   any prefix/suffix under the same settings as you would for any number field.
5. Save the View.

**Charts tip:** the module's main purpose is feeding cumulative series into the
Charts module — add your value field, add *Cumulative Field* pointing at it, then
plot the cumulative field to get a running‑total line. See the sibling
[`agent/configure/field.md`](../agent/configure/field.md) for the full details of
each setting.
