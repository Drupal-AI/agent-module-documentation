<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The autocomplete-with-override widget

No settings page. You use the submodule by choosing its widget on an
`entity_reference_entity_modify` field's *Manage form display*.

## Widget `entity_reference_autocomplete_with_override`

- Label: "Autocomplete (with override)".
- `field_types: [entity_reference_entity_modify]` — only offered on the parent module's
  modify field type.
- Extends core `EntityReferenceAutocompleteWidget`: renders the normal autocomplete element,
  then appends the override element/button via
  `EntityReferenceOverrideService::formElement($items, $delta, $element, $form, $form_state, $this->getSetting('form_mode'))`.
- Setting `form_mode` (default `default`) — the form mode used by the override modal. Config
  schema: `field.widget.settings.entity_reference_autocomplete_with_override` (extends
  `field.widget.settings.entity_reference_autocomplete` + a `form_mode` string).

## Set it via API

```php
// Field must be of type entity_reference_entity_modify (can target any entity type):
FieldStorageConfig::create([
  'field_name' => 'field_ref_ctx', 'entity_type' => 'node',
  'type' => 'entity_reference_entity_modify', 'settings' => ['target_type' => 'node'],
])->save();
FieldConfig::create([
  'field_name' => 'field_ref_ctx', 'entity_type' => 'node',
  'bundle' => 'article', 'label' => 'Contextual reference',
])->save();

$fd = \Drupal::service('entity_display.repository')->getFormDisplay('node', 'article', 'default');
$fd->setComponent('field_ref_ctx', [
  'type' => 'entity_reference_autocomplete_with_override',
  'settings' => ['form_mode' => 'default'],
])->save();
```

Read back: `drush cget core.entity_form_display.node.article.default content.field_ref_ctx`.

## Notes

- `hook_field_widget_info_alter()` also lists a legacy `entity_reference_entity_override`
  field-type id on some core widgets; the working field type is
  `entity_reference_entity_modify` (from the parent module).
- Everything about how overrides are stored (`overwritten_property_map`), applied at render
  time, and the read-only save guard is in the parent module — see its
  `agent/api/service.md`.
