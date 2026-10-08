# FieldProcessor & ExportEntityFilter plugin types

Two plugin types drive the export. Both are managed by `default_plugin_manager`-based managers
(see `migrate_default_content_export.services.yml`).

## FieldProcessor
Decides how a single field's value is serialized into the exported YAML.
- **Manager:** `plugin.manager.migrate_default_content_export.field_processor`.
- **Directory:** `src/Plugin/FieldProcessor/`.
- **Base:** `FieldProcessorPluginBase` (interface `FieldProcessorInterface`).
- **Annotation:** `@FieldProcessor` (`id`, `title`, `description`).
- **Key methods:**
  - `isApplicable(ContentEntityInterface $entity, string $field_name, FieldDefinitionInterface $field_definition): bool`
  - `getValue(ContentEntityInterface $entity, string $field_name, FieldDefinitionInterface $field_definition): mixed`

For each field the command uses the first processor whose `isApplicable()` returns TRUE (falling
back to `GenericFieldProcessor`), caching the match per field type.

Shipped processors (`src/Plugin/FieldProcessor/`): `Generic`, `EntityReference`, `UserReference`,
`UserEmail`, `File`, `Link`, `Path`, `Color`, `Comment`, `Integer`, `Text`, `LayoutSection`,
`Password`. Notable: `PasswordFieldProcessor` returns `NULL` (passwords are never exported);
reference processors emit the referenced entity's identifier so imports can resolve them.

## ExportEntityFilter
Excludes whole entities from the export.
- **Manager:** `plugin.manager.migrate_default_content_export.export_entity_filter`.
- **Directory:** `src/Plugin/ExportEntityFilter/`.
- **Base:** `ExportEntityFilterPluginBase` (interface `ExportEntityFilterInterface`).
- **Annotation:** `@ExportEntityFilter` (`id`, `title`, `description`, `entity_types` — the
  entity types the filter applies to).

Shipped filters: `AdminUserFilter` (skips uid 1) and `AnonymousUserFilter` (skips the anonymous
user), both scoped to the `user` entity type.

## Adding your own
Create a class under the relevant `Plugin/` directory, add the annotation, implement the
interface. Your processor/filter is picked up automatically — use it to serialize a custom field
type or to exclude entities (e.g. unpublished nodes) from fixtures.
