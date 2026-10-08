# Field-mapping plugins (`salesforce_mapping_field`)

Each entry in a mapping's `field_mappings` is a **SalesforceMappingField** plugin instance
that describes how one Drupal value maps to one Salesforce field.

## Plugin type

- Manager: `plugin.manager.salesforce_mapping_field`
  (`SalesforceMappingFieldPluginManager`), annotation `@SalesforceMappingField`.
- Discovery: `src/Plugin/SalesforceMappingField/`.

## Shipped plugins

| id | Purpose |
|---|---|
| `properties` | Map a Drupal field/property to a Salesforce field (the common case). |
| `properties_extended` | Like `properties` but with extended/typed-data handling for complex fields. |
| `record_type` | Map the Salesforce **record type**. |
| `broken` | Placeholder when a referenced field is unavailable (keeps the mapping loadable). |

`salesforce_webform` adds field plugins for webform elements (`WebformElements`,
`WebformEntityElements`); `salesforce_example` adds a `Hardcoded` plugin (constant value).

## Shape of a field_mappings entry

```php
'field_mappings' => [
  [
    'drupal_field_type' => 'properties',                // the plugin id
    'drupal_field_value' => 'mail',                     // Drupal field/property
    'salesforce_field' => 'Email',                      // Salesforce field
    'direction' => 'sync',                              // sync | drupal_sf | sf_drupal
    // plugin-specific keys...
  ],
];
```
`direction` controls which way this field flows: `drupal_sf` (push only), `sf_drupal` (pull
only), or `sync` (both).

## Implement a custom field plugin

```php
namespace Drupal\my_module\Plugin\SalesforceMappingField;

use Drupal\salesforce_mapping\SalesforceMappingFieldPluginBase;

/**
 * @SalesforceMappingField(
 *   id = "my_transform",
 *   label = @Translation("My transform")
 * )
 */
class MyTransform extends SalesforceMappingFieldPluginBase {
  public function value($entity, $mapping) { /* return the SF value */ }
}
```

Field plugins are selected per row when building a mapping in `salesforce_mapping_ui`.
