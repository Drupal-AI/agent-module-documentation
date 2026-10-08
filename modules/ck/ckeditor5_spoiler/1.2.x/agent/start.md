<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 Spoiler (ckeditor5_spoiler) — agent index

A CKEditor 5 plugin that adds a **spoiler / collapsible widget** to the editor: a
`div.spoiler` block with a clickable title bar (`div.spoiler-title` + toggle icon
`div.spoiler-toggle`) and a hideable body (`div.spoiler-content`). On the rendered
page a small behavior toggles the body's `display` when the title is clicked. It is a
**display toggle, not access control** — the hidden content is fully present in the
page HTML source. Compatible with the old CKEditor 4 spoiler markup. Package
`CKEditor`. Core `^10.2 || ^11 || ^12`. License GPL-2.0-or-later. Installed **1.2.0**
(version dir `1.2.x`).

## Dependencies

- Drupal module: **`ckeditor5`** (core), from `.info.yml`. Nothing else.
- No Composer/PHP library requirements. (A build-time JS dep
  `@vndywhat/ckeditor5-spoiler` appears in `package.json` but is only used to build
  `assets/js/build/spoiler.js`; it is not a runtime requirement.)

## What it provides (from source)

- **CKEditor 5 plugin** `ckeditor5_spoiler_spoiler` (`ckeditor5_spoiler.ckeditor5.yml`):
  JS plugin `spoiler.Spoiler`, toolbar item **`Spoiler`**, admin/editor libraries
  `ckeditor5_spoiler/spoiler` + `admin.spoiler`. There is **no PHP CKEditor5Plugin
  class** — this is a pure-JS plugin with a static declaration; it has no
  per-text-format settings form.
- **GHS / allowed elements** (declared under `drupal.elements` in the `.ckeditor5.yml`):
  `<div>`, `<div class>`, `<p>`, `<p class>`. So enabling the button widens the
  format's allowed HTML by exactly these — plain `div`/`p` plus a `class` attribute on
  each. **No `attributes: true`, no `style`, no other tags.**
- **Text-format filter** `filter_spoiler` (`src/Plugin/Filter/FilterSpoiler.php`,
  `TYPE_TRANSFORM_IRREVERSIBLE`, "Spoiler support"): does **not** alter the text — it
  only attaches the frontend library `ckeditor5_spoiler/spoiler.for.users` when the
  text contains the substring `spoiler`. See
  [filter-and-frontend.md](filter-and-frontend.md).
- **Frontend behavior** `assets/js/spoiler.js` (library `spoiler.for.users`): a
  `Drupal.behaviors` that, guarded by `core/once`, toggles the next sibling's
  `style.display` and swaps the `show-icon`/`hide-icon` classes when a
  `div.spoiler-title` is clicked. CSS in `assets/css/spoiler.css`.
- **Editor plugin JS** under `assets/js/ckeditor5_plugins/spoiler/src/` (built into
  `assets/js/build/spoiler.js`): schema, upcast/downcast converters, the `createSpoiler`
  command and toolbar button. See [editor-plugin.md](editor-plugin.md).
- **Install hook** `ckeditor5_spoiler_update_11001` (`.install`): enables the
  `filter_spoiler` filter on any text format whose CKEditor 5 toolbar already contains
  the `Spoiler` item.
- **No** routes, permissions, services, controllers, blocks, config entities, or config
  schema. No configuration page (`configure: null`).

## Solution docs

- **Editor plugin (JS): schema, converters, command, button, produced markup** →
  [editor-plugin.md](editor-plugin.md)
- **`filter_spoiler` filter, libraries, frontend toggle behavior, install hook, setup**
  → [filter-and-frontend.md](filter-and-frontend.md)
- **Task-oriented overview / capabilities** → [../usage.md](../usage.md)
