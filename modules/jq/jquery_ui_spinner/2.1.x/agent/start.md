<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# jQuery UI Spinner — agent index

Code-free metapackage that re-publishes the jQuery UI Spinner widget (removed from core) as the
attachable asset library **`jquery_ui_spinner/spinner`** (jQuery UI 1.13.2). No config, no
permissions, no schema, no plugins, no services, no routes, no Drush. The module ships only
`info.yml` + `composer.json`; everything you do with it is attach one library.

- Depends on: `jquery_ui`, `jquery_ui_button`. Core: `^9.2 || ^10 || ^11`. Package: `jQuery UI`.
- Configure route: none (`configure` is null).

## What you'd do → where

- **Attach the library, initialize `.spinner()`, and migrate `core/jquery.ui.spinner` references** →
  [theming/attach-library.md](theming/attach-library.md)

## Key facts (real machine names)

- **Library id:** `jquery_ui_spinner/spinner` — defined NOT here but in the `jquery_ui` module's
  `jquery_ui.libraries.data.json` (key `jquery_ui_spinner` → `spinner`), injected into this
  module's namespace by `jquery_ui_library_info_alter()` in `jquery_ui.module`.
- **Assets** (under `jquery_ui/assets/vendor/jquery.ui/`): JS `ui/widgets/spinner-min.js`
  (minified, weight -11); CSS `themes/base/spinner.css` (component).
- **Auto-pulled dependencies:** `core/jquery`, `jquery_ui_button/button`, `jquery_ui/widget`,
  `jquery_ui/internal.version`, `internal.keycode`, `internal.safe-active-element`,
  `jquery_ui/internal.widget-css`.
- **Version dir vs release:** module release `2.1.0`; docs bucket `jq/jquery_ui_spinner/2.1.x`.
- Upstream jQuery UI is end-of-life; use as a legacy compatibility bridge only.
