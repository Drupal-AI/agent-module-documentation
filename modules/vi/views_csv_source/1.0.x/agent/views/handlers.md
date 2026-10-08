# CSV Views handlers (field / filter / sort / argument / relationship)

All handlers hang off the `csv` base table declared in `hook_views_data`
(`ViewsCsvSourceViewsHooks::viewsData`). Each one names a CSV **column** through the shared
`ColumnSelectorTrait`, whose `key` option is the column name. The trait renders a **Column
Selector** dropdown populated from the CSV header row (`ViewsCsvQuery::getCsvHeader()`); when
headers cannot be read (e.g. a tokenised path), it degrades to a free-text field so you can type
the column name.

## Handler map (views_data)

| views_data key | Title | Handler id | Class |
|---|---|---|---|
| `csv.value` (field) | CSV Field | `views_csv_source_field` | `field/ViewsCsvField` |
| `csv.value` (sort) | CSV Field | `views_csv_source_sort` | `sort/ViewsCsvSort` |
| `csv.value` (filter) | CSV Field | `views_csv_source_filter` | `filter/ViewsCsvFilter` |
| `csv.value` (argument) | CSV Field | `views_csv_source_argument` | `argument/ViewsCsvArgument` |
| `csv.value_select` (filter) | CSV Field Options | `views_csv_source_filter_select` | `filter/ViewsCsvFilterSelect` |
| `csv.value_numeric` (filter) | CSV Field Numeric | `views_csv_source_filter_numeric` | `filter/ViewsCsvFilterNumeric` |
| `csv.value_date` (filter) | CSV Field Date | `views_csv_source_filter_datetime` | `filter/ViewsCsvFilterDatetime` |
| `csv.value_combine` (filter) | CSV Combine Field | `views_csv_source_filter_combine` | `filter/ViewsCsvFilterCombine` |
| `csv.constant` (field) | Constant Value | `csv_constant` | `field/Constant` |
| `csv.csv_relationship` (relationship) | CSV File Relationship | `views_csv_relationship` | `relationship/CsvRelationship` |

## Fields

- **CSV Field** (`views_csv_source_field`, `FieldPluginBase`): displays one column (`key`).
  Supports click-sort. Extra option `trusted_html` (bool, default FALSE, schema
  `views.field.views_csv_source_field`) — when on, the cell is rendered via `Markup::create()`
  (raw HTML, no sanitisation); its own form describes it as for trusted sources only. When off,
  Views renders/sanitises normally. Field alias is built by `getColumnAlias()`.
- **Constant Value** (`csv_constant`): returns a fixed `constant_value` (default `all_results`)
  for every row — handy as a group-by key so aggregate functions run over the whole result set.

## Filters

- **CSV Field** (`views_csv_source_filter`, extends `FilterPluginBase`): text filter. Operators
  `=`, `!=`, `contains`, `starts`, `not_starts`, `ends`, `not_ends`, `not` (does not contain),
  `shorterthan`, `longerthan`, `regular_expression`, and `empty`/`not empty` when the definition
  allows. Exposable, with an extra `placeholder` expose option. Each operator maps to an
  `addWhere()` call; matching is done in PHP by `Select::verifyCondition()`.
- **CSV Field Options** (`views_csv_source_filter_select`, extends core `InOperator`): a select/
  checkboxes filter whose values are the **unique values of the chosen column** (sorted), fetched
  via `getCsvColumnValues()` / `getCsvColumnValuesFromUri()`. Settings: `empty_cell_behavior`
  (`none`/`remove`/`add_label`) and `multi_value_cell_separator` (split a cell into several options).
  A "Refresh value options" button and AJAX rebuild the value list when the column/relationship
  changes. Adds `contains all` / `contains any` / `contains none` operators.
- **CSV Field Numeric** (`views_csv_source_filter_numeric`, extends core `NumericFilter`):
  numeric comparisons (core operators minus `not_regular_expression`).
- **CSV Field Date** (`views_csv_source_filter_datetime`, extends core `Date`): date filter that
  also accepts a bare 4-digit **year**. `Select::processDate()` expands a year to a range edge by
  operator — `>`/`<=` → year-end `12-31 23:59:59`, `>=`/`<` → year-start `01-01 00:00:00`, `=` →
  `between` the two. Also supports relative offsets. Values are passed to the query as timestamps.
- **CSV Combine Field** (`views_csv_source_filter_combine`, extends `ViewsCsvFilter`): the `key`
  option is an **array of columns**; their values are concatenated (space-separated) and searched
  as one. Encoded to the query as a `COMBINE_CSV::col1::col2` pseudo-column.

## Sort

- **CSV Field** (`views_csv_source_sort`, `SortPluginBase`): orders by the chosen column.
  `Select::applyOrderBy()` sorts with `strnatcasecmp` (natural, case-insensitive), ascending or
  descending.

## Argument (contextual filter)

- **CSV Field** (`views_csv_source_argument`, extends core `StringArgument`): filters rows by a
  column value taken from the URL/argument. With `break_phrase` on, multiple values are accepted:
  `1+2+3` or `1,2,3` (IN) and `(1,2,3)` (contains all) — see `breakString()`. The same argument
  value is also what you interpolate into the `csv_file` path (see query.md) to select a file.

## Relationship

- **CSV Relationship** (`views_csv_relationship`, `RelationshipPluginBase`): joins a **second**
  CSV to the base one. Options: `csv_file` (its own URI, same forms as the base source),
  `left_column`(s) on the base file, `right_column`(s) on the joined file (comma-separated for a
  composite key; counts must match — enforced in `validateOptionsForm`), and `unique_match`
  (one-to-one; keep only the first match). Registered via `ViewsCsvQuery::addCsvRelationship()`
  and executed as an in-memory hash join (`Select::performHashJoin()`; inner join when Views marks
  the relationship required, otherwise left join). Fields/filters selected against the relationship
  use its columns, prefixed with the relationship alias.
