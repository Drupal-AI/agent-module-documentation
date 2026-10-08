<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Div as Block (ckeditor_div_as_block) — agent index

A **JS-only CKEditor 5 plugin** that makes `<div class="ckeditor-template …">` elements
behave as selectable **block containers** (widgets) inside the editor instead of inline
runs, round-tripping their `class` / `id` / inline `style` through the model. Built to work
around upstream CKEditor issue [#6462](https://github.com/ckeditor/ckeditor5/issues/6462)
and paired with **CKEditor 5 Plugin Pack Templates**. No PHP, no routes, no services, no
permissions, no config entities. Package `CKEditor`. Core `^10.4 || ^11 || ^12`. License
GPL-2.0-or-later. Installed **1.0.0** (version dir `1.0.x`). The project page notes it was
built with LLM assistance and is minimally maintained.

## Dependencies

- Drupal module: **`ckeditor5_plugin_pack:ckeditor5_plugin_pack_templates`** (required, from
  `.info.yml`) — the Templates submodule of `ckeditor5_plugin_pack`, which supplies the
  `ckeditor-template` class the plugin keys off. No `composer.json` in the module (no PHP
  package requirements); on drupal.org it is `drupal/ckeditor_div_as_block`.
- No PHP libraries. JS build-time (`package.json`, dev only): `ckeditor5 ~48.0.0`, webpack,
  terser.

## What it provides (from source)

Everything is client-side. There is **no `.module`, `.services.yml`, `.routing.yml`,
`.permissions.yml`, `config/`, `templates/`, or `src/`** — only the plugin definition,
library, and JS.

- **CKEditor 5 plugin definition** `ckeditor_div_as_block.ckeditor5.yml`:
  - id `ckeditor_div_as_block_plugin` → CKEditor plugin `divAsBlock.DivAsBlock`.
  - `drupal.label: 'Div as Block'`, `library: ckeditor_div_as_block/div_as_block`.
  - `drupal.elements: ['<div>', '<div class>']` — this is the **only** HTML this plugin
    adds to a text format's allowed tags when enabled. It does **not** add `<div id>`,
    `<div style>`, or arbitrary attributes to the server-side allowed list.
- **Library** `ckeditor_div_as_block/div_as_block` (`.libraries.yml`) → the minified bundle
  `js/build/divAsBlock.js` (`preprocess: false, minified: true`).
- **JS source** `js/ckeditor5_plugins/divAsBlock/src/` (`index.js`, `divasblock.js`,
  `divasblockediting.js`), built via `webpack.config.js` (externals map `ckeditor5/src/*`
  to the runtime CKEditor5 DLL).

## How it works (JS)

`DivAsBlock` (`divasblock.js`) just `requires` `DivAsBlockEditing`. The real logic is in
`divasblockediting.js`, whose `init()` runs three steps; it `requires` core
`GeneralHtmlSupport` (GHS) and `Widget`:

1. **`_configureGhs()`** — grabs the GHS `DataFilter` and calls `allowElement('div')` plus
   `allowAttributes({ name: 'div', attributes: true, classes: true, styles: true })`. This
   is an **editing-time** widening only; the authoritative boundary on save is Drupal's text
   format filter (see security note below).
2. **`_registerSchema()`** — registers a model element `blockDiv` (`inheritAllFrom:
   '$container'`, `isObject: true`, `allowAttributes: ['htmlDivAttributes']`, allowed in
   `$root` and nested in `blockDiv`).
3. **`_defineConverters()`**:
   - **Upcast** (`priority: highest`) on `element:div`: **only** divs whose `class` matches
     `\bckeditor-template\b` are converted to `blockDiv`; all other divs are left to GHS.
     It captures `class` (all classes), `id`, and inline `style` (parsed `k:v` pairs) into
     `htmlDivAttributes`. No other attributes and no event handlers are captured.
   - **dataDowncast** (what is saved): rebuilds a plain `<div>` with `class`, the captured
     `id`, and a reserialized `style` string.
   - **editingDowncast**: renders an editable `<div class="ck-div-block …">` wrapped with
     `toWidget()` (selection handle, label "div block"), then restores
     `contenteditable="true"` so content inside stays editable.

Net effect: template divs become selectable block widgets in the editor; their class/id/style
survive a round-trip. Divs without `ckeditor-template` are untouched by this plugin.

## Configuration

**None.** No settings form, no config schema, no config entities. Behavior activates by
enabling the "Div as Block" plugin's library on a CKEditor 5 text format (via the format's
CKEditor 5 toolbar/plugin settings). README confirms "This module has no configuration."

## Security

Reviewed clean (Danger 0). The plugin adds only `<div>` / `<div class>` to a format's
allowed HTML; the client-side GHS `attributes: true` widening is bounded on save by Drupal's
`filter_html`, and the converters round-trip only class/id/style (never `on*` handlers or
`<script>`). No PHP, routes, permissions, uploads, SSRF/TLS/SQL surface. Behavior on an
unrestricted (Full HTML) format reflects the admin's own trust decision, not a module flaw.

## Source map

- `ckeditor_div_as_block.info.yml` — metadata, dependency.
- `ckeditor_div_as_block.ckeditor5.yml` — plugin definition, label, allowed elements.
- `ckeditor_div_as_block.libraries.yml` — the `div_as_block` JS library.
- `js/ckeditor5_plugins/divAsBlock/src/{index,divasblock,divasblockediting}.js` — plugin.
- `js/build/divAsBlock.js` — built bundle (loaded at runtime).
- `webpack.config.js`, `package.json` — build tooling (dev only).
- `README.md` — introduction, requirements, "no configuration".
