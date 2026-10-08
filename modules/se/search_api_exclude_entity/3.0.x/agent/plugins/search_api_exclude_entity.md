# Plugins provided

This module does **not** define new plugin *types* (`provides_plugin_types: []`); it ships
plugin *instances* against core / Search API / Single Content Sync plugin managers.

| Plugin | Type / manager | ID | Notes |
|---|---|---|---|
| `SearchApiExcludeEntityFieldItem` | Field type (`@FieldType`) | `search_api_exclude_entity` | Single boolean; stored as tiny int. `default_widget` / `default_formatter` below. |
| `SearchApiExcludeEntityFieldWidget` | Field widget (`@FieldWidget`) | `search_api_exclude_entity_widget` | Checkbox; settings `field_label`, `use_details_container`. |
| `SearchApiExcludeEntityFormatter` | Field formatter (`@FieldFormatter`) | `search_api_exclude_entity_formatter` | Extends `BooleanFormatter`, default format `yes-no`. |
| `SearchApiExcludeEntityProcessor` | Search API processor (`@SearchApiProcessor`) | `search_api_exclude_entity_processor` | `alter_items` stage, weight -50; drops items whose selected exclude field is truthy. Implements `PluginFormInterface` for the field-selection settings form. |
| `SearchApiExcludeEntityField` | Single Content Sync field processor (`@SingleContentSyncFieldProcessor`) | `search_api_exclude_entity_field` | Only loaded when `single_content_sync` is present (dev/optional); import/export the boolean value. |

## Processor behavior (the core mechanism)

`SearchApiExcludeEntityProcessor::alterIndexedItems(array &$items)`:
- Reads config `fields[<entity_type_id>]` = array of exclude field ids to honor.
- For each item, gets the original entity, checks `bundleHasField()` (via
  `EntityFieldManager::getFieldMapByFieldType('search_api_exclude_entity')`) to avoid
  `InvalidArgumentException`, then reads `$entity->get($field)->getValue()[0]['value']`.
- If truthy, `unset($items[$item_id])` so the entity is excluded from that index.

The settings form iterates the index's datasources, and for each entity type offers a
`checkboxes` element of the exclude fields available on that datasource's bundles.

## Implementing your own similar processor

To exclude items on other criteria, write a Search API processor extending
`ProcessorPluginBase`, declare an `alter_items` stage, and `unset()` unwanted items in
`alterIndexedItems()` — exactly what the two submodules do (by arbitrary field value, and by
Metatag `robots: noindex`). See `modules/search_api/1.41.x/` for the processor plugin type.
