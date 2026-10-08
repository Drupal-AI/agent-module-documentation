<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API processor: `type_tray` (Type Tray)

File: `src/Plugin/search_api/processor/TypeTrayProcessor.php`
Class: `Drupal\facet_type_tray\Plugin\search_api\processor\TypeTrayProcessor extends ProcessorPluginBase`
Discovery: PHP attribute `#[SearchApiProcessor(id: 'type_tray', label: 'Type Tray', stages: ['add_properties' => 0])]`.

This is the **indexing** side. It adds one extra field to the index and populates it per node so the
Facets side has raw values to build a facet from.

## Property it adds

`getPropertyDefinitions(?DatasourceInterface $datasource)` returns a single `ProcessorProperty` only
when `$datasource` is NULL (index-level, datasource-independent):

- key `type_tray`, label "Type Tray category", description "Add type tray category for each content
  type", `type => string`, `processor_id => 'type_tray'`.

Add this property as a field on the index to make it facetable.

## Values it indexes

`addFieldValues(ItemInterface $item)`:

1. Gets the item's original object; returns early if it is not a `NodeInterface` (nodes only).
2. Loads the node's `node_type` entity and resolves its category via `getCategory()`:
   `NodeTypeInterface::getThirdPartySetting('type_tray', 'type_category')`, falling back to the bundle
   machine name (`$node_type->id()`) when no Type Tray category is set.
3. For each index field mapped to property path `type_tray` (found via
   `getFieldsHelper()->filterForPropertyPath($fields, NULL, 'type_tray')`):
   - `addValue($category)` — the parent category key (e.g. `resources`, or the bundle name when
     uncategorised).
   - When `$category !== $bundle`, also `addValue($category . '.' . $bundle)` — the compound
     `category.bundle` child value (e.g. `resources.page`). The dot is URI-unreserved, so the compound
     value survives the Views AJAX encode/decode roundtrip without double-encoding.

So a categorised node indexes two values (parent + child); an uncategorised node indexes one (its
bundle name only).

## Dependencies

Injected in `create()` via setters: `entity_type.manager` (load node types) and `config.factory`
(held but not used in this class). No request/query data is read here.

## Operate

Enable on the index Processors tab, add the "Type Tray category" field, then re-index. Changing a
content type's Type Tray category requires re-indexing affected nodes.
