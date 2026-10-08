<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views filter handlers

Two filter plugins, registered by `created_date_views_filters_views_data()` on the `views`
pseudo-table with `field => 'created'`. Add them from the Views UI under **Add filter criteria**
(look for "Year filter - Filter" and "Month filter - Filter"). Both may be exposed.

## year_filter — `YearFilter`

- Annotation: `@ViewsFilter("year_filter")`, extends `FilterPluginBase`.
- `adminSummary()`: "Filters by year of created date."
- `valueForm()`: a `select` titled **Year** whose options are `date('Y') - 5` through the current
  year (six entries); `#default_value` is the current year.
- `query()`:
  ```php
  $this->ensureMyTable();
  $query = $this->query;                       // \Drupal\views\Plugin\views\query\Sql
  $table = array_key_first($query->tables);    // the View's FIRST table
  // scalar value:
  $query->addWhereExpression(0, "EXTRACT(YEAR FROM FROM_UNIXTIME($table.created)) = :year", [':year' => $this->value]);
  // (array value uses $this->value[0])
  ```
  Empty values add no condition.

## month_filter — `MonthFilter`

- Annotation: `@ViewsFilter("month_filter")`, extends `FilterPluginBase`.
- `adminSummary()`: "Filters by month of created date."
- `valueForm()`: a `select` titled **Month** with options keyed by lowercase month names
  (`january` … `december`).
- `query()`: converts the chosen name to a two-digit month with `date('m', strtotime($this->value))`,
  then:
  ```php
  $query->addWhereExpression(0, "EXTRACT(MONTH FROM FROM_UNIXTIME($table.created)) = :month", [':month' => $month_num]);
  ```
  Matches that month across **all** years. Empty values add no condition.

## Behaviour notes

- Both handle the value as either a scalar or `$this->value[0]` (exposed multi-value form shapes),
  guarding each with `!empty(...)`.
- Conditions are added at group `0` and combine with the rest of the View's WHERE as AND, so using
  both filters scopes to one month of one specific year.
- Values are bound with **named placeholders** (`:year`, `:month`) — parameterized, not
  concatenated.
- Portability: `EXTRACT(... FROM FROM_UNIXTIME(...))` is MySQL/MariaDB-only.
- Correctness caveat: `$table` is the View's first table, not necessarily the table owning
  `created`; verify the generated SQL on non-node base tables or relationship-heavy Views.
