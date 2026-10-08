<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 horizontal line (ckeditor5_horizontal_line) — agent index

Registers a **Horizontal Line** toolbar button for CKEditor 5 that inserts an `<hr>` divider.
Thin Drupal wrapper around the upstream `@ckeditor/ckeditor5-horizontal-line` plugin
(`horizontalLine.HorizontalLine`). Version **1.1.2**, core `^9 || ^10 || ^11`.

## What it provides
- **CKEditor 5 plugin definition** `ckeditor5_horizontal_line_horizontalline`
  (`ckeditor5_horizontal_line.ckeditor5.yml`) — toolbar item `horizontalline`, label "Horizontal Line".
- **Libraries** (`ckeditor5_horizontal_line.libraries.yml`): `horizontalline` (built JS
  `js/build/horizontal-line.js` + theme CSS), `admin.horizontalline` (toolbar-button icon CSS).
- **No** PHP services/routes/permissions/hooks (`.module` is an empty file), **no** config schema,
  **no** submodules, **no** entities.

## Dependencies
- `drupal:ckeditor5` (core). Library depends on `core/ckeditor5`.

## Key facts for agents
- `elements: false` in the plugin YAML → the module does **not** auto-add `<hr>` to a format's
  allowed HTML. On a restricted "Limit allowed HTML tags" filter, add `<hr>` manually or the divider
  is stripped on save.
- Enabling the module only makes the button available; a site builder must drag it onto each text
  format's active toolbar at `admin/config/content/formats/manage/<format>`.
- Source JS entry: `js/ckeditor5_plugins/horizontalline/src/index.js` (re-exports upstream
  `HorizontalLine`); the shipped `js/build/horizontal-line.js` is the compiled bundle.

## Solution docs
- [Add & operate the Horizontal Line CKEditor plugin](plugins/horizontalline.md)
