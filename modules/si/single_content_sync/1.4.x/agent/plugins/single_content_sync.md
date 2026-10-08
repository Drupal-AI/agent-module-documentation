# single_content_sync — plugins

Two plugin types isolate custom export/import logic (the preferred extension mechanism over the
deprecated alter hooks).

## SingleContentSyncFieldProcessor (per field type)

- Manager service: `plugin.manager.single_content_sync_field_processor`.
- Discovery dir: `src/Plugin/SingleContentSyncFieldProcessor/`.
- Interface: `Drupal\single_content_sync\SingleContentSyncFieldProcessorInterface`
  (base class `SingleContentSyncFieldProcessorPluginBase`).
- Annotation: `@SingleContentSyncFieldProcessor` with `id`, `label`, `field_type` (the field type
  machine name this plugin handles). One plugin per field type (duplicate = LogicException).
- Fallback: fields with no matching plugin use the `generic` plugin.

Implement:
```php
public function exportFieldValue(FieldItemListInterface $field): array;
public function importFieldValue(FieldableEntityInterface $entity, string $fieldName, array $value): void;
```

Example skeleton:
```php
/**
 * @SingleContentSyncFieldProcessor(
 *   id = "my_field",
 *   label = @Translation("My field processor"),
 *   field_type = "my_custom_field_type",
 * )
 */
class MyField extends SingleContentSyncFieldProcessorPluginBase { /* export/import methods */ }
```

Bundled processors (field_type): `generic`, `link`, `entity_reference`,
`entity_reference_revisions`, `address_zone`, `layout_section`, `metatag`, `webform`, `text_field`,
`file_asset` (some are provided via derivers under `src/Plugin/Derivative/SingleContentSyncFieldProcessor/`).

## SingleContentSyncBaseFieldsProcessor (per entity type)

- Manager service: `plugin.manager.single_content_sync_base_fields_processor`.
- Discovery dir: `src/Plugin/SingleContentSyncBaseFieldsProcessor/`.
- Interface: `Drupal\single_content_sync\SingleContentSyncBaseFieldsProcessorInterface`
  (base class `SingleContentSyncBaseFieldsProcessorPluginBase`).
- Annotation: `@SingleContentSyncBaseFieldsProcessor` with `id`, `label`, `entity_type` (the entity
  type machine name). One plugin per entity type; fallback is the `generic` plugin.

Bundled processors (entity_type): `node`, `media`, `file`, `taxonomy_term`, `user`, `paragraph`,
`block_content`, `menu_link_content`, `section_library_template`, plus `generic`.

## Events (alternative)

`ExportEvent`, `ImportEvent`, `ExportFieldEvent`, `ImportFieldEvent`, and `BulkExportRoutesEvent`
let a subscriber alter behavior without defining a plugin — see the api doc.
