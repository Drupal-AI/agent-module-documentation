<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Operators

All operators live in the filter plugin
`Drupal\views_daterange_filters\Plugin\views\filter\ViewsDaterangeFiltersDateRange`
(`@ViewsFilter("views_daterange_filters_daterange")`), which extends core's
`Drupal\datetime\Plugin\views\filter\Date`. `operators()` returns the parent's operators
plus the six below. The plugin operates on the field's start column (`..._value`) and
derives the end column by `substr($field, 0, -6) . '_end_value'` (strip trailing `_value`,
append `_end_value`).

| Operator id | Title | Values | Method | WHERE (start = field, end = `_end_value`) |
|---|---|---|---|---|
| `includes` | Includes | 1 | `opIncludes` | `:value BETWEEN start AND end` |
| `includes_unbound` | Includes (Unbound) | 1 | `opIncludesUnbound` | `(start IS NULL OR :value >= start) AND (end IS NULL OR :value <= end)` |
| `includes_unbound_indexed` | Includes (Unbound Indexed) | 1 | `opIncludesUnboundIndexed` | `(start IS NULL OR start <= :v) AND (end IS NULL OR end >= :v)` — `:v` is a bound UTC string param |
| `overlaps` | Overlaps | 2 (min/max) | `opOverlaps` | `(min <= end AND max >= start) OR (min <= start AND max >= start)` |
| `ends_by` | Ends by | 1 | `opEndsBy` | `end <= :value` |
| `not_ended` | Not ended | 1 | `opNotEnded` | `end >= :value OR end IS NULL` |

Notes:
- **Value counts** matter for the exposed form: `overlaps` needs a `min` and a `max`
  (`values => 2`); every other added operator takes a single value (`values => 1`). An
  empty `min` on `overlaps` defaults to UNIX epoch `@0`.
- **Unbound vs plain:** `includes` uses `BETWEEN`, so rows with a NULL start or NULL end are
  excluded. The two "unbound" variants treat a NULL start or end as open-ended and still
  match — useful with the `optional_end_date` module. `includes_unbound_indexed` is the
  index-friendly form: it binds the value as a parameter (`:v`) and compares the raw stored
  columns directly instead of wrapping them in date-format SQL, so a DB index on the date
  columns can be used.
- **`not_ended`** returns ranges still open at the reference date, including open-ended
  (NULL end) ranges — the inverse-ish of `ends_by`.
- **Timezone handling** is inherited from core's Date filter: single values go through
  `formatValue()`/`getDateField()` (active timezone → UTC storage → Views date expression);
  the indexed operator uses `toUtcString()` = `gmdate($this->dateFormat, ...)` for the bound
  param. `getEndFieldName()` centralises the `_value` → `_end_value` mapping.
