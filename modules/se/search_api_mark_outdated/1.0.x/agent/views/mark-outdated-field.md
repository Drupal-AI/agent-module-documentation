<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views field: mark outdated (Views)

The module's only user-facing surface is a Views field handler that flags stale rows in a Search API
view.

## Adding it to a view

`hook_views_data_alter()` (`.views.inc`) registers the field on **every** Search API index's views
table. For an index with id `<id>` the field is exposed on table `search_api_index_<id>` as:

- table field key: `search_api_mark_outdated_state_field`
- handler `id`: `search_api_mark_outdated_state_field`
- `real field`: `id`
- admin title: *"Search API mark outdated field"*

In the Views UI (a view built on a Search API index), add the field **"Search API mark outdated
field"**. It has no output text of its own — it emits a marker element used to style the row.

## Field plugin

Class `Plugin\views\field\SearchApiStateField` (`@ViewsField("search_api_mark_outdated_state_field")`,
extends `views\...\FieldPluginBase`, uses `search_api\...\SearchApiHandlerTrait`). It pulls the
`search_api_mark_outdated.manager` service in `create()`.

`render(ResultRow $row)` returns:

```php
[
  '#type' => 'html_tag',
  '#tag'  => 'div',
  '#attributes' => [
    // 1 when the manager reports this item id outdated for the row's index, else 0.
    'data-is-outdated' => (int) $manager->isOutdated($this->getIndex(), $row->search_api_id),
  ],
  // only when add_row_class is on:
  '#attached' => ['library' => ['search_api_mark_outdated/row-class']],
]
```

`$row->search_api_id` is the Search API combined id of the result row; `$this->getIndex()` comes from
`SearchApiHandlerTrait`.

## The `add_row_class` option

- Defined in `defineOptions()`: `add_row_class` default `TRUE`; also forces the field `label` default
  to `''` (no visible label).
- `buildOptionsForm()` adds a checkbox **"Add row class"** — *"Add a row class to indicate that the
  result item is outdated."*
- Config schema: `views.field.search_api_mark_outdated_state_field` maps `add_row_class` (boolean).

When on, the field attaches the `search_api_mark_outdated/row-class` library. When off, the field
still renders `<div data-is-outdated="0|1">` but no JS is attached — you can target the attribute
yourself (e.g. CSS `[data-is-outdated="1"]`) or read it in a custom template.

## Library, JS behavior and CSS hook

- Library `search_api_mark_outdated/row-class` = `js/row-class.js` (dep `core/drupal`).
- Behavior `Drupal.behaviors.searchApiMarkOutdatedAddClass`: for each
  `div[data-is-outdated="1"]` it walks up to the closest `<tr>` and adds class
  `search-api-outdated`.
- Therefore the JS-driven styling **requires a table-based Views row style** (the closest ancestor
  `<tr>`). For non-table styles, disable `add_row_class` and style
  `[data-is-outdated="1"]` directly. The module ships no CSS — `search-api-outdated` is a hook for
  your theme.
