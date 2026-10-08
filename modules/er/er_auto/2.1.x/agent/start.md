<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Automation (er_auto) — agent index

Links `entity_reference` fields so that choosing a referenced entity in one field on an entity **edit**
form auto-fills the reference IDs of other reference fields in the browser. Package `Field types`. No
dependencies beyond Drupal core (`^10 || ^11 || ^12`). License GPL-2.0-or-later. Version 2.1.1.

- **How it is configured and how the automation actually works** →
  [config/automation.md](config/automation.md)

## What it actually is

- No routes, no permissions, no services, no plugins, no config entities, no `config/schema`, no
  install/update hooks, no Drush. It is entirely form-alter hooks in `er_auto.module` plus one JS
  behavior in `js/field-automation.js`.
- Configuration is stored as a **third-party setting** `er_auto.automation` on each field config entity
  (`{enabled, source[], automated[]}`), set through the field's own edit form — not a settings object.
- Purely an editing convenience: values are pre-filled client-side and still saved (and access-checked)
  through Drupal's normal entity form submission.

## Provided hooks / library

- `hook_form_FIELD_CONFIG_EDIT_FORM_alter` (`er_auto_form_field_config_edit_form_alter`) — adds the
  *Reference Automation* fieldset to entity_reference fields whose target is a `ContentEntityType`.
- Submit handler `er_auto_form_field_config_edit_form_submit` — persists the third-party setting.
- `hook_form_alter` (`er_auto_form_alter`) — on `EntityForm` **edit** operations, builds the option→field
  value map, attaches library `er_auto/field-automation` and `drupalSettings.er_auto.automation`.
- Helpers `_er_auto_bundle_entity_reference_fields()` and legacy `_er_auto_entity_Reference_fields()`.
- Library `er_auto/field-automation` (`js/field-automation.js`), depends on core jQuery, drupalSettings,
  once; behavior `Drupal.behaviors.erAutoSource`.
