# TypeMapper plugins

TypeMappers translate a single Drupal Typed Data type into its JSON Schema representation.
The parent Schemata module produces an abstract schema; the normalizers in this submodule
walk each property and ask a TypeMapper how to render its type.

## Plugin type

- **Manager service:** `plugin.manager.schemata_json_schema.type_mapper`
  (`Drupal\schemata_json_schema\Plugin\Type\TypeMapperPluginManager`).
- **Discovery:** classes in `Plugin/schemata_json_schema/type_mapper/` of any module.
- **Annotation:** `@TypeMapper(id = "...")` (`Drupal\schemata_json_schema\Annotation\TypeMapper`).
- **Interface:** `TypeMapperInterface` — one method `getMappedValue(DataDefinitionInterface $property): mixed`.
- **Base class:** `TypeMapperBase` (extends `PluginBase`, implements
  `ContainerFactoryPluginInterface`). Its `getMappedValue()` returns
  `['type' => <plugin id>]` plus `title` (from the property label) and `description` (from
  the property description, tag-stripped and slash-escaped).
- **Alter hook:** `hook_json_schema_type_mapper_alter()` (alter id `json_schema_type_mapper`).
- **Fallback:** the manager implements `FallbackPluginManagerInterface`; any type without a
  dedicated mapper is routed to the `fallback` plugin.

## Shipped mappers (plugin id → behavior)

| id | Output |
|---|---|
| `email` | `type: string`, `format: email` |
| `datetime_iso8601` | ISO 8601 date-time mapping |
| `timestamp` | timestamp mapping |
| `filter_format` | filter_format mapping |
| `entity_reference` | `type: object` |
| `fallback` | `type` = the property's raw `getDataType()` |

Note: an *empty* subclass of `TypeMapperBase` uses its **plugin id** as the JSON Schema
`type`; the `fallback` plugin instead uses the property's actual data type.

## Add a custom TypeMapper

Place this in `your_module/src/Plugin/schemata_json_schema/type_mapper/DurationTypeMapper.php`:

```php
namespace Drupal\your_module\Plugin\schemata_json_schema\type_mapper;

use Drupal\Core\TypedData\DataDefinitionInterface;
use Drupal\schemata_json_schema\Plugin\schemata_json_schema\type_mapper\TypeMapperBase;

/**
 * @TypeMapper(
 *   id = "duration"
 * )
 */
class DurationTypeMapper extends TypeMapperBase {

  public function getMappedValue(DataDefinitionInterface $property) {
    $value = parent::getMappedValue($property);
    $value['type'] = 'string';
    $value['format'] = 'duration';
    return $value;
  }

}
```

The `id` must match the Drupal Typed Data type you are mapping. Rebuild caches
(`drush cr`) after adding the plugin. If a dependency is needed, override
`TypeMapperBase::create()` to inject services.
