<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, permission, and config object

## Install / enable

```
composer require drupal/block_content_visibility
drush pm:install block_content_visibility
```

`drupal/block_form_alter` `^2.0` comes in as a transitive dependency; `block_content` is core.
`hook_install()` (`block_content_visibility.install`) installs the `visibility_conditions` base
field storage on `block_content`; it is idempotent (no-op if already installed). `hook_uninstall()`
removes the storage and purges stored data.

## Permission

One permission in `block_content_visibility.permissions.yml`:

- **`administer block content visibility`** — `restrict access: true`. Gates the settings form
  route, the Visibility group on the block_content form, and the placement-form coexistence
  warning. Revoking it hides all UI but **does not** stop already-stored conditions from being
  evaluated at render time (evaluation is unconditional in `hook_block_access`).

## Settings form

`Form\SettingsForm` (`getFormId()` = `block_content_visibility_settings`, extends
`ConfigFormBase`), route `block_content_visibility.settings` at
`/admin/config/system/block-content-visibility` (menu link under *Configuration → System*),
requirement `_permission: 'administer block content visibility'`. Two `checkboxes` elements,
both written by `submitForm()` via `array_values(array_filter(...))` (only ticked values stored):

- **`enabled_bundles`** — which `block_content` bundles expose the Visibility UI on their
  add/edit form. Options come from `entity_type.bundle.info`. **Empty (default) = all bundles.**
  Read in `BlockContentVisibilityHooks::blockTypeFormAlter()`: if non-empty and the current
  bundle is not listed, the form alter returns early.
- **`disabled_plugins`** — Condition plugin ids hidden from the Visibility UI. Options come from
  `plugin.manager.condition` → `getDefinitionsForContexts()`. Read in
  `VisibilityFormBuilder::buildForm()` (`array_diff_key($definitions, array_flip($disabled))`).
  **Hiding gates only the form — stored conditions for a hidden plugin still evaluate at render
  time.** Intended for context-hungry plugins like `entity_bundle:node`.

## Config object + schema

Config object **`block_content_visibility.settings`** (editable name returned by
`getEditableConfigNames()`).

- `config/install/block_content_visibility.settings.yml`: `enabled_bundles: []`,
  `disabled_plugins: []`.
- `config/schema/block_content_visibility.schema.yml`: `config_object` with two `sequence`s of
  `string` (`enabled_bundles`, `disabled_plugins`).

No Drush commands, no libraries, no other config objects.
