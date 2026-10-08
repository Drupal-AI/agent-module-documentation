# Field mapping plugin type

Webform Content Creator defines a **plugin type** for mapping a webform value onto a target entity
field. Each mapping in a config entity's `elements` names a plugin by id.

## The type

- Manager: `plugin.manager.webform_content_creator.field_mapping`
  (`Plugin\WebformContentCreatorFieldMappingManager`, extends `DefaultPluginManager`).
- Directory / namespace: `src/Plugin/WebformContentCreator/FieldMapping`.
- Annotation: `@WebformContentCreatorFieldMapping` (`Annotation\WebformContentCreatorFieldMapping`)
  with `id`, `label`, `weight`, and `field_types` (array of field types the mapper supports;
  empty = all).
- Interface `Plugin\FieldMappingInterface`, base class `Plugin\FieldMappingBase`.
- Alter hook id: `webform_content_creator_info`.

The manager picks a plugin for a field type with `getFieldMappings($field_type)` (definitions whose
`field_types` include it, or are empty) and `getPlugin($plugin_id = 'default_mapping')`.

## Provided plugins (ids)

`default_mapping` (fallback, `field_types = {}` → any field), plus type-specific:
`text_mapping`, `numeric_mapping`, `boolean_mapping`, `email_mapping`, `datetime_mapping`,
`entity_reference_mapping`, `link_mapping`, `address_mapping`, `office_hours_mapping`,
`social_media_links_mapping`. (Enumerate live with the manager's `getDefinitions()`.)

## Interface (what a mapper implements)

`FieldMappingInterface` (extends `PluginInspectionInterface`):

- `supportsCustomFields()` — whether the mapper allows a custom token value.
- `getEntityComponentFields(FieldDefinitionInterface $field_definition)` — the component fields
  that make up the field (e.g. address subfields).
- `getSupportedWebformFields($webform_id)` — webform elements this mapper can consume.
- `mapEntityField(ContentEntityInterface &$content, array $webform_element,
  FieldDefinitionInterface $field_definition, array $data = [], array $attributes = [])` — set the
  target field value on `$content` from the submission `$data`.

Useful constants on the interface group webform element types:
`WEBFORM_OPTIONS_ELEMENTS`, `WEBFORM_ENTIY_REFERENCE_ELEMENTS`, `WEBFORM_TEXT_ELEMENTS`.

## Add your own

Create `src/Plugin/WebformContentCreator/FieldMapping/MyMapping.php`:

```php
/**
 * @WebformContentCreatorFieldMapping(
 *   id = "my_mapping",
 *   label = @Translation("My mapping"),
 *   weight = 0,
 *   field_types = {"my_field_type"},
 * )
 */
class MyMapping extends FieldMappingBase {
  public function mapEntityField(ContentEntityInterface &$content, array $webform_element, FieldDefinitionInterface $field_definition, array $data = [], array $attributes = []) {
    // Set $content->set($field_definition->getName(), ...) from $data.
    return parent::mapEntityField($content, $webform_element, $field_definition, $data);
  }
}
```

It then appears as a mapping option for its `field_types` on the Manage fields form, and its id is
stored as the `mapping` value in the config entity's `elements`.
