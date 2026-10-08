# single_content_sync — api

Services for exporting/importing content in code (defined in `single_content_sync.services.yml`).

## `single_content_sync.exporter` — `ContentExporterInterface`

- `doExportToArray(FieldableEntityInterface $entity): array` — serialize an entity (and references) to an array.
- `doExportToYml(FieldableEntityInterface $entity, bool $extract_translations = FALSE): string` — serialize to a YAML string.
- `getFieldValue(FieldItemListInterface $field)` — export one field's value.
- `exportBaseValues(FieldableEntityInterface $entity): array` — base fields only (a "stub").
- `exportCustomValues(FieldableEntityInterface $entity, bool $check_translated_fields_only = FALSE): array` — custom fields.

## `single_content_sync.importer` — `ContentImporterInterface`

- `doImport(array $content): EntityInterface` — create/update an entity from an exported array.
- `importFromFile(string $file_real_path): EntityInterface` — import from a local `.yml` file.
- `importFromZip(string $file_real_path): void` — import content + assets from a local `.zip`.
- `importAssets(string $extracted_file_path, string $zip_file_path): void`
- `setFieldValue(...)`, `importBaseValues(...)`, `importCustomValues(...)`
- `createStubEntity(array $entity): EntityInterface` — create an entity from base fields only.
- `isFullEntity(array $entity): bool` — whether an exported array is a full entity vs. a stub.

Import on deploy from a `hook_update_N`:
```php
function mymodule_update_11001() {
  $path = \Drupal::service('extension.list.module')->getPath('mymodule') . '/assets/homepage.yml';
  \Drupal::service('single_content_sync.importer')->importFromFile($path);
  // Or a bundle: ->importFromZip('.../homepage.zip');
}
```

## Other services

- `single_content_sync.file_generator` — `ContentFileGeneratorInterface`: `generateYamlFile()`,
  `generateZipFile()`, `generateBulkZipFile()`; produces managed file entities for download/move.
- `single_content_sync.helper` — `ContentSyncHelperInterface`: filename generation, directory prep,
  entity access, default-language resolution, archive handling.
- `single_content_sync.command_helper` — utility used by the Drush commands.

## Events (alter path — alternative to plugins)

Subscribe in an event subscriber service:
- `ExportEvent` — alter an entity as it is exported.
- `ExportFieldEvent` — alter a field value as it is exported.
- `ImportEvent` — alter an entity before it is saved on import.
- `ImportFieldEvent` — alter a field value on import.
- `BulkExportRoutesEvent` (`EVENT_NAME`) — `addRoute()` / `removeRoute()` to control which entity
  collection routes get the bulk-export action.

The legacy alter hooks (`hook_content_export_field_value_alter`, `hook_content_export_entity_alter`,
`hook_content_import_entity_alter`, `hook_content_import_field_value_alter` in
`single_content_sync.api.php`) are **deprecated** in 1.4.0 / removed in 2.0.0 — use plugins or events.
