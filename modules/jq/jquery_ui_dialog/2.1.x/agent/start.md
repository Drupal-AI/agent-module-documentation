<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# jQuery UI Dialog — agent index

A **library-only shim**. The 2.1.0 project ships exactly three files
(`jquery_ui_dialog.info.yml`, `composer.json`, `LICENSE.txt`) — no PHP, no `.libraries.yml`,
no config, no routes, no permissions, no plugins, `configure: null`.

- **Attach / depend on the library, what it resolves to, and the deprecated core equivalent** →
  [theming/dialog-library.md](theming/dialog-library.md)

Key facts:
- Library id: **`jquery_ui_dialog/dialog`** (replaces the removed `core/jquery.ui.dialog`).
- The library is **declared by the `jquery_ui` module**, not by this one:
  `jquery_ui_library_info_alter()` merges definitions from `jquery_ui.libraries.data.json`
  into whichever `jquery_ui_*` extension they belong to.
- Assets are jQuery UI **1.13.2**, vendored inside the `jquery_ui` module:
  `modules/contrib/jquery_ui/assets/vendor/jquery.ui/ui/widgets/dialog-min.js` and
  `…/themes/base/dialog.css`.
- Module dependencies: `jquery_ui` (>=8.x-1.7), `jquery_ui_button`, `jquery_ui_draggable`,
  `jquery_ui_resizable` (all >=2.1).
- jQuery UI is end-of-life; prefer core's `core/drupal.dialog` / `core/drupal.dialog.ajax`
  for new code.
