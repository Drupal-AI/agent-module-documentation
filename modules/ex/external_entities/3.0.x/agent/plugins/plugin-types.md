# Plugin types (5) and how to add plugins

`external_entities.plugin_type.yml` declares five plugin types. Each has a manager service, an
annotation class in `Drupal\external_entities\Annotation`, a discovery subdirectory
`Plugin/ExternalEntities/<Type>`, an interface, and a base class you extend.

| Type | Manager service | Annotation | Subdir | Base class / interface |
|---|---|---|---|---|
| Storage client | `plugin.manager.external_entities.storage_client` | `@StorageClient` | `Plugin/ExternalEntities/StorageClient` | `StorageClient\StorageClientBase` / `StorageClientInterface` |
| Data aggregator | `plugin.manager.external_entities.data_aggregator` | `@DataAggregator` | `Plugin/ExternalEntities/DataAggregator` | `DataAggregator\DataAggregatorBase` / `DataAggregatorInterface` |
| Field mapper | `plugin.manager.external_entities.field_mapper` | `@FieldMapper` | `Plugin/ExternalEntities/FieldMapper` | `FieldMapper\FieldMapperBase` / `FieldMapperInterface` |
| Property mapper | `plugin.manager.external_entities.property_mapper` | `@PropertyMapper` | `Plugin/ExternalEntities/PropertyMapper` | `PropertyMapper\PropertyMapperBase` / `PropertyMapperInterface` |
| Data processor | `plugin.manager.external_entities.data_processor` | `@DataProcessor` | `Plugin/ExternalEntities/DataProcessor` | `DataProcessor\DataProcessorBase` / `DataProcessorInterface` |

The storage-client manager implements `FallbackPluginManagerInterface` (missing plugin → falls back
to `DataAggregatorBase::DEFAULT_STORAGE_CLIENT` with a warning). Alter hooks:
`hook_external_entities_storage_client_info_alter` (and equivalents per type). The `plugin_type.yml`
decorator class references the contrib `drupal/plugin` module but the managers work without it.

## Native plugins shipped by the parent

- **Storage clients**: `rest`, `jsonapi`, `files`. (`sql` is in `xnttsql`.)
- **Data aggregators**: `single` (Single storage client), `group` (Group Aggregator),
  `horizontal`, `vertical`.
- **Field mappers**: `generic` (Generic), `text` (Text field). (`file` is in `xntt_file_field`.)
- **Property mappers**: `constant` (Constant), `direct` (Field), `simple` (Simple), `jsonpath`
  (JSONPath), `pattern` (Pattern), `conditional` (Conditional mapping), `multi` (Multiple mapping).
- **Data processors**: `default` (Auto-detect datatype), `boolean`, `datetime`, `hash`, `numeric`,
  `numericunit`, `stringcase`, `mapping` (Value mapping), `filter` (Value filtering),
  `readonly` (Read-only), `version`.

## Add a storage client

```php
namespace Drupal\my_module\Plugin\ExternalEntities\StorageClient;

use Drupal\external_entities\StorageClient\StorageClientBase;

/**
 * @StorageClient(
 *   id = "my_client",
 *   label = @Translation("My client"),
 *   description = @Translation("Reads my source.")
 * )
 */
class MyClient extends StorageClientBase {
  // Implement at least: querySource(), and typically load()/loadMultiple().
  // save()/delete() enable write; countQuerySource()/isCountable() enable paging/counts.
  // Override defaultConfiguration() + buildConfigurationForm()/submitConfigurationForm() for the UI.
}
```

`StorageClientInterface` methods: `load`, `loadMultiple`, `save`, `delete`, `query`, `querySource`,
`countQuery`, `countQuerySource`, `isCountable`, `transliterateDrupalFilters`,
`transliterateDrupalSorts`, `getRequestedDrupalFields`, `getRequestedMapping`. Existing base
classes to extend for specific sources: `RestClient` (web services), `FileClientBase` (files),
`QueryLanguageClientBase` (SQL/query languages — used by `xnttsql`).

## Add a field mapper / property mapper / data processor

Same recipe with the matching annotation, subdirectory, and base class. Field mappers expose per-field
config through property mappers; property mappers chain data processors. A field mapper that supports
writing back returns `TRUE` from `couldReverseFieldMapping()` and implements value extraction.
