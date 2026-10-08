<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display Selected and Unselected (display_selected_and_unselected) — agent index

Two view-display field formatters that render **all** allowed options of a core List field, marking selected vs unselected as disabled radios (single-value fields) or checkboxes (multi-value fields).

- **Version dir:** 8.x-1.x (packaged 8.x-1.1)
- **Core:** `>=8` · **Package:** Fields · **License:** GPL-2.0-or-later
- **Dependencies:** none (core only). No submodules, no libraries.
- **Config:** none — no settings form, no config objects, no permissions, no routes, no services, no Drush.

## What it provides

- **Formatters** (`src/Plugin/Field/FieldFormatter/`):
  - `display_selected_and_unselected_values` — `DisplaySelectedAndUnselectedValuesFieldFormatter`, renders option **labels (values)**.
  - `display_selected_and_unselected_keys` — `DisplaySelectedAndUnselectedKeysFieldFormatter`, renders option **keys**.
  - Both apply to `field_types = { list_string, list_integer, list_float }`. Neither defines any settings (`defaultSettings`/`settingsForm`/`settingsSummary` are empty stubs).
- **Theme hooks** (`display_selected_and_unselected.module`, `hook_theme()`) with overridable Twig templates in `templates/`:
  `display_selected_and_unselected_values_checkbox`, `..._values_radio`, `..._keys_checkbox`, `..._keys_radio` — each takes `allowed_values`, `selected_keys`, `field_name`.

## Behavior

`viewElements()` reads the field's `allowed_values` and storage **cardinality**: cardinality `== 1` ⇒ `radio` template, otherwise `checkbox`. It collects the selected item `->value`s into `selected_keys` and hands `allowed_values` + `selected_keys` + `field_name` to the theme hook. Templates loop `allowed_values` and emit a **disabled** input per option, `checked` when `key in selected_keys`.

## Solution docs

- [Formatters & theming](fields/formatters.md) — enable on Manage display, keys-vs-values, radio-vs-checkbox rule, template overrides.
