<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# List-builder swap, traits, and entity-type map

All in `admin_list_filter.module` and `src/`.

## The swap — `hook_entity_type_alter()`

`admin_list_filter_entity_type_alter(array &$entity_types)` iterates a fixed map of
`entity_type_id => FilterableXListBuilder` and, for each id that exists, calls:

```php
$entity_types[$entity_type_id]->setHandlerClass('list_builder', $class);
```

`pathauto_pattern` and `metatag_defaults` are added to the map only inside
`if (isset($entity_types['pathauto_pattern']))` / `if (isset($entity_types['metatag_defaults']))`
guards, so they take effect only when those contrib modules are installed. Clear caches after
enable/disable so the handler map is rebuilt.

## Trait 1 — `FilterableListBuilderTrait` (standard lists)

For subclasses of `EntityListBuilder` (which have `render()` returning a render array with a `table`).

- `render()`: calls `parent::render()`, then adds:
  - `$build['filters']` = a `#type => 'search'` element, `#weight => -10`, with attributes
    `class => ['table-filter-text']`, `data-table => '.filterable-config-entity-table'`,
    `autocomplete => 'off'`, placeholder "Filter by name".
  - `$build['table']['#attributes']['class'][] = 'filterable-config-entity-table';`
  - `$build['#attached']['library'][] = 'system/drupal.system.modules';`
- `buildRow()`: calls `parent::buildRow()`, then for every cell except `operations`/`weight` wraps
  non-array cells as `['data' => …]` and appends class `table-filter-text-source` (the class the core
  JS searches).

## Trait 2 — `FilterableDraggableListBuilderTrait` (draggable/form lists)

For subclasses of `DraggableListBuilder` (which build a form via `buildForm()`, keyed by
`$this->entitiesKey`).

- `buildForm()`: calls `parent::buildForm()`, adds the same `#type=search` `filters` element, sets
  `filterable-config-entity-table` on `$form[$this->entitiesKey]`, then loops the entity rows and adds
  `#wrapper_attributes['class'][] = 'table-filter-text-source'` to each searchable cell (skipping
  `#`-prefixed keys, `operations`, `weight`). Attaches `system/drupal.system.modules`.

## Entity-type → list-builder → trait map

Standard (FilterableListBuilderTrait): `block_content_type`, `comment_type`, `contact_form`,
`date_format`, `field_storage_config`, `image_style`, `media_type`, `menu`, `node_type`,
`responsive_image_style`, `shortcut_set`, `workflow`, plus contrib `metatag_defaults`.

Draggable (FilterableDraggableListBuilderTrait): `configurable_language`, `filter_format`,
`search_page`, `taxonomy_vocabulary`, `user_role`, plus contrib `pathauto_pattern`.

Each `src/ListBuilder/FilterableXListBuilder` simply extends the matching core list builder (e.g.
`NodeTypeListBuilder`, `RoleListBuilder`, `VocabularyListBuilder`) and `use`s the appropriate trait —
no other logic. Because they subclass the originals, all original columns, operations, access checks,
and output escaping are preserved.

## Why it is server-side inert

The filter box has no `name`/form submission wiring of its own and issues no request; core's
`drupal.system.modules` JS hides rows client-side. No query parameter is read on the server, so there
is no new query, no reflected value, and no change to each page's existing `_permission`/`_entity_access`
gating.
