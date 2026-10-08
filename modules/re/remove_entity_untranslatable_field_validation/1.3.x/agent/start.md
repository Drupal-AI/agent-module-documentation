# Remove Entity Untranslatable Field Validation — agent index

Enabling this module removes Drupal core's **`EntityUntranslatableFields`** validation
constraint from **every** entity type, so untranslatable fields can be edited on a
non-default translation without a validation error. It is a single
`hook_entity_type_alter()` — no settings form (`configure: null`), no config, no schema,
no permissions, no Drush. Its entire behaviour is "on when enabled, off when disabled".

- **The hook, the service/method, exactly which constraint is removed, and the trade-off** →
  [api/mechanism.md](api/mechanism.md)

Key facts: the constraint id removed is `EntityUntranslatableFields`; the work is done by
service `remove_entity_untranslatable_field_validation.entity_modifier`
(`EntityModifier::removeUntranslatableEntityFieldValidation(array &$entityTypes)`), called from
`remove_entity_untranslatable_field_validation_entity_type_alter()`. You can confirm it is
active by checking that a translatable entity type (e.g. `node`) no longer lists
`EntityUntranslatableFields` in its constraints.
