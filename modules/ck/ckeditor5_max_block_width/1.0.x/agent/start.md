<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 max block width (ckeditor5_max_block_width) — agent index

A **CKEditor 5 toolbar dropdown** that sets a block's rendered width — Regular / Wide / Full —
by toggling one of two fixed CSS classes (`max-w-wide`, `max-w-full`) on tables, images and
media. Package `Custom`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0-alpha2.

- **The CKEditor 5 plugin, its options, allowed HTML, CSS, and how to enable it** →
  [plugins/max-width.md](plugins/max-width.md)

## What it actually is (from source)

- **CKEditor 5 plugin only.** Declared in `ckeditor5_max_block_width.ckeditor5.yml`
  (`ckeditor5_max_block_width_block_width`): JS plugin `maxWidth.MaxWidth`, one toolbar item
  `maxWidth` (label "Block width"), editor library `ckeditor5_max_block_width/ckeditor5_max_block_width`
  + `admin`, and allowed `elements: <table class>`, `<img class>`, `<drupal-media class>`.
- **No PHP surface beyond one hook.** `ckeditor5_max_block_width.module` has only
  `hook_page_attachments()`, attaching the front-end library `ckeditor5_max_block_width/styles`.
  **No routes, permissions, services, config forms, config schema, entities, or Drush.**
- **JS** `js/ckeditor5_plugins/maxWidth.js` defines `MaxWidth` (requires `MaxWidthEditing` +
  `MaxWidthUI`) and a `MaxWidthCommand`. The command's value is a closed set:
  `''` (Regular), `'max-w-wide'`, `'max-w-full'` — see `OPTIONS`/`LABELS`.
- **CSS.** `css/max-width.css` (front end) + `css/editor.css` (in-editor) define widths as
  custom properties: `--max-w-regular: 740px`, `--max-w-wide: 1032px`, `--max-w-full: 100%`.
  Front-end styles apply under a `.max-w-container` wrapper.

## Mechanism (round-trip)

- **Model:** `MaxWidthEditing.init()` extends `$block`, `$blockObject` and `imageInline` with a
  `maxWidth` attribute, and adds an attribute check that blocks it on `paragraph`/`heading1..6`
  (`EXCLUDED_BLOCKS`).
- **Downcast** (`attribute:maxWidth`): removes both width classes, then adds
  `data.attributeNewValue` — which is only ever `max-w-wide` or `max-w-full`.
- **Upcast** (element listener, priority lowest): reads the view element's `class` string and,
  via `maxWidthFromClassString`, maps it back to `max-w-full`/`max-w-wide` only (fixed tokens).
- **UI** (`MaxWidthUI`): a dropdown built from `OPTIONS`; selecting an item calls
  `editor.execute('maxWidth', { value })`.

## Libraries

- `ckeditor5_max_block_width` (JS plugin + editor CSS, deps `core/ckeditor5`)
- `admin` (editor CSS only), `styles` (front-end `max-width.css`)

## Dependencies

Core `ckeditor5` (via the library). No contrib/module dependencies; no `composer.json` require.
