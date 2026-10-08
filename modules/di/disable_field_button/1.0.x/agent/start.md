<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Disable Field Button (disable_field_button) — agent index

A form-alter convenience module: it adds a **Disable** submit button to each field's settings
edit form on the Field UI **Manage display** and **Manage form display** pages, so a field can be
removed from a display in one click instead of dragging its row to the Disabled region. Package
**Field UI**. Depends only on core **`field_ui`**. Core requirement `^11`. License
GPL-2.0-or-later. Version 1.0.0.

- **How the button is injected, the submit handler, access model, and how to operate it** →
  [behavior/disable-button.md](behavior/disable-button.md)

## What it actually is

- No routes, no services, no plugins, no config, **no permission of its own**, no Drush, no
  install hooks. Just two hook implementations.
- `disable_field_button_form_alter()` (procedural, in `disable_field_button.module`) targets any
  form whose form object is a `\Drupal\field_ui\Form\EntityDisplayFormBase` and that has a
  `fields` element — i.e. the Manage display and Manage form display forms.
- `DisableFieldButtonHooks::help()` (OOP, `src/Hook/DisableFieldButtonHooks.php`, using the
  `#[Hook('help')]` attribute) provides the `help.page.disable_field_button` text only.

## Mechanism (from source)

- For each field row (`Element::children($form['fields'])`), `_disable_field_button_find_actions()`
  locates the row's open `settings_edit_form` → `actions` container (checking the direct location,
  then `format`/`plugin` sub-keys, then walking all children). The actions container only exists
  when the editor has expanded that field's settings, so the button appears only on the open row.
- Into that container it adds a `#type => submit` button `disable` (value *Disable*, name
  `<field>_plugin_settings_disable`, class `button--danger`, `#limit_validation_errors => []`),
  carrying the field machine name in `#field_name` and running `_disable_field_button_submit`.
- `_disable_field_button_submit()` reads `#field_name` from the triggering element, calls
  `$display->removeComponent($field_name)` on the form's display entity (`$form_object->getEntity()`)
  and `$display->save()`, then adds a `messenger()` status message.

## Access model

- The module adds **no access check** because it does not need one: the button lives inside the
  core Field UI display forms, which are already gated by the entity type's display permissions
  (e.g. `administer node display`, `administer node form display`). Anyone who can reach the form
  can already add/remove/drag the same components. `#field_name` is set server-side from the form's
  own field children, not from request input.

## Install / operate

- `drush en disable_field_button` (core `field_ui` is the only dependency). Nothing to configure.
- Go to a Manage display / Manage form display page, click a field's settings (gear) button, then
  click **Disable**. See [behavior/disable-button.md](behavior/disable-button.md).
