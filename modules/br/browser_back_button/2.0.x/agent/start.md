<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Browser Back Button (browser_back_button) — agent index

A single **Block plugin** that renders a clickable Back control; a jQuery behavior binds its
click to `window.history.back()`. No routes, no permissions, no services, no dependencies beyond
Drupal core. Core requirement `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.0.2.

- **The block, its configure form, config schema, theme + JS wiring, and how to operate it** →
  [config/block.md](config/block.md)

## What it actually is

- One plugin: `BrowserBackButtonBlock` (id **`browser_back_button_block`**, admin/category label
  *"Browser Back Button Block"*), in `src/Plugin/Block/BrowserBackButtonBlock.php`, extending core
  `BlockBase`. Placed and configured through core **Block Layout** — there is no dedicated settings
  route or permission of its own (block placement uses core's `administer blocks`).
- One theme hook `browser_back_button_history` (`browser_back_button_theme()` in the `.module`),
  template `templates/browser-back-button-history.html.twig`, which outputs
  `<div id="back-button-wrapper">{{ data.body }}</div>`.
- One library `browser_back_button/browser_back_button.history`
  (`js/browser_back_button.history.js`; deps `core/drupal`, `core/jquery`, `core/once`) — a
  `Drupal.behaviors` handler that runs `window.history.back()` on click of `#back-button-wrapper`.
- Config schema `block.settings.browser_back_button_block` (`config/schema/…schema.yml`): `body`
  (`text_format`) and `reload_status` (boolean).
- `hook_help()` renders `README.txt` (via the `markdown` filter if that module is present, else
  escaped `<pre>`).

## Notes from source

- The block's `body` is stored as a `text_format` value+format and rendered with
  `check_markup($value, $format)` in `build()`, i.e. filtered by the admin-selected text format.
- `reload_status` exists in `defaultConfiguration()` and the schema but is **not** exposed in
  `blockForm()`, not saved in `blockSubmit()`, and **not** consumed by the JS. Clicking only steps
  back one history entry; there is no page-reload code path in the shipped script despite the name.
