# Configuring the reference validators

There is **no admin settings page and no `configure` route**. Everything is per entity-reference
field, stored as third-party settings on the `FieldConfig`.

## In the UI

1. Go to the field's edit form: *Structure → Content types → (bundle) → Manage fields → (an
   Entity reference field) → Edit* (route `entity.field_config.<entity>_field_edit_form`).
2. The module adds a **"Reference validators"** details fieldset (`entity_reference_validators_form_field_config_edit_form_alter()`), with:
   - **Prevent circular references** — checkbox `circular_reference`.
   - **Recursively check circular references** — checkbox `circular_reference_deep` (only usable when the first box is on; kept in sync by an element validate callback).
   - **Prevent entity from referencing duplicates** — checkbox `duplicate_reference`.
3. The two circular-reference checkboxes are only shown (`#access`) when the field's **target
   entity type equals the host entity type** — e.g. a *node* field that targets *nodes*. Duplicate
   prevention is always available on any entity_reference field.

## Where it is stored (config)

Config object `field.field.<entity_type>.<bundle>.<field_name>`:

```yaml
third_party_settings:
  entity_reference_validators:
    circular_reference: true
    circular_reference_deep: false   # optional deep/recursive walk
    duplicate_reference: true
```

Schema key: `field.field.*.*.*.third_party.entity_reference_validators` (all three are booleans).

## Setting it programmatically

```php
$field = \Drupal\field\Entity\FieldConfig::loadByName('node', 'article', 'field_related');
$field->setThirdPartySetting('entity_reference_validators', 'circular_reference', TRUE);
$field->setThirdPartySetting('entity_reference_validators', 'circular_reference_deep', TRUE);
$field->setThirdPartySetting('entity_reference_validators', 'duplicate_reference', TRUE);
$field->save();
```

Setting the third-party value is all that is needed — `hook_entity_bundle_field_info_alter()` reads
it on the next field-info build and attaches the constraint. Deleting the field or the setting
removes the validator; no cache clear beyond the normal field-definition invalidation is required.
