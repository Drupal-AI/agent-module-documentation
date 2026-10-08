<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Raw SQL — handler reference

All handlers live on the synthetic `views_raw_sql` table joined into every view via a `#global`
join (`hook_views_data()` in `views_raw_sql.views.inc`). They appear under the **Global** group in
the Add-field / Add-sort / Add-contextual-filter dialogs. Each handler stores its expression in a
`raw_sql` (or `where_raw_sql`) option that defaults to `0`, and each renders its textarea in
`buildOptionsForm()` **only** when the current user has `edit views raw sql`.

## Numeric Raw SQL field — `field_views_raw_sql_numeric`
`src/Plugin/views/field/NumericRawSQLField.php`, extends core `NumericField`.

- `query()`: `ensureMyTable()`, token-replace the `raw_sql` option, then
  `$this->field_alias = $this->query->addField(NULL, $sql, 'raw_sql_field', $params)` and
  `addAdditionalFields()`.
- Aggregation: `buildGroupByForm()` removes the core `group_type` element and adds `my_group_type`
  (default `sum`) populated from `$this->query->getAggregationInfo()`. When aggregation is on and
  `my_group_type` is not the plain `group`, `$params = ['function' => $group_type]`, so the expression
  is wrapped in that aggregate (SUM/COUNT/MIN/MAX/…). `submitGroupByForm()` persists the choice.
- Because it is a `NumericField`, the usual numeric formatting options (precision, separators, prefix/
  suffix) apply to the rendered value.

## Raw Sort — `sort_views_raw_sql`
`src/Plugin/views/sort/RawSQLSort.php`, extends `SortPluginBase`.

- `query()`: token-replace `raw_sql`, then
  `$this->query->addOrderBy(NULL, $sql, $this->options['order'], $this->options['id'])`. Passing the
  handler id as the alias means the sort expression is also added as a select field to the result.
- `canExpose()` returns `FALSE` — this sort can never be turned into an exposed sort in the UI.

## Raw Argument (contextual filter) — `argument_views_raw_sql`
`src/Plugin/views/argument/RawSQLArgument.php`, extends `ArgumentPluginBase`.

- Option key is `where_raw_sql` (not `raw_sql`).
- `query()`: token-replace `where_raw_sql`, then `str_replace('[argument]', $this->argument, $sql)`,
  then `$this->query->addWhereExpression(0, $sql)` (group 0 = the query's main WHERE).
- The `[argument]` token resolves to the contextual-filter value the view receives (URL path segment,
  a fixed default, etc.). `update 10001` changed this token from the old `%argument%`.
- Standard contextual-filter options still apply (what to do when the argument is present/absent,
  validation, default value) — configure them deliberately, since the argument value is what the
  handler places into the SQL.

## Tokens
Every handler runs its stored expression through `\Drupal::token()->replace()` before use, so any
global token available on the site can be interpolated (`[site:name]`, `[current-date:*]`, …). The
expression is otherwise added to the query verbatim — there is no SQL validation, and an invalid or
engine-specific expression will break the view.
