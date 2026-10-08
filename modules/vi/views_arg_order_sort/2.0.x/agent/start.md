<!-- SPDX-License-Identifier: GPL-2.0+ -->
# Views Arg Order Sort — agent index

Adds a Views **sort handler** ("Multi-item Argument Order", plugin
`views_arg_order_sort_default`) that orders rows to match the order of values in a multi-item
contextual filter (e.g. `5,3,9` → rows in that sequence) by building a SQL `CASE` expression.
No configure route, no permissions, no Drush, no services. All state lives in a **view config
entity** (`views.view.<id>` → a display's `sorts.<id>`).

- **Add & configure the sort on a view, its options, how the CASE query works** →
  [configure/sort.md](configure/sort.md)

Key facts:
- Declared via `hook_views_data()` as a `#global` sort (no join needed): table
  `views_arg_order_sort`, field `weight`, plugin `views_arg_order_sort_default`.
- Options: `argument_number` (which contextual filter, 0-indexed), `inherit_type` (derive
  column from that argument — usual), `field_type` (`table::field` e.g. `node::nid` when not
  inheriting), `null_below` (non-matching rows last), and standard `order` (ASC/DESC reverses).
- Config schema: `views.sort.views_arg_order_sort_default`.
