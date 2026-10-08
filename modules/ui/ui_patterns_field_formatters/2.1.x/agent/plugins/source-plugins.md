<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Patterns source plugins (field property sources)

The module does **not** define a plugin type. It provides two plugin instances for the UI Patterns
1.x source manager (`plugin.manager.ui_patterns_source`, annotation `@UiPatternsSource`, base
`Drupal\ui_patterns\Plugin\PatternSourceBase`). Both are tagged `field_properties`, which is the tag
the field formatters pass to `PatternDisplayFormTrait::buildPatternDisplayForm(..., 'field_properties',
...)` — so these are exactly the sources you can map onto pattern fields when using
`pattern_all_formatter` / `pattern_each_formatter` (see [../fields/formatters.md](../fields/formatters.md)).

| Source id | Class | Provides (source fields) |
|---|---|---|
| `field_meta_properties` | `FieldMetaPropertiesSource` | `_label` (field label); `_field_display_label` (only if `field_display_label` is enabled); `_entity_form_field_label` (only if `entity_form_field_label` is enabled); `_formatted` (the field rendered through its wrapped formatter) |
| `field_raw_properties` | `FieldRawPropertiesSource` | One entry per raw field property (e.g. `value`, `uri`, `title`, `target_id`, `alt`…), from the field storage definition's property names |

## How each builds its list

- `FieldMetaPropertiesSource::getSourceFields()` returns fixed meta sources, gating the two
  optional labels on `moduleHandler->moduleExists(...)`. It implements
  `ContainerFactoryPluginInterface` only to inject `module_handler`.
- `FieldRawPropertiesSource::getSourceFields()` reads `storageDefinition` from the plugin context,
  iterates `getPropertyNames()`, and (when the context `limit` array is set) keeps only properties
  in `limit`. The formatter passes `limit => $field_storage_definition->getPropertyNames()`, i.e. all
  properties of that field. Each entry's label comes from
  `getPropertyDefinition($field)->getLabel()`.

These `plugin`/`source` pairs are stored in each formatter's `pattern_mapping` (schema keys
`plugin` + `source`) and consumed at render time by `viewElements()`.

## Add your own field-property source

Drop a plugin in `Plugin/UiPatterns/Source/`, tag it `field_properties`, and it becomes selectable
in the pattern mapping table of both formatters:

```php
namespace Drupal\my_module\Plugin\UiPatterns\Source;

use Drupal\ui_patterns\Plugin\PatternSourceBase;

/**
 * @UiPatternsSource(
 *   id = "my_field_source",
 *   label = @Translation("My field source"),
 *   tags = { "field_properties" }
 * )
 */
class MyFieldSource extends PatternSourceBase {
  public function getSourceFields() {
    return [ $this->getSourceField('my_key', 'My label') ];
  }
}
```

To actually emit a value for a custom `source`, the formatter's `viewElements()` would need to know
about it; the two shipped sources (`field_meta_properties`, `field_raw_properties`) are the ones
`PatternOneForAllFormatter`/`PatternOneForEachFormatter` handle directly.
