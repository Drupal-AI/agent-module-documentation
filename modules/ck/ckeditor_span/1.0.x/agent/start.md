<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Span (ckeditor_span) — agent index

A small **CKEditor 5 plugin** that adds a **Span** toolbar button letting editors wrap the selected
inline text in a `<span>` and set its `class`, `id`, `lang`, `style` (raw CSS) and `title`
attributes from a balloon form. Purely a client-side editor plugin — **no PHP, no routes, no
services, no permissions, no config schema, no install hooks, no composer.json**. Package `CKEditor`.
Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Installed **1.0.5** (version dir `1.0.x`).

## Dependencies

- Drupal module: **`ckeditor5`** (core) — the only dependency (`.info.yml`, `.libraries.yml`).
- No third-party PHP or JS runtime libraries. Build-time only (`package.json`): `ckeditor5 ~47`,
  webpack, terser, raw-loader — used to compile `js/build/SpanPlugin.js`.

## What it provides (from source)

- **CKEditor 5 plugin definition** `ckeditor_span.ckeditor5.yml`:
  - CKEditor plugin `SpanPlugin.SpanManager`; Drupal `label: Span`.
  - Editor library `ckeditor_span/ckeditor_span`; admin library `ckeditor_span/admin.ckeditor_span`.
  - `toolbar_items.SpanManager` (button label "Span").
  - **`elements:` allow-list = `<span>` and `<span class="simple-box-description">` only.** This is
    the HTML the plugin declares to Drupal's `filter_html`. It does **not** declare `<span style>`,
    `<span id>`, `<span lang>`, `<span title>`, or arbitrary classes. (See "Attribute filtering".)
- **Libraries** (`.libraries.yml`): `ckeditor_span` (JS `js/build/SpanPlugin.js` + `css/ckeditor_span.admin.css`,
  depends `core/ckeditor5`); `admin.ckeditor_span` (the same CSS, loaded on the text-format config form
  to style the toolbar icon).
- **Assets**: `icons/span.svg` (toolbar icon), `css/ckeditor_span.admin.css` (icon background + an
  editor-only `span { background-color: bisque }` visual hint + `.ui-snippet-hidden` helper).
- **JS source** `js/ckeditor5_plugins/SpanPlugin/src/` (built to `js/build/SpanPlugin.js`):
  - `index.js` — exports `SpanManager`.
  - `spanmanager.js` — `SpanManager` plugin (`pluginName: 'SpanManager'`), requires `SpanEditing`
    + `SpanManagerUI`.
  - `spanediting.js` — registers a `span` **model element** (inline, content), extends `$text` to
    allow `class/title/id/lang/style`; registers commands `addSpan` (`SpanCommand`) and `removeSpan`
    (`SpanRemoveCommand`); upcast/downcast converters (downcast copies all set attributes to the view
    span via `getAttrsData`); an Enter-key handler that unwraps a span on Enter.
  - `spancommand.js` — `SpanCommand.execute(settings)` wraps the selection in a `span` (or updates an
    existing one) with `{class, id, lang, style, title}` from the form.
  - `spanremovecommand.js` — `SpanRemoveCommand.execute()` removes the enclosing span, re-inserting
    its text.
  - `spanmanagerui.js` — registers the `spanManager` button + a `ContextualBalloon` form; wires
    Save→`addSpan`, Remove→`removeSpan`, Cancel/click-outside→hide; prefills the form from an
    existing span.
  - `spanmanagerview.js` — the balloon form `View`: labeled text inputs Content, ID, Stylesheet class
    name, Language Code, Raw style, Advisory title + Save/Cancel/Remove buttons.
  - `utils.js` — helpers (`getClosestSelectedSpanElement`, `getAttrsData`, `checkCanBeSpan`, …).
    Contains dead/experimental code (`console.log`, commented blocks, an unreachable second `return`).

## Setup (no config page)

No settings route. Enable the module, then per text format at
`/admin/config/content/formats` (Text formats and editors): edit a CKEditor 5 format, drag the
**Span** button into the active toolbar, save. Editors select text → **Span** → fill the balloon form.
For the entered attributes to survive saving, the format's **Limit allowed HTML tags** filter must
permit them (see below).

## Attribute filtering (important for behaviour, not a module defect)

The editing UI lets an editor type any `class`, `id`, `lang`, `style` (raw CSS) and `title`. But the
plugin's declared `elements` list only whitelists `<span>` and `<span class="simple-box-description">`.
On a text format that runs **Limit allowed HTML tags and correct faulty HTML** (`filter_html`), any
attribute the plugin has not declared (`style`, `id`, `lang`, `title`, and classes other than
`simple-box-description`) is **stripped on output**. To actually keep e.g. a `style` attribute, an
admin must widen that format's allowed-HTML string to include `<span style>` (or disable filtering).
So the raw-CSS/`style` free-text field is only effective on formats an admin has deliberately loosened
or left unfiltered — which are, by Drupal convention, restricted to trusted roles.

## Notes / gotchas

- The `data.json` value `provides_config_schema` is **false** (corrected): there is no `config/`
  directory and no `*.schema.yml`; the `.ckeditor5.yml` is a plugin definition, not config schema.
- `provides_permissions: false`, `configure: null`, `provides_plugin_types: []` — accurate; the module
  ships an editor plugin instance, not a Drupal plugin type.
- The `<span class="simple-box-description">` sample class appears copied from CKEditor's SimpleBox
  tutorial and is otherwise unused; the editor visual `background-color: bisque` is editor-only CSS.
