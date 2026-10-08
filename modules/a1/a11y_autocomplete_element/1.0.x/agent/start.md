<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Accessible Autocomplete Element/Widget (a11y_autocomplete_element) — agent index

Provides an accessible **WAI-ARIA combobox** as a drop-in replacement for core `select`, in two forms:
a Form API render element and an options field widget. Enhancement is **entirely client-side** — the
server still renders a normal `<select>`, and JS filters its `<option>`s in the browser. No routes,
controllers, AJAX endpoints, services, permissions or config forms.

- **Version:** 1.0.6 · **Core:** `^10 || ^11` · **License:** GPL-2.0-or-later
- **Dependencies:** core `options` module; JS library `@drupal/autocomplete` (installed separately).
- **Configure route:** none. **Permissions:** none. **Drush:** none. **Config schema:** yes (widget settings only).

## What it provides
- Render element `A11yAutocomplete` (`@FormElement("a11y_autocomplete")`), `src/Element/A11yAutocomplete.php`
  — extends core `Select`; adds a `#process` callback that attaches the library and a
  `data-a11y-autocomplete-element` attribute. All `#select` keys are supported.
- Field widget `A11yAutocompleteWidget` (`@FieldWidget id="a11y_autocomplete"`),
  `src/Plugin/Field/FieldWidget/A11yAutocompleteWidget.php` — extends `OptionsSelectWidget`; supports
  `entity_reference`, `list_integer`, `list_float`, `list_string`; sets the element `#type` to `a11y_autocomplete`.
- `hook_library_info_build()` + `hook_requirements()` (`.module` / `.install`) locate the JS library
  (git clone, asset-packagist, or npm `node_modules`, copying it into `public://a11y_autocomplete` when needed).
- Config schema `field.widget.settings.a11y_autocomplete` (inherits `options_select`).

## Solution docs
- [agent/api/element-and-widget.md](api/element-and-widget.md) — using the `#type`, the field widget,
  the JS library resolution, and how it operates.
