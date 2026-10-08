# Mechanism

Two hooks in `epp.module`. No services, no plugins, no API for you to extend — you drive it
entirely through the `epp.value` / `epp.on_update` third-party settings on fields.

## `epp_form_alter()` — the settings UI

Fires only for form ids `field_config_edit_form` and `base_field_override_edit_form`. Adds the
"Entity Prepopulate" fieldset (Value textarea + "Also on update" checkbox, plus a token-tree link
when the Token module exists) and registers an entity builder `epp_field_config_form_builder()`
that **unsets** both settings if both submitted values are empty (so no empty epp keys are stored).

## `epp_entity_prepare_form()` — applying the value

Implements `hook_entity_prepare_form()`. For a `FieldableEntityInterface`, it loops the entity's
fields and, for each field whose definition carries `epp.value`, applies the value **only when all**
of these hold:

1. The field definition is a `ThirdPartySettingsInterface` and `epp.value` is non-empty.
2. The current user has `edit` access to the field (`$field->access('edit')`).
3. The entity **is new**, OR the field's `epp.on_update` third-party setting is TRUE.

Then the value is resolved and set:

- Token replacement is run **twice** on the YAML string: once normally, once with `clear => TRUE`
  (unresolved tokens blanked). The value is applied **only if the two results are identical** — i.e.
  every token resolved. If any token could not be replaced, the field is left untouched.
- The resolved string is parsed as **YAML** (`Symfony\Component\Yaml\Parser`, with
  `PARSE_EXCEPTION_ON_INVALID_TYPE`); a parse error is logged as a warning. This is what lets a
  value target multiple field properties.
- The parsed value is set on the entity, then `$entity->validate()` is run for that field. **If the
  field's constraints are violated the previous value is restored** and each violation is logged as
  a notice under the `epp` logger channel.

## Consequences / gotchas

- Safe by design: a value with an unresolvable token, or one that fails validation, is silently not
  applied (nothing is force-written).
- `langcode` for token replacement is taken from the field's langcode.
- Because it runs at prepare-form time on the entity, it works for any entity form and any field
  type, including multi-property fields — the differentiator from the form-only Prepopulate module.
- Token data context is currently empty (`$data = []`), so use global/context-free tokens
  (`current-date`, `current-user`, site tokens). There is no per-entity token context passed in.
