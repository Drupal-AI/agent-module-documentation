<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extending schema generation (schema_json normalizers)

Field-level schema shape is produced by a chain of **tagged normalizer services** that convert typed
data / field definitions into JSON Schema fragments. They are invoked with the format string
`'schema_json'` by `JsonApiSchemaController::addFieldsSchema()`, via a `StaticDataDefinitionExtractor`
that yields a field's data definition for a given entity type + bundle.

## The shipped normalizers (`*.services.yml`)

All tagged `{ name: normalizer }`; higher `priority` wins for a supported type:

| Service (class in `src/Normalizer/`) | Priority | Handles |
|---|---|---|
| `RelationshipFieldDefinitionNormalizer` | 35 | Relationship field definitions (needs `@plugin.manager.field.field_type`). |
| `FieldDefinitionNormalizer` | 30 | Field definitions (attributes). |
| `ComplexDataDefinitionNormalizer` | 20 | Complex data (multi-property fields). |
| `ListDataDefinitionNormalizer` | 20 | List/multi-value definitions. |
| `DataDefinition*Normalizer` (boolean, string, number, email, datetime_iso8601, entity_reference, timestamp, uri, undefined) | 10 | Primitive/leaf data definitions. |
| `DataDefinitionNormalizer` (fallback) | 5 | Any data definition not matched above. |

Each `supportsNormalization($data, $format)` checks `$format === 'schema_json'` plus the data
definition type, and `normalize()` returns the JSON Schema array for that piece.

## Add or override a type's schema

1. Create a normalizer class (extend the closest shipped one, e.g. `DataDefinitionNormalizer`).
2. Restrict it to `$format === 'schema_json'` and to your data-definition type in
   `supportsNormalization()`.
3. Register it as a service tagged `{ name: normalizer, priority: N }` with **N higher** than the
   normalizer you want to beat (e.g. `> 10` to override a primitive, `> 5` to beat the fallback).

```yaml
# mymodule.services.yml
services:
  serializer.normalizer.data_definition.schema_json.duration:
    class: Drupal\mymodule\Normalizer\DurationSchemaNormalizer
    tags:
      - { name: normalizer, priority: 15 }
```

## StaticDataDefinitionExtractor

Service `jsonapi_schema.static_data_definition_extractor` (`src/StaticDataDefinitionExtractor.php`,
args `@typed_data_manager`, `@config.typed`, `@entity_field.manager`) resolves a field's data
definition for a bundle without loading a real entity — call `extractField($entity_type, $bundle,
$field_name)` if you build schema outside the controller.

## Hypermedia links

`src/Plugin/jsonapi_hypermedia/LinkProvider/*` add schema `targetSchema` links to JSON:API responses
when the optional `jsonapi_hypermedia` module is installed — no code needed beyond enabling it.
