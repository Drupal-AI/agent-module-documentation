# `field_type_export` plugin type

Each field is rendered to CSV by a **`field_type_export`** plugin. This is the extension
point: to support a new/contrib field type or override how one exports, add a plugin.

- Manager service: `plugin.manager.field_type_export` (class `FieldTypeExportManager`,
  extends `DefaultPluginManager`).
- Plugin namespace: `Drupal\<module>\Plugin\FieldTypeExport\` (subdir `Plugin/FieldTypeExport`).
- Annotation: `@FieldTypeExport` (`Drupal\entity_export_csv\Annotation\FieldTypeExport`).
- Interface: `FieldTypeExportInterface`; base class: `FieldTypeExportBase`.
- Alter hook: `hook_entity_export_csv_field_type_export_info_alter()`.
- Fallback plugin id: `broken`.

## Annotation keys

```php
/**
 * @FieldTypeExport(
 *   id = "my_field_export",
 *   label = @Translation("My field export"),
 *   description = @Translation("..."),
 *   weight = 0,
 *   field_type = { "my_field_type" },   // REQUIRED: field type ids this handles ({} = any)
 *   entity_type = {},                    // limit to entity type ids ({} = any)
 *   bundle = {},                         // limit to bundles ({} = any)
 *   field_name = {},                     // limit to specific field machine names ({} = any)
 *   exclusive = FALSE,                   // TRUE = the only exporter offered for the match
 * )
 */
```

Selection logic (`FieldTypeExportManager::getFieldTypeOptions`): definitions are sorted by
`weight` **ascending**; a plugin matches when the field type is in its `field_type` (or
`field_type` is empty) and any declared `entity_type` / `bundle` / `field_name` constraints
are satisfied. If a matching plugin has `exclusive = TRUE`, it becomes the *only* option. The
default fallback is `default_export` (weight 100) which extracts a property's raw value.

## Built-in exporters

`default_export` (weight 100, any field), `address_export`, `entity_reference_export`,
`file_export`, `link_export`, `datetime_export`, `daterange_export`, `timestamp_export`,
`list_export`, `geolocation_export`.

## Implementing one

Extend `FieldTypeExportBase` and override the methods you need — most importantly
`massageExportPropertyValue(FieldItemInterface $field_item, $property_name, $field_definition, $options)`
which formats a single property value. Other overridable hooks: `getSummary()`,
`buildConfigurationForm()` (expose extra per-field options), `getColumns()` / `getHeaders()`
(control column layout for multi-value / multi-property fields), `getFieldProperties()`,
`defaultConfiguration()`. The base already implements `export()` (iterating field items and
properties) and single-column-vs-separate-column flattening driven by the saved
`form.options` (`property`, `property_separator`, `property_separate_column`).
