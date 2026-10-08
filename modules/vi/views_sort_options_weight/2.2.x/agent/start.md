# Views Sort By Options Weight — agent index

Three core-Views sort handlers that order results by an admin-assigned weight per value
(list-field allowed values, entity bundles, or user roles) instead of by the raw stored value.
No settings page (`configure` null), no permission, no Drush. Requires core `views`.

- **The three sort handlers, how to add them in a view, the weight options form, the generated
  SQL, and the admin-config trust boundary** → [configure/sorts.md](configure/sorts.md)

Key facts:
- Base: `src/Plugin/views/sort/ExtendedSortByWeightBase.php` (`extends views\Standard`,
  `canExpose()` → FALSE).
- Handlers: `extended_sort_by_options_weight` (list_string/list_integer/list_float fields),
  `extended_sort_by_bundles_weight` (entity bundles), `extended_sort_by_user_role_weight` (roles).
- Exposed in the Views UI as extra "(set weight)" sort fields by
  `views_sort_options_weight.views.inc` (`hook_views_data_alter` + `hook_field_views_data_alter`);
  allowed field types = `list_string`, `list_float`, `list_integer`.
- Query builds `ORDER BY CASE WHEN <col> = '<value>' THEN <weight> … ELSE 1000 END`.
