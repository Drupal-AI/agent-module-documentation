# Configure Autofill on a field

No global settings — configured per field on **Manage form display**
(`admin/structure/…/form-display`):

1. Open the target field's widget **settings (cog)**. The field must be a `string` (plain text)
   field for the options to appear.
2. Tick **Enable Autofill from another field** (disabled if the form has no other eligible
   `string` field).
3. Choose the **Autofill source field** from the select.
4. Update / Save. The form-display summary then shows `Autofill from: <source_field>`.

## What powers the form

- `hook_field_widget_third_party_settings_form()` adds the checkbox (`enabled`) and select
  (`source_field`) to widgets whose `$field_definition->getType() === 'string'`.
- `_autofill_get_available_source_fields_as_options($form, $current_field_name)` builds the
  option list: all `string`-typed field storage definitions on the entity type, excluding the
  current field, intersected with the fields actually on this form (`$form['#fields']`), labelled
  from their `field_config` where available.
- `hook_field_widget_settings_summary_alter()` appends the "Autofill from: …" summary line.

## Where the settings are stored

Third-party settings on the form-display component, provider `autofill`:

```yaml
# core.entity_form_display.<entity>.<bundle>.<mode>
content:
  <target_field>:
    third_party_settings:
      autofill:
        enabled: true
        source_field: <source_field_machine_name>
```

Config schema: `field.widget.third_party.autofill` (`enabled` bool, `source_field` string).

## Runtime attach + JS behavior

`hook_field_widget_single_element_form_alter()` — when a widget has `enabled` + `source_field`:

```php
$element['#attached']['library'][] = 'autofill/autofill';
$element['#attached']['drupalSettings']['autofill']['field_mapping'][$fieldName] = $source_field;
```

`js/autofill.js` (`Drupal.behaviors.autofillFromAnotherField`, uses `core/once`), per
`field_mapping[target] = source`:
- Targets single-value inputs `[name="<field>[0][value]"]` for both source and target; bails if
  either is absent.
- If, at attach time, the source is empty **or** equals the target: binds `input` on the source
  to copy its value into the target and dispatch an `input` event on the target (so behaviors
  like the maxlength counter refresh).
- If the source already differs from the target at load: marks the target as "manipulated" and
  does **not** autofill.
- A `keypress` on the target sets the "manipulated" flag, permanently stopping autofill for that
  target — manual edits are never overwritten.

## Limitations
- Single-value `string` fields only (multi-value / non-string widgets are not wired).
- Copy is one-directional (source → target) and initial-entry oriented.
