<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Sort Expression — agent index

Adds one Views sort handler that orders a view by an arbitrary SQL expression you type, rather
than by a plain column. Advanced/site-builder tool: you must know the view's compiled SQL.
No config page, no permissions of its own, no submodules. `configure: null`.

- **The `views_sort_expression` sort plugin — how it is exposed in Views data, the Expression
  textarea and Aggregate checkbox, the generated ORDER BY, GROUP BY handling, and how to add it
  to a view in config** → [plugins/sort.md](plugins/sort.md)

Key facts:
- Views sort plugin id: **`views_sort_expression`** (`@ViewsSort("views_sort_expression")`,
  class `ExpressionSort` extends `SortPluginBase`).
- Exposed as a global **"Expression"** sort on the special `views` table via
  `hook_views_data_alter()` — not tied to any field or entity.
- `query()` calls `$this->query->addOrderBy(NULL, $options['expression'], $options['order'], $alias)`,
  so the expression string becomes the ORDER BY term as written; ordered ASC/DESC.
- Two stored options (config schema `views.sort.views_sort_expression`): `expression` (string,
  textarea) and `aggregate` (boolean, checkbox).
- Aggregate checkbox on → `hook_views_post_build()` strips this sort's alias from the query
  GROUP BY so aggregate expressions (SUM/COUNT/MAX/…) sort correctly. `usesGroupBy()` returns FALSE.
- The referenced field/formula must already exist in the compiled query; enable "Show the SQL
  query" (Views settings) to find real aliases. Configuring a sort requires `administer views`.
