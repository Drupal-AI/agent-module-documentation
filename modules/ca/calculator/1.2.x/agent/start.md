<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Calculator (calculator) — agent index

A single **Block plugin** that renders a small, fully **client-side** arithmetic calculator with a
choice of ten predefined CSS layouts. Package `Calculator`. Depends only on core **`block`**. Core
requirement `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.2.5.

- **The block, its one setting, placement, theming/overrides, and how the JS works** →
  [plugins/block.md](plugins/block.md)

## What it actually is

- One plugin: `CalculatorBlock` (id **`calculator_block`**, admin label *"Calculator Block"*) in
  `src/Plugin/Block/CalculatorBlock.php`, extending core `BlockBase`.
- One theme hook `calculator_block` (`hook_theme()` in `calculator.module`) with a single
  `content` variable, rendered by `templates/calculator-block.html.twig`.
- One asset library `calculator/calculator.frontend` (`calculator.libraries.yml`): `css/style.css`
  + `js/script.js`, depending on `core/jquery`, `core/drupal.ajax`, `core/drupal`,
  `core/drupalSettings`, `core/once`.
- `calculator_help()` provides the `help.page.calculator` text. That is the whole module.

## What it does NOT provide

- **No routes, controllers, forms** (beyond the standard block config form), **no permissions**,
  **no services, no Drush, no entities, no config schema, no `config/install`**, no plugin types.
- **No server-side computation**: all arithmetic happens in the browser in `js/script.js`.
  There is no AJAX callback despite the `drupal.ajax` library dependency.

## Mechanism (from source)

- `defaultConfiguration()` sets `layout => 1` and `label_display => FALSE`.
- `build()` reads `$this->configuration['layout'] ?: 1`, puts it in `$content['layout']`, and
  returns a `#theme => 'calculator_block'` render array with that content, attaching the
  `calculator/calculator.frontend` library. `getCacheMaxAge()` returns **0** (never cached).
- `buildConfigurationForm()` adds a single **select** `layout` with options `'1'`–`'10'`
  (Layout 1–10); `submitConfigurationForm()` stores `layout` into block config.
- The Twig template emits a fixed keypad inside `<div class="calculator-theme-{{ content.layout }}">`.
  `js/script.js` (`Drupal.behaviors.calculator_behavior`) binds click + `keydown` handlers on
  `.number` / `.operation` / `.equal` / `.all-clear` / `.last-entity-clear`, accumulating strings
  and computing with `parseFloat()` and JS `* + - / %` — **no `eval`**. Operators: `+ - x / %`.

## Configuration & operation

- Enable: `drush en calculator`. Configure/place at **Structure → Block layout** (`/admin/structure/block`);
  pick a region and set **Calculator Layout** (1–10). Block visibility/roles use core block conditions.
- Theming: override `css/style.css` and/or copy `templates/calculator-block.html.twig` into a
  custom theme; style per-layout via the `.calculator-theme-N` wrapper class. See
  [plugins/block.md](plugins/block.md).
