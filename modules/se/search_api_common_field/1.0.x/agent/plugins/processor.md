<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `common_field` processor and `CommonFieldProperty`

The module does **not** define a new Search API plugin *type*; it provides one processor
plugin for the existing `search_api_processor` type, plus a configurable property class.

## Processor: `common_field`

`Drupal\search_api_common_field\Plugin\search_api\processor\CommonField`

```php
@SearchApiProcessor(
  id = "common_field",
  label = "Common fields",
  description = "Merges properties with the same name on different datasources.",
  stages = { "add_properties" = 20 },
  locked = true,     // cannot be removed while a common field is configured
  hidden = true,     // not shown on the Processors tab; enabled via Add fields
)
```

- `getPropertyDefinitions(NULL)` (datasource-independent, `$datasource === NULL`) exposes one
  property, `common_field`, of type `string`, wrapped in a `CommonFieldProperty`. This is why
  the field appears under the "General"/datasource-independent group on *Add fields*.
- `addFieldValues(ItemInterface $item)` runs in the `add_properties` stage (weight 20). For
  every configured field of type `common_field`, it reads that field's
  `configuration['property_name']`, builds a `$required_properties` map filling **every
  datasource id** with `[property_name => property_name]`, then uses the Search API fields
  helper `extractItemValues()` to pull the value from whichever datasource the current item
  actually belongs to, and calls `$common_field->addValue()` for each extracted value.
  Only the item's own datasource yields a value, so items from any datasource populate the
  same field.

## Property: `CommonFieldProperty`

`...\processor\Property\CommonFieldProperty` extends `ConfigurablePropertyBase`.

- `defaultConfiguration()` → `['property_name' => NULL]`.
- `buildConfigurationForm()` scans every datasource's property definitions, keeps only
  property paths that appear on **more than one** datasource, and renders a required
  `radios` element `property_name` listing each candidate with the datasources it is used in.

## Implications for agents

- To add a common field, write/modify the index config (see
  [../configure/common-field.md](../configure/common-field.md)); the processor turns on
  automatically because it is referenced by the field.
- Because the processor is `locked`, it stays enabled as long as a common field exists;
  remove the field to allow removing the processor.
- The merge only works if the source `property_name` truly exists on 2+ datasources — the
  form enforces this, but programmatic config does not.
