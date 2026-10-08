<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 editor plugin — schema, converters, command, button

Source: `assets/js/ckeditor5_plugins/spoiler/src/` (ES modules), bundled by
`webpack.config.js` into `assets/js/build/spoiler.js` (loaded minified via the
`ckeditor5_spoiler/spoiler` library). Built on `ckeditor5 ~34.1.0`
(`package.json`).

## Declaration (`ckeditor5_spoiler.ckeditor5.yml`)

```yaml
ckeditor5_spoiler_spoiler:
  ckeditor5:
    plugins:
      - spoiler.Spoiler          # JS global from index.js default export
  drupal:
    label: CKEditor5 Spoiler
    library: ckeditor5_spoiler/spoiler         # editor build + frontend
    admin_library: ckeditor5_spoiler/admin.spoiler  # toolbar button icon CSS
    toolbar_items:
      Spoiler:
        label: Spoiler
    elements:                     # GHS: what the plugin is allowed to emit
      - <div>
      - <div class>
      - <p>
      - <p class>
```

`elements` is the full set of tags/attributes this plugin adds to the text format's
allowed HTML: bare `div` and `p`, each optionally with a `class`. It does **not**
declare `attributes: true`, `style`, id, data-\* or any other tag — so the widening is
minimal and no inline styling is permitted through this plugin.

## Plugin structure (JS)

- `index.js` — default export `{ Spoiler }` (the `spoiler.Spoiler` referenced above).
- `spoiler.js` — `Spoiler extends Plugin`, `requires = [SpoilerEditing, SpoilerUI]`.
  In `afterInit()` it wires a **click handler in the editing view**: clicking a
  `.spoiler-toggle` div flips `show-icon`/`hide-icon` on the toggle and
  `hidden`/`show` on the sibling `.spoiler-content` (in-editor preview of the collapse).
- `spoilerui.js` — `SpoilerUI` registers the toolbar `ButtonView` `Spoiler` (icon
  `assets/icons/spoiler.svg`); clicking it runs `editor.execute('createSpoiler')`.
- `createspoilercommand.js` — `CreateSpoilerCommand`: `execute()` inserts a new spoiler
  structure; `refresh()` enables the command only where a `spoiler` is allowed.
- `spoilerediting.js` — schema + converters (below).

## Model schema (`spoilerediting.js` `_defineSchema`)

| model element | flags | contains |
|---|---|---|
| `spoiler` | `isObject`, `allowWhere: '$block'` | the whole widget |
| `spoilerTitle` | `isLimit`, `allowIn: spoiler`, `allowContentOf: $block` | title text + toggle |
| `spoilerToggle` | `isLimit`, `allowIn: spoilerTitle` | the click target / icon |
| `spoilerContent` | `isLimit`, `allowIn: spoiler`, `allowContentOf: $root` | the hideable body (block content) |

## Converters (`_defineConverters`)

- **upcast** (HTML → model): `div.spoiler` → `spoiler`, `div.spoiler-title` →
  `spoilerTitle`, `div.spoiler-toggle.hide-icon` → `spoilerToggle`,
  `div.spoiler-content` → `spoilerContent`. This is what makes CKEditor 4 spoiler
  markup (same class structure) load correctly.
- **dataDowncast** (model → saved HTML): mirrors the same `div` + class structure.
- **editingDowncast** (model → in-editor view): `spoiler` becomes a widget
  (`toWidget`, selection handle); `spoilerTitle` and `spoilerContent` become
  editable regions (`toWidgetEditable`); `spoilerToggle` a plain container.

## Markup produced (verified by the module's own functional test)

Inserting a spoiler and saving yields:

```html
<div class="spoiler">
  <div class="spoiler-title">Spoiler title<div class="spoiler-toggle hide-icon">&nbsp;</div></div>
  <div class="spoiler-content"><p>&nbsp;</p></div>
</div>
```

The title text ("Spoiler title") and body are normal editable rich text — they are
converted as text/block content through CKEditor's standard escaping, not injected into
any attribute or style. The only class values written are the fixed `spoiler`,
`spoiler-title`, `spoiler-toggle hide-icon`, `spoiler-content` strings from the
converters.

## Requirement for markup to survive

The saved `div`/`p` + `class` markup only persists if the text format allows it. Adding
the Spoiler button contributes the `elements` above to a format that uses the
`ckeditor5` filter-aware pipeline; on a format with `filter_html` (Limited HTML) the
allowed-tags list is extended accordingly. Also enable the **`filter_spoiler`** filter
so the frontend toggle assets load — see
[filter-and-frontend.md](filter-and-frontend.md).
