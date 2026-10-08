<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Float Labels (float_labels) — agent index

Applies configurable, JS-enhanced **floating CSS labels** to selected Drupal forms: the `<label>`
sits inside the field (placeholder-style) and animates above it on focus/input. Package `Forms`.
**No module dependencies.** Core `^10 || ^11`. License GPL-2.0-or-later. Version 2.0.0.

- **Settings form, config keys, form/selector matching, JS behavior, hooks** →
  [config/settings.md](config/settings.md)

## What it actually is

- No entities, no plugins, no services, no Drush. Pure hook + config + jQuery behavior.
- One permission: **`administer float labels`** (`float_labels.permissions.yml`).
- One route: **`float_labels.admin_settings`** → `/admin/config/user-interface/float-labels`,
  `_form: \Drupal\float_labels\Form\SettingsForm`, requires `administer float labels`
  (`float_labels.routing.yml`). Menu link under *Configuration → User interface*
  (`float_labels.links.menu.yml`).
- One config object **`float_labels.settings`** (no `config/install` or `config/schema` shipped —
  keys are created on first save by `SettingsForm`).
- One asset library **`float_labels/float_labels`** (`css/float_labels.css`, `js/float_labels.js`;
  depends on `core/jquery`, `core/drupal`).

## Mechanism (from source, `float_labels.module`)

- `hook_element_info_alter()` adds `float_labels_process_element` to the `#process` of element
  types `form, textarea, textfield, tel, email, url, password, password_confirm` (plus `select`
  when `select_field_default_value` is on).
- `float_labels_process_element()` decides per form via `float_labels_should_process_form()`
  (unless `#float_labels` is set on the element/form), then adds
  `float-labels-include`/`-exclude` classes (or `-include-children`/`-exclude-children` on the
  `form` element) and calls `float_labels_attach()`.
- `float_labels_should_process_form()` matches `$form['#form_id']` against the newline-separated
  `included_forms` then `excluded_forms` lists; a line starting with `/` is treated as a regex
  (`preg_match`), otherwise it is an exact string compare.
- `float_labels_attach()` pushes `drupalSettings.float_labels` = `{includes, excludes,
  mark_required}` (selector lists split on newlines) and attaches the library.
- `float_labels_select()` (select support) prepends/replaces the empty option's text with
  `t(sprintf($template, $title))` where `$template` = `select_field_default_value_template`
  (default `' - %s - '`).
- `js/float_labels.js` (`Drupal.behaviors.floatLabels`): collects `.float-labels-include`
  elements + `:input:text, textarea` inside `.float-labels-include-children`, applies the
  include/exclude selector lists, wraps each field in `.float-labels-wrapper`, moves the label
  into `.float-labels-label`, strips the `placeholder`, and toggles `float-labels-focused` on
  focus/blur/change. Buttons and selects are excluded from wrapping.

## Config keys (`float_labels.settings`)

`included_forms`, `excluded_forms` (form-ID match lists), `included_selectors`,
`excluded_selectors` (CSS selector lists), `mark_required` (bool), `select_field_default_value`
(bool), `select_field_default_value_template` (string). Full detail in
[config/settings.md](config/settings.md).
