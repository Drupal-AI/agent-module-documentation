# Views List Sort — agent index

One Views **sort handler** `sort_allowed_values`
(`Drupal\views_list_sort\Plugin\views\sort\SortAllowedValues`) that sorts a List (text)
(`list_string`) field by its **allowed-values order** instead of alphabetically, using a SQL
`FIELD()` expression. No configure route, no permissions, no Drush, no config schema file.

- **Enable it on a view sort, the two options, how the SQL works, storage** →
  [configure/sort.md](configure/sort.md)

Key facts:
- `hook_field_views_data_alter()` sets the sort `id` to `sort_allowed_values` for every
  `list_string` field's `_value` column, so the option appears automatically when you add that
  field as a sort in a View.
- Two per-sort options: `allowed_values` (0/1 — the actual toggle) and `null_heavy` (0/1 — sort
  empty values last). `hook_config_schema_info_alter()` registers both on `views.sort.*`.
- State lives in the **view config entity** at
  `display.<id>.display_options.sorts.<field>_value` (`plugin_id: sort_allowed_values`,
  `allowed_values`, `null_heavy`).
