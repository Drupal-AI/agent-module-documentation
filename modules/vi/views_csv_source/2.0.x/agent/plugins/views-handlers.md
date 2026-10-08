<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views handlers the module adds

The module does **not** define a new plugin type; it registers handlers against core Views plugin
types. `hook_views_data()` (`src/Hook/ViewsCsvSourceViewsHooks.php`) exposes a single base table
`csv` (query id `views_csv_source_query`) with these handlers. You attach them by adding fields,
filters, sorts, arguments and relationships to a CSV-backed view — no code needed for normal use.

| Views data field | Handler id | Type | Purpose |
|---|---|---|---|
| `csv.value` | `views_csv_source_field` | field | "CSV Field" — output one CSV column; pick the column via the "Column Selector". |
| `csv.value` | `views_csv_source_sort` | sort | Sort a column as a string. |
| `csv.value` | `views_csv_source_filter` | filter | Plain text filter on a column. |
| `csv.value` | `views_csv_source_argument` | argument | Contextual filter on a column. |
| `csv.value_select` | `views_csv_source_filter_select` | filter | "CSV Field Options" — dropdown of the column's unique values (optional multi-value separator, "Refresh value options"). |
| `csv.value_numeric` | `views_csv_source_filter_numeric` | filter | Numeric comparisons. |
| `csv.value_date` | `views_csv_source_filter_datetime` | filter | Date filter; can filter on a year alone (e.g. `2025` + "greater than" ⇒ `2025-12-31`). |
| `csv.value_date` | `views_csv_source_sort_date` | sort | Sort chronologically (optional PHP date `format`). |
| `csv.value_combine` | `views_csv_source_filter_combine` | filter | Search across multiple CSV columns at once. |
| `csv.constant` | `csv_constant` | field | "Constant Value" — same value on every row; useful for aggregation. |
| `csv.csv_relationship` | `views_csv_relationship` | relationship | Join a second CSV file (see below). |

All filters can be exposed. Every displayed column uses the same `views_csv_source_field` plugin;
choose the actual column in that field's "Column Selector".

## Aggregation
Enable "Use aggregation" on the view. `ViewsCsvQuery::getAggregationInfo()` supports **group**,
**count**, **sum**, **avg**, **min**, **max**. Non-aggregated fields are added to the group-by
automatically. Pair with a `csv_constant` field to aggregate over all rows.

## CSV-to-CSV relationships (joins)
Add a "CSV Relationship". Settings: **Relationship CSV File** (a second CSV URI, tokens allowed),
**Base left column**, and **Relationship Right Column**. The query joins rows where the base
column value equals the related column value, then the related file's columns become selectable in
fields/filters. Example (from README): base `my_file.csv` has `country`, related `my_file_regions.csv`
maps `country → region`; join on `country`/`country`, then filter/display `region`.

## Implementing custom behavior
Two extension points rather than a plugin manager:
- Subscribe to `views_csv_source.pre_cache` to rewrite remote CSV content before caching (see the
  configure doc).
- Write your own core Views handler and register it in `hook_views_data()` against the `csv` base
  table if you need a filter/sort the module does not ship.
