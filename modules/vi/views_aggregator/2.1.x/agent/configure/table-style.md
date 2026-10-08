# Configure a view to aggregate

There is **no admin settings page and no permissions**. All configuration is done per view
in the Format style options.

## Enable

1. Edit a view: `admin/structure/views/view/YOUR_VIEW`.
2. Under **Format**, set the style to **"Table with aggregation options"**
   (plugin id `views_aggregator_plugin_style_table`).
3. In the **Advanced** section set **Use aggregation: No** — VAgg+ does *not* combine with
   Views' native SQL aggregation.
4. Open the style **Settings** to configure per-field and table options (below).

## Rules

- Every group aggregation function **except "Filter rows"** requires **exactly one** field
  assigned the **"Group and compress"** function.
- Column aggregation functions may be used independently of group functions.
- Functions marked `*` take an optional parameter (regexp, precision, or separator).
- Aggregation runs on **rendered** values. If a result looks wrong, switch the field
  formatter to "Plain text". Applying two functions to the same field chains them.

## Per-field options (`info.<field>`)

| Key | Meaning |
|---|---|
| `has_aggr` (bool) | Apply a **group** function to this field. |
| `aggr` (array) | Selected group function id(s), e.g. `['views_aggregator_sum']`. Default `['views_aggregator_first']`. |
| `aggr_par` (string) | Optional parameter for the group function. |
| `has_aggr_column` (bool) | Apply a **column** (totals-row) function to this field. |
| `aggr_column` (string) | Column function id, single-select. Default `views_aggregator_sum`. |
| `aggr_par_column` (string) | Optional parameter for the column function. |

## Group aggregation options (`group_aggregation`)

| Key | Meaning |
|---|---|
| `group_aggregation_results` (0/1) | `0` = one aggregated row per group (collapse). `1` = no collapse, show per-group subtotal rows. |
| `grouping_field_class` | CSS class on cells of the grouped/compressed column. |
| `grouping_row_class` | CSS class on each subtotal row (subtotals mode). |
| `result_label_prefix` / `result_label_suffix` | Text wrapped around the subtotal label (e.g. `" - Sum"`). |

## Column aggregation options (`column_aggregation`)

| Key | Meaning |
|---|---|
| `totals_row_position` (checkboxes 1/2/3) | Show totals in `1` header, `2` footer, `3` caption. |
| `totals_per_page` (0/1) | `0` = totals over the **entire** result set (can be slow on large tables, re-runs the query without pager); `1` = totals over the visible page / offset subset only. |
| `precision` (int) | Default decimals for numeric column aggregations not otherwise specified. |
| `totals_row_class` | CSS class on the totals row. |

Config schema type: `views.style.views_aggregator_plugin_style_table` (extends
`views.style.table`), defined in `config/schema/views_aggregator.schema.yml`.
