<!-- SPDX-License-Identifier: GPL-2.0+ -->
# Views filter plugin: `views_filters_populate`

The module ships exactly one Views filter plugin. It defines no plugin *type* of its own —
it implements the core Views `filter` plugin type.

| | |
|---|---|
| Plugin ID | `views_filters_populate` |
| Class | `Drupal\views_filters_populate\Plugin\views\filter\Populate` |
| Annotation | `@ViewsFilter("views_filters_populate")` |
| Base class | `Drupal\views\Plugin\views\filter\FilterPluginBase` |
| Backing table/field | `views_filters_populate.populate` (a `#global` Views table added by `hook_views_data()`, joinable on any base table) |
| Real stored option | `filters` — array of target filter machine names, `defineOptions()`: `$options['filters'] = ['default' => []]` |
| Helper class | `PopulateRemoveEmptyFilterMock` (`src/Plugin/views/filter/PopulateRemoveEmptyFilterMock.php`), not a plugin — an internal runtime-only handler |

## What it does

Add this filter to a view (usually exposed, so a visitor can type a value) and pick one or
more **other, non-exposed** filters in the same display as its `filters` targets. Nothing
about this filter itself narrows the query — its own `query()` is a no-op. Instead:

1. `preQuery()` reads the submitted/default value (`$this->value`, or the exposed input keyed
   by `$this->options['expose']['identifier']` when exposed) and copies it onto every target
   handler: `$filter->value = $value` for a `StringFilter` target, `$filter->value['value'] =
   $value` for a `NumericFilter` target.
2. Each target then runs its own normal `query()` (e.g. a "contains" `LIKE` for a string filter,
   an `=`/`>`/`<` comparison for a numeric filter) using the populated value — so several
   independently-defined filters end up matching the *same* typed value against *different*
   fields/tables.

## Constraints on target filters

`buildOptionsForm()` only lists filters in the "Available filters" multi-select that:

- are not the populate filter itself,
- are an instance of `StringFilter` or `NumericFilter` (checked by `isFilterSupported()`), and
- have `exposed: false` in their own options.

`valueValidate()` refuses to save the populate filter's options if no eligible target exists,
or if none are selected. `validate()` re-checks at view build/save time that every id in
`filters` still resolves to a handler in the display and that none of them is exposed —
otherwise it adds a view validation error naming the offending filter and display.

## Exposed-empty behavior (`access()` + `PopulateRemoveEmptyFilterMock`)

If the populate filter is exposed (`$this->options['exposed']`) and the submitted/default
value is empty, `access()` appends a `PopulateRemoveEmptyFilterMock` instance to
`$this->view->filter[]`. On the next `preQuery()` pass that mock removes both the populate
filter's targets (`unset($handler->view->filter[$id])` for every id in `filters`) and itself
from the view's filter collection. Net effect: submitting the exposed filter empty makes the
whole group (populate filter + its targets) behave as an **optional** exposed filter — no
`WHERE` clause is added for any of them — rather than matching an empty string/value.

## How it is stored in a view

A filter handler entry under `display.<display_id>.display_options.filters.<handler_id>`
with `plugin_id: views_filters_populate` and a `filters` list of target handler ids, e.g.:

```yaml
filters:
  title_target:            # a non-exposed target, e.g. plugin_id: string
    id: title_target
    table: node_field_data
    field: title
    plugin_id: string
    operator: contains
    value: ''
    exposed: false
  populate:                 # the populate filter itself, usually exposed
    id: populate
    table: views_filters_populate
    field: populate
    plugin_id: views_filters_populate
    value: ''
    exposed: true
    expose:
      identifier: populate
    filters:                # <-- the real option: target handler ids
      title_target: title_target
```

Read it back with `drush config:get views.view.<view_id> display.default.display_options.filters`
(or the relevant display id), or in PHP via
`$view->getExecutable()->getDisplay()->getHandler('filter', 'populate')->options['filters']`.

## Known schema quirk

`config/schema/views_filters_populate.schema.yml` defines a schema key
`views.filter.populate` mapping a `fields` sequence:

```yaml
views.filter.populate:
  type: views.filter.string
  mapping:
    fields:
      type: sequence
      sequence:
        type: string
```

This does **not** match reality: the plugin id is `views_filters_populate` (not `populate`),
and the actual stored option is `filters` (not `fields`). The schema key is effectively
orphaned/dead — Views resolves a filter's schema by its `plugin_id` (`views.filter.<plugin_id>`),
so `views.filter.populate` is never looked up for a `views_filters_populate` handler, and the
handler's real `filters` option has no dedicated schema coverage at all (it falls back to the
generic `views.filter.string` schema's catch-all). `provides_config_schema` is still `true`
because the file exists, but don't trust its key names — trust `defineOptions()` in
`Populate.php` instead.
