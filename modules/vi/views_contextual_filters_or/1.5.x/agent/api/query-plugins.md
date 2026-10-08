<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works: swapped query & display plugins

The module has no services or public API to call — it works by **replacing core Views
plugin classes** via alter hooks and reading the `contextual_filters_or` display option at
query-build time. Useful to know when debugging why a view's arguments do (or don't) OR.

## Plugin swaps (in `.views.inc` / `.module`)

- `hook_views_plugins_query_alter()` — repoints the `views_query` plugin class to
  `Drupal\views_contextual_filters_or\Plugin\views\query\ExtendedSql`, and (when Search API
  is installed) `search_api_query` to `…\query\ExtendedSearchApiQuery`.
- `hook_views_plugins_display_alter()` — repoints the `entity_reference` display plugin to
  `…\display\ExtendedEntityReference`.
- `hook_config_schema_info_alter()` — adds the `contextual_filters_or` boolean to the
  `views.query.views_query` (and `views.query.search_api_query`) mapping.

Because these are class overrides, the option shows up on the standard Query settings form
of every view display; no separate plugin id is introduced.

## `ExtendedSql` (SQL views)

Extends core `Sql`. Adds `defineOptions()['contextual_filters_or'] = ['default' => FALSE]`
and the checkbox in `buildOptionsForm()`. The behaviour lives in overrides of
`addWhere()`, `addWhereExpression()` and `addHavingExpression()`: when a WHERE/HAVING group
is first created, the group operator is chosen by the option —

```php
$op = $this->options['contextual_filters_or'] ? 'OR' : 'AND';
$this->setWhereGroup($op, $group);   // group 0 becomes an OR group when enabled
```

Contextual filters add their conditions to the default group (0), so flipping that group's
operator to OR makes the arguments OR together. Conditions in explicitly-numbered groups
(e.g. exposed filter groups) are unaffected.

## `ExtendedSearchApiQuery` (Search API views)

Extends `SearchApiQuery`; same `defineOptions()` + checkbox. In `build()`, if the option is
on and there is a default group with conditions, it merges `['type' => 'OR']` into group 0
before calling `parent::build()`, giving OR semantics for Search API contextual filters.

## `ExtendedEntityReference` (display)

Extends the core `EntityReference` display and only overrides `optionsSummary()` to
`unset($options['title'])` — it removes the redundant Title row from that display's options
summary. Cosmetic; unrelated to the OR logic but shipped in the same module.

## Debugging checklist

- View not OR-ing? Confirm `display.<id>.display_options.query.options.contextual_filters_or`
  is `true` **and** the display actually has contextual filters (arguments).
- Confirm the query plugin class is really overridden:
  `drush php:eval 'var_dump(get_class(\Drupal\views\Views::getView("MY_VIEW")->getQuery()));'`
  after `->setDisplay()->build()` should show `ExtendedSql` / `ExtendedSearchApiQuery`.
- Only group 0 is flipped — multi-group filter setups keep their own operators.
