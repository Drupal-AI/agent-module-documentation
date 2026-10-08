<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service, hooks, computed Alias field

## Service `base_field_display.manager`
- Class `Drupal\base_field_display\BaseFieldDisplayManager` implements `BaseFieldDisplayManagerInterface`
  (`base_field_display.services.yml`, one arg `@config.factory`). Reads immutable config
  `base_field_display.settings` once in the constructor (`const SETTINGS`).

## Hooks (`base_field_display.module`, all delegate to the manager)
- `hook_entity_base_field_info_alter` → `entityBundleFieldInfoAlter(&$base_field_definitions, $entity_type)`:
  1. If the entity type `hasLinkTemplate('canonical')`, adds a computed `path` base field
     `base_field_display_alias` labelled "Alias" (cardinality 1, translatable, computed, class
     `\Drupal\base_field_display\AliasComputed`).
  2. For each base field whose machine name is listed in config for `$entity_type->id()`, calls
     `->setDisplayConfigurable('view', TRUE)` — this is the whole point: it makes the field appear in
     Manage Display. Fields not listed are unchanged.
- `hook_entity_type_build` → `entityTypeBuild(&$entity_types)`: sets
  `enable_base_field_custom_preprocess_skipping = TRUE` on `node` and `taxonomy_term` entity types.
- `hook_preprocess_node` / `hook_preprocess_taxonomy_term` → `preprocessEntity($entity_type_id, &$variables)`:
  if the name field (`title` for node, `name` for taxonomy_term) is activated in config, sets
  `$variables['content'][$name_field]['#printed'] = FALSE` and `['#is_page_title'] = FALSE` so the title/name
  can render as a field even though core already output it as the page `h1`.

## Computed Alias field — `AliasComputed`
`src/AliasComputed.php` extends core `Drupal\path\Plugin\Field\FieldType\PathFieldItemList` and uses
`ComputedItemListTrait`. `computeValue()` returns NULL for new entities or entities without a `canonical`
link template; otherwise sets item 0 to the generated canonical URL string
(`$entity->toUrl('canonical')->toString(TRUE)->getGeneratedUrl()`). Pair it with the
`base_field_display_path_string` formatter to output the alias/URL as text.

## Notes for agents
- No public API beyond the service interface; typical use is purely config-driven via the settings form.
- Access control is entirely core's: activated base fields render through the standard entity-display
  pipeline, which enforces each field's own `access('view')` — the module adds no bypass.
