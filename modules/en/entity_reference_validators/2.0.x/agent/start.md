# Entity Reference validators — agent index

Adds two opt-in validators to `entity_reference` fields via per-field third-party settings. No
config UI page, no configure route (`configure: null`), no plugin types, no Drush, no permissions.
Persistent state is `field.field.<entity>.<bundle>.<field>` →
`third_party_settings.entity_reference_validators.{circular_reference,circular_reference_deep,duplicate_reference}`.

- **Turn the validators on for a field / where the settings live / the UI checkboxes** →
  [configure/validators.md](configure/validators.md)
- **How the constraints work (`CircularReference`, `DuplicateReference`) and when they fire** →
  [api/constraints.md](api/constraints.md)

Key facts: the "Prevent circular references" / "Recursively check" checkboxes only appear when the
field's target entity type equals the host entity type. Ticking a box makes
`hook_entity_bundle_field_info_alter()` call `$field->addConstraint('CircularReference', ['deep' => …])`
or `addConstraint('DuplicateReference')`, so core's Typed Data validation enforces it on save and on
the entity form.
