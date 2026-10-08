<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Current Path — agent index

One Views global field, `current_path` ("Global: Current path"), that outputs the current
page's path/URL/query string. No settings page (`configure` null), no permissions, no Drush,
no plugin types. Registered via `hook_views_data_alter()`; handler class `CurrentPath`
extends `FieldPluginBase` and runs no query. Provides a config schema for the field options.

- **Add the field, the seven output styles, query-string handling and query-param
  filter/rename/trim/lower options, caching** → [configure/field.md](configure/field.md)

Key facts:
- Field id `current_path`, group "Global"; add it in *Add > Global: Current path*.
- Value comes from `path.current` / `Request::getRequestUri()` / `$_SERVER['QUERY_STRING']`
  at render time — it reflects the visitor's request, not a stored row value.
- Output styles: `raw-internal` (default), `raw-relative`, `raw-absolute`, `alias-internal`,
  `alias-relative`, `alias-absolute`, `query-only`.
- Alias output styles need core's Path module for aliases to resolve.
