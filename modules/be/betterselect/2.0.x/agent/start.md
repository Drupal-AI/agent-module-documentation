<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Select (betterselect) — agent index

Converts `#multiple` **select** form elements into stylized core **checkboxes** lists.
Package `Form`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 2.0.0. No composer or
module dependencies; no entities, fields, services, or plugin types.

- **The `#process` conversion, the four settings, the `#betterselect` opt-in flag, taxonomy depth
  classes, the config route, CSS/JS library** → [config/settings.md](config/settings.md)

## What it actually is

- One procedural hook: `betterselect_element_info_alter()` (in `betterselect.module`) appends
  `betterselect_process_element` to `$types['select']['#process']`. Every render `select` element
  passes through it.
- `betterselect_should_format_element()` decides conversion: returns FALSE unless `#multiple`;
  TRUE if `#betterselect` is set; otherwise TRUE only when config `explicit_only` is FALSE.
- `betterselect_process_element()` rewrites the element: normalizes `#value` to an associative
  array, sets `#type = 'checkboxes'`, `#checkall = TRUE`, unsets the select `#theme`/`#pre_render`/
  attributes, calls `Checkboxes::processCheckboxes()`, hides the `_none`/empty option on non-required
  fields, attaches library `betterselect/betterselect`, and wraps the whole thing in a
  `<div class="better-select …">` (id + classes escaped with `Html::escape`).

## Config, route, library

- Config object **`betterselect.settings`** — four booleans: `scroll`, `scroll_to_first_checked`,
  `add_depth_classes`, `explicit_only` (all default FALSE). Schema in `config/schema/`, install
  defaults in `config/install/`.
- Settings form `BetterSelectSettingsForm` (`src/Form/BetterSelectSettingsForm.php`, extends
  `ConfigFormBase`) at route **`betterselect.settings`** → `/admin/config/content/betterselect`,
  permission **`administer site configuration`** (core; module defines no permissions).
- Library `betterselect` = `css/betterselect.css` + `js/betterselect.js` (deps `core/drupal`,
  `core/once`). JS `Drupal.behaviors.initBetterSelect` toggles a `hilight` class on checked rows
  and scrolls to the first checked item. `hook_uninstall()` deletes the config object.
