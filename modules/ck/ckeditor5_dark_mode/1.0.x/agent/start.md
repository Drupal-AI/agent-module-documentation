<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 - Dark Mode plugin (ckeditor5_dark_mode) — agent index

A front-end-only CKEditor 5 plugin that adds a single "Dark Mode" toolbar button. Clicking it toggles a `ck-dark` CSS class on the editor's editing region (and flips the button to "Light Mode"); the dark look is delivered by the module's CSS. No PHP, no routes, no permissions, no stored config.

## Facts
- Requires: core `ckeditor5` module (`dependencies: - drupal:ckeditor5` in `ckeditor5_dark_mode.info.yml`); JS library depends on `core/ckeditor5`.
- Core: `^8.8 || ^9 || ^10 || ^11`. License: GPL-2.0-or-later.
- No `.module`, `.install`, `.routing.yml`, `.permissions.yml`, `.services.yml`, or `config/` — this is a pure editor-UI plugin.

## What it provides
- CKEditor 5 plugin definition in `ckeditor5_dark_mode.ckeditor5.yml`: plugin `darkMode.Dark`, toolbar item `darkMode` (label "Dark Mode"), `elements: false` (registers no HTML tags/attributes — does not change stored markup).
- Drupal asset libraries in `ckeditor5_dark_mode.libraries.yml`: `dark_mode` (loads `js/build/darkMode.js` + `css/dark.css`) and `dark_mode.admin` (`css/dark.admin.css`).
- JS plugin classes in `js/ckeditor5_plugins/darkMode/src/`: `Dark` (`dark.js`, requires `DarkUI`) and `DarkUI` (`darkui.js`, registers the `darkMode` button and the toggle behavior). Bundled build: `js/build/darkMode.js`.
- Icons: `icons/dark.svg`, `icons/light.svg`.

## Operate
- Enable the module, then add the Dark Mode button to a text format's CKEditor 5 toolbar at `/admin/config/content/formats`. No other configuration.

## Solution docs
- Plugin behavior, toolbar wiring, and CSS: [agent/plugins/dark-mode.md](plugins/dark-mode.md)
