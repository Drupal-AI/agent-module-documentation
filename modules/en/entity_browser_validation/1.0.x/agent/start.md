<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Browser Validation (entity_browser_validation) — agent index

Adds core-style red error highlighting to the **Entity Browser** entity-reference field
widget when its field fails validation. Package `Media`. Depends on **`entity_browser`**.
Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version-dir 1.0.x (installed 1.0.3).

- **The form-alter hook, the CSS library, and how the highlight works** →
  [forms/widget-error-highlight.md](forms/widget-error-highlight.md)

## What it actually is

- A **one-hook** utility: `entity_browser_validation.module` implements
  `hook_field_widget_single_element_entity_browser_entity_reference_form_alter()`. No `src/`,
  no plugins, no config, no routes, no permissions, no services, no `.install`, no JS, and
  **no `composer.json`** in the package.
- The only asset is one CSS library, `entity_browser_validation/validation`
  (`entity_browser_validation.libraries.yml` → `css/validation.forms.css`).

## Mechanism (from source)

- The hook runs only when `$context['items']` is an `EntityReferenceFieldItemList`. It builds an
  element name from `getFieldDefinition()->getName()` plus the form's `#parents`
  (`field_name[parent1][parent2]…`), sets it on `$element['#attributes']['name']`, and attaches
  the `entity_browser_validation/validation` library.
- The added `name` makes the widget's `details` wrapper a **target** for Drupal's standard
  error flagging, which applies the `error` class as it does to failed inputs (per README).
- `css/validation.forms.css` styles `.form-wrapper details.error` (red text, red border, light
  background, inset shadow). Override this selector in a theme to restyle.

## Config / operation

- **None.** Enabling the module (`drush en entity_browser_validation`) is the whole setup; it
  applies automatically to every field using the Entity Browser entity-reference widget.
