<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & programmatic API

## `custom_field.update_manager` (UpdateManagerInterface)

Add or drop a **column on a Custom Field that already holds data**, updating both the field
storage config and the live database table safely. Call it from an `hook_update_N()` or a
throwaway script. This is what the Drush commands wrap ([../drush/updater.md](../drush/updater.md)).

```php
$um = \Drupal::service('custom_field.update_manager');   // or Drupal\custom_field\Service\UpdateManagerInterface

// Add one column:
$um->addColumn('node', 'field_spec', 'subtitle', 'string', ['max_length' => 255]);

// Add several at once:
$um->addExtraColumns('node', 'field_spec', [
  'subtitle' => ['name' => 'subtitle', 'type' => 'string', 'max_length' => 255],
]);

// Remove a column (drops its DB column and its data):
$um->removeColumn('node', 'field_spec', 'rank');
```

Signatures:
- `addColumn(string $entity_type_id, string $field_name, string $new_property, string $data_type, array $options = []): void`
- `addExtraColumns(string $entity_type_id, string $field_name, array $extra_columns): void`
- `removeColumn(string $entity_type_id, string $field_name, string $property): void`

## `custom_field.generate_data` (GenerateDataInterface)

Generate sample/default column data — used by devel-generate style flows and the widget.
- `generateFieldData(array $settings, string $target_entity_type): array`
- `generateSampleFormData(FieldDefinitionInterface $field, ?array $deltas = NULL): array`

## `custom_field.tag_manager` (TagManager)

Discovers the allowed HTML tag sets used by text-style columns (cached plugin discovery over
`*.custom_field_tags.yml`, e.g. the module's own `custom_field.custom_field_tags.yml`).

## `plugin.manager.custom_field_link_attributes` (LinkAttributesManager)

Discovers link attribute options declared in `*.custom_field_link_attributes.yml` files
(the module ships `custom_field.custom_field_link_attributes.yml`) for the `link` subfield's
attribute UI.

## Plugin managers (to enumerate/instantiate subfield plugins)

`plugin.manager.custom_field_type`, `…_widget`, `…_formatter`, `…_feeds`,
`…_component_prop_widget`. Example — list every subfield type id:

```php
array_keys(\Drupal::service('plugin.manager.custom_field_type')->getDefinitions());
```
