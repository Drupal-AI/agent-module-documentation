<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a dependent field

No global settings page. A field is made "dependent" from its own field-settings form.

## Install
`drush en dependent_list` (pulls in core `options` + `field_ui`). Nothing else to enable; the module is pure field/form behaviour.

## Where the UI lives
`dependent_list_form_field_config_edit_form_alter()` (in `dependent_list.module`) alters the core `field_config_edit_form`. It only adds UI when:
- the field type is `list_string` / `list_integer` / `list_float`, and
- the bundle has at least one **other** list field to depend on (`_dependent_list_get_bundle_list_fields()`).

It adds a `details` element `third_party_settings[dependent_list]` ("Dependent list configuration") with:
- `parent_field` — a select of the bundle's other list fields (label `[machine_name]`), with an `#ajax` callback `dependent_list_value_map_ajax_callback` that rebuilds the wrapper `dependent-list-value-map-wrapper`.
- `value_map` — a `#type => table`, one row per **parent** allowed value; each row holds a `checkboxes` element of the **child** field's allowed values (`options_allowed_values()` on the child storage, `asort`-ed). Checking a box means "show this child option when the parent has this value".

Editing the child field: **Structure -> Content types -> [type] -> Manage fields -> [child field] -> Dependent list configuration.** Pick the dependency field, tick the allowed child options per parent value, save.

## How the setting is saved
`#entity_builders[] = 'dependent_list_field_config_entity_builder'`. On submit `dependent_list_field_config_entity_builder()`:
- if no `parent_field` is chosen, writes empty `parent_field` (`''`) and `value_map` (`[]`);
- otherwise stores `parent_field` and converts each row's checked checkbox keys (`array_filter` then `array_values`) into `value_map[parentKey] = [allowedChildKey, ...]`.

Both go to third-party settings namespace `dependent_list` on the child `FieldConfig`.

## Config schema
`config/schema/dependent_list.schema.yml` types `field.field.*.*.*.third_party.dependent_list`:
```
parent_field: string
value_map: sequence of ( sequence of string )   # parent_value => [allowed child keys]
```

## Notes
- The mapping is **per child field**; a parent field can drive several children.
- `hook_options_list_alter` (`dependent_list_options_list_alter`) only removes duplicate empty ("- None -") options when `_none` is present — unrelated to the value_map.
- Deleting/renaming the parent field or its allowed values does not auto-clean the map; stale keys are simply ignored at render time (only keys still valid in the child storage are shown — see the runtime doc).
