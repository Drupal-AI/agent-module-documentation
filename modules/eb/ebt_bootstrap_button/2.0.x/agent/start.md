<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EBT Bootstrap Button (ebt_bootstrap_button) — agent index

Installs an `ebt_bootstrap_button` `block_content` type (a Link field + the shared EBT settings field)
with a Bootstrap-button settings widget, for placement in Layout Builder or the block library. Part
of the Extra Block Types (EBT) suite; requires `ebt_core` (composer `drupal/ebt_core:^2.0`) and pulls
in core `link` + `block_content` via its shipped config. No settings route (`configure: null`), no
permissions, no Drush, no config/schema of its own.

- **Block type, fields, the `ebt_settings_bootstrap_button` widget, install/uninstall** →
  [configure/block.md](configure/block.md)
- **The two block templates and how classes/link/`styles` are rendered** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Bundle `block_content:ebt_bootstrap_button` (`config/install/block_content.type.ebt_bootstrap_button.yml`)
  with fields `field_ebt_bootstrap_button_link` (core **link**, cardinality 1, required) and
  `field_ebt_settings` (`ebt_settings` field type, from `ebt_core`).
- Widget `ebt_settings_bootstrap_button` (`EbtSettingsBootstrapButtonWidget` extends
  `EbtSettingsDefaultWidget`) exposes: open_in_new_tab, add_nofollow, alignment, button_type
  (required, 9 Bootstrap types), outline_button, active_button, disable_button, size, stretched,
  custom_class_name. `custom_class_name` is validated by `EbtGenericValidator::validateClassElement`
  (ebt_core).
- Only PHP: `src/Hook/EbtBootstrapButtonHooks.php` (a `hook_help` implementation via the
  `#[Hook('help')]` attribute; wired through `ebt_bootstrap_button.services.yml` +
  `.module` `#[LegacyHook]` shim) and the widget class. No preprocess/CSS-generation hook — the
  design-layer `styles` variable comes from `ebt_core`.
- `ebt_bootstrap_button.install`: `hook_update_9101` makes the link field required;
  `hook_uninstall` deletes the block type only if no `ebt_bootstrap_button` blocks exist.
- Frontend CSS library `ebt_bootstrap_button/ebt_bootstrap_button_view`
  (`css/ebt_bootstrap_button_view.css`), attached from the templates.
