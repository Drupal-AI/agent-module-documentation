<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
jQuery UI Dialog re-provides the single `dialog` asset library from jQuery UI as a contrib module, replacing the `core/jquery.ui.dialog` library that Drupal core deprecated and removed.

---

The 2.1.x release contains **no PHP, no `.libraries.yml`, no config, no routes and no permissions** — the whole project is an `info.yml`, a `composer.json` and a licence file. Its only job is to exist as an extension name that a library can hang off: the base `jquery_ui` module implements `hook_library_info_alter()`, reads `jquery_ui.libraries.data.json` and declares the `jquery_ui_dialog/dialog` library on this module's behalf, pointing at the vendored jQuery UI 1.13.2 assets that physically live under `jquery_ui/assets/vendor/jquery.ui/` (`ui/widgets/dialog-min.js` and `themes/base/dialog.css`). Because of that, `jquery_ui_dialog` hard-depends on four other modules — `jquery_ui` (>= 8.x-1.7) for the assets, plus `jquery_ui_button`, `jquery_ui_draggable` and `jquery_ui_resizable` (>= 2.1), which supply the widgets the dialog itself needs for its button pane, drag handle and resize grips. Attaching `jquery_ui_dialog/dialog` pulls in the full transitive chain (`core/jquery`, `jquery_ui/widget`, `jquery_ui/position`, `jquery_ui/mouse`, the internal helper libraries, and the three sibling widget libraries) automatically. Note that jQuery UI is end-of-life upstream: use this module to keep legacy `$.fn.dialog()` code working while you migrate to Drupal core's own `core/drupal.dialog` / `core/drupal.dialog.ajax`.

---

- Keep a legacy custom module that calls `$('#el').dialog()` working on Drupal 10/11.
- Replace a `core/jquery.ui.dialog` dependency in a theme's `*.libraries.yml` after upgrading core.
- Provide the jQuery UI dialog widget for a contrib module that still requires it (e.g. older lightbox or wizard modules).
- Satisfy a `libraries-override`/`libraries-extend` chain in a custom theme that references the dialog CSS.
- Ship the jQuery UI base `dialog.css` so an old dialog skin keeps its look.
- Add draggable + resizable modal behaviour without writing your own dialog implementation.
- Attach the dialog library from a render array (`#attached['library'][] = 'jquery_ui_dialog/dialog'`).
- Declare it as a dependency of your own module library in `*.libraries.yml`.
- Support a JS plugin that expects `jQuery.ui.dialog` to be defined on the page.
- Give a Views field/area plugin a jQuery UI dialog for an inline confirm step.
- Keep a bespoke admin screen's popup behaviour identical during a Drupal 9 → 11 migration.
- Provide the dialog widget for legacy Drupal 7-era ported code that has not moved to Drupal.dialog.
- Test whether a bug is caused by the missing core jQuery UI library by installing this shim.
- Pin the jQuery UI version used site-wide (1.13.2, vendored by the `jquery_ui` module).
- Pull in `jquery_ui_button`, `jquery_ui_draggable` and `jquery_ui_resizable` in one dependency for dialog-style UIs.
- Stage a migration: install the shim now, remove it once every dialog uses `core/drupal.dialog`.
- Provide the library for a contrib module whose `*.libraries.yml` still lists `core/jquery.ui.dialog` (via an override).
- Let a custom CKEditor 5 plugin's legacy companion JS open a jQuery UI dialog.
- Keep an existing accessibility fix that patches `jQuery.ui.dialog` behaviour applicable.
- Document/track the jQuery UI surface a site still relies on before removing it.
