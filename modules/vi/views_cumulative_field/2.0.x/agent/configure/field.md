<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the cumulative Views fields

No admin page. You add and configure the fields **inside a View** (Views UI → *Add* field). Two handlers
are provided in the **Global** group:

| Views field (UI label) | Handler id | Class | Output |
|---|---|---|---|
| Global: Cumulative Field | `field_cumulative_field` | `CumulativeField` | Running sum: each row shows the accumulated total up to and including that row. |
| Global: Cumulative Total Field | `field_cumulative_total` | `CumulativeTotalField` | The grand (or group) total, repeated identically on every row. |

Both extend core `NumericField`, so the normal number-format options (decimals, separators,
prefix/suffix, rounding via `float`) are also available.

## Setup steps

1. Add a field that outputs numbers — this is the **data field**.
2. Add *Global: Cumulative Field* (or *…Total Field*).
3. In its settings, pick the data field and totalling behavior below.

## Settings (schema `views.field.field_cumulative_field` / `field_cumulative_total_field`)

| Setting | Values | Default | Meaning |
|---|---|---|---|
| `data_field` | id of another field in the display (radios; self is excluded) | `NULL` | The numeric field to accumulate. |
| `total_type` | `grand` \| `group` | `grand` | `grand` = one bucket for the whole result set; `group` = reset the total per *Format → Grouping* value(s). |
| `summation_method` | `php` \| `database` | `php` | How the sum is computed (see below). |

## PHP vs database summation

- **`php`** — `calculatePhpTotals()` iterates `$view->result` once, computing a per-group-signature
  running total and caching it by row index. Row values come from the entity field, a rewritten
  (`alter_text`) value, the aggregated handler value, or special-cased Commerce price fields
  (`commerce_price_default` / `commerce_product_variation` → `price.number`). Group signatures are built
  from the View's grouping fields (rendered, stripped of tags/entities/whitespace).
- **`database`** — `addDatabaseCumulativeField()` injects a SQL window function into the query:
  `SUM(<table_alias>.<field>) OVER (PARTITION BY <grouping fields> ORDER BY <view sorts>)`. The
  ORDER BY mirrors the View's sort handlers, falling back to base-entity id DESC. The field/table
  identifiers come from the View's own resolved handler aliases, not from request input.

**Important fallback:** if Views aggregation (GROUP BY) is enabled, database mode is ignored and PHP is
used instead — a window-function alias would be pushed into GROUP BY and raise SQL error 4015.

## Charts tip

The module's stated purpose is feeding cumulative series into the Charts module: add your value field,
add *Cumulative Field* pointing at it, and plot the cumulative field for a running-total line.
