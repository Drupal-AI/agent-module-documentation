<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Checkboxes (custom_checkboxes) — agent index

Front-end/theming module that restyles native checkbox `<input>`s with CSS. Version 2.1.0.
Core `^8.7.7 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.

## What it ships
- One asset library, `custom_checkboxes/custom_checkboxes` (defined in `custom_checkboxes.libraries.yml`):
  - CSS: `css/custom_checkboxes.css` (theme group)
  - JS: `js/custom_checkboxes.js`
  - dependency: `core/jquery`
- `custom_checkboxes.module` — empty except a `@file` docblock (no hooks).
- No routes, permissions, config, config schema, services, plugins, entities, or Drush commands.

## How it works
- `Drupal.behaviors.customCheckbox` (`js/custom_checkboxes.js`) iterates `input[type="checkbox"]`,
  inserts a sibling `<span class="checkmark">`, and adds class `checkmark-label` to the parent.
- The CSS sets the real input to `opacity:0` and draws the visible box, border, checked background
  (`#15459A`), and checkmark tick.
- You must attach the library yourself (nothing auto-attaches it).

## Dependencies
- Drupal `core/jquery`. No module dependencies, no Composer requirements.

## Docs
- Attach + customize: [agent/theming/library.md](theming/library.md)
