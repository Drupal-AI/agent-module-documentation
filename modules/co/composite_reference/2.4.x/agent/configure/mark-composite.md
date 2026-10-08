<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Marking a reference field composite

## Configurable (bundle) fields — UI
On the field settings form (`field_config_edit_form`) of any `entity_reference` or
`entity_reference_revisions` field, the module adds a **Composite reference** details group:
- **Composite field** (`composite`) — enable cascade deletion of referenced entities.
- **Include past revisions** (`composite_revisions`) — only shown for
  `entity_reference_revisions`, and only visible when *Composite field* is checked; also deletes
  entities that were referenced only in older revisions.

Values are saved as **third-party settings** on the `FieldConfig` via an `#entity_builders`
callback: `composite_reference.composite` and `composite_reference.composite_revisions`. If
*Composite field* is unchecked, `composite_revisions` is forced to `FALSE`.

Set via Drush/config instead of the UI:
```php
$field_config
  ->setThirdPartySetting('composite_reference', 'composite', TRUE)
  ->setThirdPartySetting('composite_reference', 'composite_revisions', FALSE)
  ->save();
```

## Base fields — code
Add a `composite_reference` setting to the field definition:
```php
$fields['my_ref'] = BaseFieldDefinition::create('entity_reference')
  ->setSettings([
    'target_type' => 'node',
    'composite_reference' => TRUE,               // or ['composite' => TRUE, 'composite_revisions' => TRUE]
  ]);
```
When the base field is overridden per bundle, `composite_reference_base_field_override_presave()`
copies the `composite` / `composite_revisions` values from the item definition into the
`BaseFieldOverride`'s third-party settings so the exported config keeps working. (`composite_revisions`
is only retained when the field type is `entity_reference_revisions`.)

## Config schema (`config/schema/composite_reference.schema.yml`)
Type `composite_reference.settings` (`composite: boolean`, `composite_revisions: boolean`) is mapped
onto:
- `field.field.*.*.*.third_party.composite_reference`
- `core.base_field_override.*.*.*.third_party.composite_reference`

## Applicability
Only `entity_reference` and `entity_reference_revisions` field types are eligible; other field types
are ignored by both the form alter and the deletion logic.
