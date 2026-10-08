<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets hierarchy: `type_tray` (Type Tray hierarchy)

File: `src/Plugin/facets/hierarchy/TypeTrayHierarchy.php`
Class: `Drupal\facet_type_tray\Plugin\facets\hierarchy\TypeTrayHierarchy extends HierarchyPluginBase`.
Annotation: `@FacetsHierarchy(id = "type_tray", label = "Type Tray hierarchy", description = "Hierarchy structure based on Type Tray categories and content types.")`.

Defines the parent/child relationship the Facets widget uses for a two-level tree: **parent = Type Tray
category key** (e.g. `group`), **child = compound `category.bundle`** (e.g. `group.event`). The dot is
URI-unreserved, so compound values survive the Views AJAX encode/decode roundtrip.

## Methods (all keyed on the dot in the raw value)

- `getParentIds($id)` — if `$id` contains a dot, returns `[$category]` (the part before the first dot);
  otherwise `[]` (a category has no parent).
- `getChildIds(array $ids)` — for each id **without** a dot, returns its child compound values via
  `getBundlesForCategory()`; results run through `array_filter()` to drop empties.
- `getNestedChildIds($id)` — for a dot-less id, the same list of `category.bundle` children; `[]` for a
  compound id (bundles have no further children).
- `getBundlesForCategory(string $category)` (protected) — loads all `node_type` entities via
  `entity_type.manager`, and for each whose `getThirdPartySetting('type_tray', 'type_category')` equals
  `$category`, collects `"$category.{$node_type->id()}"`.

## Caching

- `getCacheTags()` merges parent tags with `config:node_type_list` (rebuilds when content types change).
- `getCacheMaxAge()` returns `Cache::PERMANENT`.

## Dependencies

`entity_type.manager`, injected via `create()`. No request/query input; reads only node-type entities
and their Type Tray third-party settings.

## Operate

Select "Type Tray hierarchy" as the facet's hierarchy plugin and choose a hierarchy-capable widget
(e.g. core checkbox widget with hierarchy enabled) to get the category→content-type tree. Requires the
Search API processor to have indexed the compound `category.bundle` values.
