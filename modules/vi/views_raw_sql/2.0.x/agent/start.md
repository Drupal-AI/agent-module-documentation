<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Raw SQL (views_raw_sql) — agent index

Lets a permitted user add a hand-written SQL expression to a view as a **field**, a **sort**, or a
**contextual filter (argument)**. Depends only on core `views`. Version **2.0.0-alpha1** (2024),
core `^10.3 || ^11`. License GPL-2.0-or-later. No config UI, no Drush, no libraries.

## Mechanism
`views_raw_sql.views.inc` implements `hook_views_data()` and registers handlers on a `#global` join,
so they are offered in every view under the **Global** group:

| Handler | Views id | Class | How the SQL enters the query |
|---|---|---|---|
| Field | `field_views_raw_sql_numeric` | `NumericRawSQLField` (extends core `NumericField`) | `$query->addField(NULL, $sql, 'raw_sql_field', $params)`; aggregatable via a `my_group_type` group-by select |
| Sort | `sort_views_raw_sql` | `RawSQLSort` (extends `SortPluginBase`) | `$query->addOrderBy(NULL, $sql, $order, $id)`; `canExpose()` returns `FALSE` |
| Argument | `argument_views_raw_sql` | `RawSQLArgument` (extends `ArgumentPluginBase`) | `$query->addWhereExpression(0, $sql)`; the `[argument]` token is substituted with the contextual-filter value |

Every stored expression is passed through `\Drupal::token()->replace()` before it is added to the
query, so global tokens (e.g. `[site:name]`) are interpolated. The argument handler additionally
does a plain `str_replace('[argument]', $this->argument, $sql)`.

**A "Raw Filter" (`filter_views_raw_sql`) is declared in `hook_views_data()` but no filter plugin
class ships in this alpha** — only the field, sort and argument handlers actually resolve.

## Permission boundary — handled properly
```yaml
edit views raw sql:
  restrict access: TRUE
  warning: 'Raw SQL can expose sensitive site information, and could allow a malicious user to edit the site.'
```
The raw-SQL textarea only renders in a handler's options form when the current user holds
`edit views raw sql`. The permission is `restrict access: TRUE` and carries the warning above.
**Treat this permission as equivalent to database access, because it is** — an expression can read or
alter anything the site's DB user can. Grant it only to roles you would trust with a database client.

## Operational notes
- **No validation.** The expression is added verbatim; an invalid string simply breaks the view at render.
- **Not portable, not rewritten.** A hand-written expression binds the view to one DB engine (MySQL vs
  PostgreSQL) and is not adapted by anything that later alters the query — a proper custom handler would be.
- **`raw_sql` default is `0`**, so an unfilled field/sort adds the literal `0`.
- **Update 10001** changed the argument placeholder from `%argument%` to `[argument]`; older views must be updated.

## Files
- `views_raw_sql.views.inc` — `hook_views_data()`, registers the four handler ids on the `#global` join.
- `src/Plugin/views/field/NumericRawSQLField.php` — numeric field handler + group-by/aggregation form.
- `src/Plugin/views/sort/RawSQLSort.php` — sort handler (not exposable).
- `src/Plugin/views/argument/RawSQLArgument.php` — contextual-filter handler with `[argument]`.
- `views_raw_sql.permissions.yml` — the single `edit views raw sql` permission.
- `views_raw_sql.install` — `views_raw_sql_update_10001()` (placeholder-change note).

See [`views/handlers.md`](views/handlers.md) for per-handler configuration detail.
