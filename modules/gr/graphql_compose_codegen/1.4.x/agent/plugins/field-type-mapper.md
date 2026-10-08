<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin type: field-type mapper

Maps a Drupal field type plugin ID to the TypeScript type string used in generated output. This is the
extension point for custom field types — register a plugin instead of patching the module.

## Wiring
- Manager: `\Drupal\graphql_compose_codegen\PluginManager\FieldTypeMapperManager`
  (`plugin.manager.graphql_compose_codegen.field_type_mapper`). Discovery dir `Plugin/FieldTypeMapper`,
  cache `graphql_compose_codegen_field_type_mappers`, alter hook
  `graphql_compose_codegen_field_type_mappers`.
- Attribute: `#[\Drupal\graphql_compose_codegen\Attribute\FieldTypeMapper(id: '…', drupalTypes: ['…'])]`
  (`drupalTypes` must be non-empty).
- Interface: `FieldTypeMapperInterface::map(FieldDefinitionInterface): string`.
- Base class: `FieldTypeMapperBase` — implement `getBaseTsType()`; the base appends `[]` for multi-value
  (cardinality unlimited or > 1). `SchemaInspector::mapFieldType()` calls `manager->mapDefinition()`, which
  indexes `drupalTypes → plugin id` (**last plugin wins** per type) and returns `'unknown'` if no plugin
  claims the type.

## Implement one
```php
#[FieldTypeMapper(id: 'my_color', drupalTypes: ['color_field_type'])]
final class ColorMapper extends FieldTypeMapperBase {
  protected function getBaseTsType(FieldDefinitionInterface $definition): string {
    return 'string';
  }
}
```

## Built-in mappers (`src/Plugin/FieldTypeMapper/`)
| Plugin | Drupal types | TS type |
|---|---|---|
| `TextMapper` | text, text_long, text_with_summary → `ProcessedText`; string/… → `string` | `ProcessedText` / `string` |
| `NumericMapper` | boolean, integer, float, decimal, list_integer, list_float | `boolean` / `number` |
| `DateMapper` | datetime, timestamp, created, changed, smartdate | date / `SmartDate` |
| `LinkMapper` | link | `Link` |
| `MediaMapper` | image, file | `Image` / media type |
| `EntityReferenceMapper` | entity_reference, entity_reference_revisions | `TaxonomyTermRef`, `Author`, `DrupalMedia`, `RelatedNode`, `DrupalParagraph[]` by target type |
| `WebformMapper` | webform | `DrupalWebform` |
| `OtherMapper` | address, geolocation, range_integer, range_float | `object` |

Override a built-in via `hook_graphql_compose_codegen_field_type_mappers_alter(&$definitions)` (see
[../hooks/hooks.md](../hooks/hooks.md)).
