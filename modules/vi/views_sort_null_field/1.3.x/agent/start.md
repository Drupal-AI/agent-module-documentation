<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Sort Null Field — agent index

Adds a Views sort handler that orders rows by whether a field is empty (NULL), so you can send
empty values to the bottom (ASC) or top (DESC) of a listing. No config, no UI, no permissions,
no schema — purely a Views-time query addition. `configure: null`.

- **The `null_sort` plugin, how the "null sort" handler is exposed in Views data, ASC/DESC meaning,
  the generated SQL, and the two-sort recipe** → [plugins/null-sort.md](plugins/null-sort.md)

Key facts:
- Views sort plugin id: **`null_sort`** (`@ViewsSort("null_sort")`, class `NullSort` extends `SortPluginBase`).
- `hook_field_views_data_alter()` adds a `<column>_null_sort` sort to each **nullable** field column,
  e.g. `field_foo_value_null_sort` on table `node__field_foo`.
- **ASC = NULLs last, DESC = NULLs first** (order by `<table>.<column> IS NULL`).
- Recipe: add the null sort first, then the ordinary field sort, to order within each bucket.
