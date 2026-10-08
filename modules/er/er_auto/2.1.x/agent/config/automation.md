<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reference Automation — configuration and mechanism

All logic lives in `er_auto.module` (form alters) and `js/field-automation.js` (the runtime). There is
no settings page, no config object, and no config schema.

## Install / enable

`drush en er_auto`. No dependencies (`er_auto.info.yml`), no install hooks. Nothing appears until you
configure a specific entity reference field.

## Configuring a field (admin side)

`er_auto_form_field_config_edit_form_alter()` alters the core **field config edit form**
(`field_config_edit_form`, gated by the normal field-administration permissions, e.g.
*administer node fields*):

- Runs only when the edited field's type is `entity_reference` and its `target_type` resolves to a
  `ContentEntityType` (fieldable). Otherwise it returns unchanged.
- Adds a *Reference Automation* fieldset with:
  - `er_auto_enable` — checkbox, "Enable Automation based on this field?".
  - `er_auto_source` — multi-select of the `entity_reference` fields found **on the referenced
    (target) type/bundles** via `_er_auto_bundle_entity_reference_fields($target_type, $bundle)`. These
    are the fields whose values get copied *from*. When `handler_settings[target_bundles]` is empty it
    scans the whole target type.
  - `er_auto_automated` — multi-select of the `entity_reference` fields **on the host bundle**
    (`_er_auto_bundle_entity_reference_fields($host_type, $host_bundle)`), excluding read-only fields.
    These are the fields written *to*.
  - Both selects are `#states`-hidden unless the enable checkbox is ticked. If either side has no
    reference fields, a "No … Available" message is shown instead.
- On submit, `er_auto_form_field_config_edit_form_submit()` stores
  `setThirdPartySetting('er_auto', 'automation', ['enabled' => bool, 'source' => [field_ids], 'automated' => [field_ids]])`
  on the field config and saves it. (Note: it uses `array_keys()` on the submitted select values.)

## Runtime on the content form

`er_auto_form_alter()` fires on any `EntityForm` whose operation is `edit` and whose entity is a
`ContentEntityBase`:

- For each field on the bundle that carries the `er_auto.automation` third-party setting and is present
  in `$form`, it reads the field's `target_type` and loads that storage.
- It walks the driving field widget's `#options` (skipping `_none`), loads each referenced entity, and
  for every configured `source`/`automated` pair where the source field's `target_type` matches the
  automated field's `target_type`, collects the source entity's reference `target_id`s into a nested
  map `target_map[option_id][automated_field] = [target_ids]`.
- Attaches library `er_auto/field-automation`, publishes the map under
  `drupalSettings.er_auto.automation[field_id]`, adds class `erAutoSource`, and sets
  `data-er-auto-field-id` / `data-er-auto-field-type` (the widget `#type`) on the field wrapper.

## JavaScript (`Drupal.behaviors.erAutoSource`)

- Binds to `.erAutoSource` elements once. For `select` widgets it diffs the previous vs. new value on
  `change` and calls `automate(fieldId, added, "add")` / `automate(…, removed, "remove")`; for
  `radios`/`checkboxes` it binds per input and adds on check, removes on uncheck.
- `automate()` looks up `drupalSettings.er_auto.automation[source_id][value][target_field]` and, per
  target widget class (`form-select`, `form-checkboxes`, `form-radios`), sets the matching options/inputs
  `selected`/`checked`. On `remove` it first checks `getProviderList()` so a value still supplied by
  another active selection is not cleared. It fires `change()` and, if present, `chosen:updated` so
  Chosen selects refresh.

## Operating notes

- Automation only ever manipulates form elements that already exist and are selectable; it never creates
  entities and never submits on its own. Final values are saved by core's normal form submission, which
  still enforces field access and reference validation.
- Source and automated fields must share the same `target_type` for a mapping to take effect.
- `_er_auto_entity_Reference_fields()` is dead legacy code kept for possible future features (see its
  docblock); nothing calls it.
