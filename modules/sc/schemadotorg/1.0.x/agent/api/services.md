# Schema.org Blueprints — services API

## `schemadotorg.schema_type_manager` — `SchemaDotOrgSchemaTypeManagerInterface`
Read/query the bundled Schema.org vocabulary. Highlights:
- Predicates: `isType`, `isProperty`, `isThing`, `isDataType`, `isIntangible`, `isEnumerationType`,
  `isEnumerationValue`, `isSubTypeOf($type, $subtype_of)`, `isSubPropertyOf`, `isSuperseded`.
- Lookups: `getType($type, $fields)`, `getProperty($property)`, `getTypeProperties($type)`,
  `getPropertyRangeIncludes($property)`, `getPropertyDefaultType($property)`.
- Hierarchy: `getTypeChildren`, `getAllTypeChildren`, `getSubtypes`, `getParentTypes`, `getTypeTree`,
  `getTypeBreadcrumbs`, `getTypeChildrenAsOptions`.
- `parseIds($text)` turns a `entity_type:SchemaType` token into parts.

## `schemadotorg.names` — `SchemaDotOrgNamesInterface`
Converts Schema.org CamelCase names into Drupal-safe machine names (fields/bundles) honoring length limits
and the custom word/name abbreviation maps in `schemadotorg.names` config.

## `schemadotorg.mapping_manager` — `SchemaDotOrgMappingManagerInterface`
Orchestration entry point:
- `getMappingDefaults($entity_type_id, $bundle, $schema_type, $defaults)` /
  `prepareCustomMappingDefaults(...)` — compute the default field/property mapping for a type.
- `saveMapping($entity_type_id, $schema_type, array $values, ?$mapping)` — create/update a
  `schemadotorg_mapping` (and the underlying bundle/fields).
- `createTypeValidate()` / `createType($entity_type_id, $schema_type, $defaults)` — build a type.
- `createDefaultTypes($entity_type_id)` — create the recommended default types for an entity type.
- `deleteTypeValidate()` / `deleteType($entity_type_id, $schema_type, $options)` — remove a type
  (options `delete-entity`, `delete-fields`).
- `getIgnoredProperties()` — properties excluded from field creation.

## Builders (used by the manager)
- `schemadotorg.entity_type_builder` (`SchemaDotOrgEntityTypeBuilder`) — creates the bundle/entity type.
- `schemadotorg.entity_field_manager` (`SchemaDotOrgEntityFieldManager`) — creates fields for properties,
  picking field type (via `plugin.manager.field.field_type`), widget, and formatter.
- `schemadotorg.entity_display_builder` — configures form/view displays.
- `schemadotorg.schema_type_builder` — builds type-related render/data structures.
- `schemadotorg.config_manager`, `schemadotorg.installer` — config helpers and schema-data install/update.

Mapping storage: `SchemaDotOrgMappingStorage` (with helpers to find the mapping for an entity/bundle).

Example — create a Person node type in code:
```php
\Drupal::service('schemadotorg.mapping_manager')->createType('node', 'Person');
```
