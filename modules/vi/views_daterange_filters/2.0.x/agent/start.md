<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Date Range Filters — agent index

Adds six range operators to the Views filter for `daterange` and `date_recur` fields. No
settings form, no configure route, no permissions, no Drush, no plugin types. It works by
swapping the Views filter plugin on daterange start columns to `views_daterange_filters_daterange`.

- **The six operators, their SQL, and value counts** →
  [api/operators.md](api/operators.md)
- **How the filter attaches to a field and how to use it in a View (config shape)** →
  [configure/using-in-views.md](configure/using-in-views.md)

Key facts:
- Filter plugin id: **`views_daterange_filters_daterange`** (extends core `datetime` `Date` filter).
- Attached automatically by `views_daterange_filters_field_views_data_alter()` to every
  non-`_end_value` column of a `daterange`/`date_recur` field.
- The end column is derived from the start column by replacing the trailing `_value` with
  `_end_value` (e.g. `field_when_value` → `field_when_end_value`).
- Operators: `includes`, `includes_unbound`, `includes_unbound_indexed`, `overlaps`
  (2 values: min/max), `ends_by`, `not_ended`.
