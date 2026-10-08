<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Form (advancedform) — agent index

Declutters **node edit forms** by hiding admin-configured fields with generated CSS, with a
client-side toggle button to reveal the full form. UI convenience only. Version **2.0.0**,
core `^10 || ^11`, package `Other`. No dependencies (`require: {}`).

**Not access control:** hidden fields stay in the DOM and remain submittable — the module states this
itself. Use real field access / permissions to actually restrict data.

## What it provides
- **Hook:** `advancedform_form_node_form_alter()` (in `advancedform.module`) — attaches the
  `advancedform/admin` library, injects a `<style>` (render element `#type => html_tag`, `#tag => style`)
  whose value is `CssGenerator::cssFromRules($config->get('rules_global'))`, and adds body classes
  `advanced-form-filtered` and `role-<name>` per current-user role.
- **Service:** `advancedform.cssgenerator` → `Drupal\advancedform\Service\CssGenerator::cssFromRules()`
  turns one-rule-per-line selector syntax into `form.advanced-form-filtered<sel> { display: none; }`.
- **Form:** `Drupal\advancedform\Form\AdvancedFormSettingsForm` (extends `ConfigFormBase`) — one
  `rules_global` textarea; saves only when non-empty.
- **Config:** object `advancedform.settings` key `rules_global` (schema `type: text`); install default `""`.
- **Route:** `advancedform.settings_form` → `/admin/config/advancedform/settings`, permission
  `administer advanced form settings` (`advancedform.permissions.yml`), admin route. Menu link under
  `system.admin_config_system`.
- **Library:** `advancedform/admin` = `css/advanced-form.css` + `js/advanced-form.js`
  (`Drupal.behaviors.advancedform`: builds toggle button, tracks `selected-<label>` classes from
  `.field--widget-options-select select`), deps `core/drupal`, `core/once`.
- **Permission:** `administer advanced form settings`.
- **post_update:** `advancedform_post_update_rename_settings()` migrates old
  `advancedform.advancedformsettings` config to `advancedform.settings`.

## Solution docs
- [Configuration & rule syntax](config/settings.md) — settings form, config object/schema, the
  CssGenerator selector language, JS toggle + context classes.
