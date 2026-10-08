<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The CKEditor 5 plugin (columnLayout)

Client-side plugin that adds the **Columns** widget. Definition in
`ck5_column_layout.ckeditor5.yml`; implementation in `js/ck5-column-layout.js`
(`CKEditor5.columnLayout.columnLayout`, extends CKEditor 5 `Plugin`, `requires: ['Widget']`).

## Drupal plugin definition (`*.ckeditor5.yml`)

- `ckeditor5.plugins: [columnLayout.columnLayout]` — the JS class.
- `drupal.library: ck5_column_layout/editor`, `drupal.admin_library: ck5_column_layout/admin`.
- `drupal.toolbar_items.columnLayout.label: Columns`.
- `drupal.elements` (what the plugin adds to the format's allowed HTML): only
  `<div class="cl-flex-row" data-xs data-sm data-md data-lg contenteditable="true">` and
  `<div class="cl-flex-col" contenteditable="true">`. Purely structural div markup — a fixed
  class plus the four breakpoint data-attributes; no scriptable tags/attributes are whitelisted.
- `drupal.conditions.filter: filter_ck5_column_layout` — the toolbar button is offered only on
  formats where that filter is enabled (see [../filters/filter.md](../filters/filter.md)).

Libraries (`ck5_column_layout.libraries.yml`): `editor` = `js/ck5-column-layout.js` +
`css/ck5-column-layout.css`, deps `core/ckeditor5`, `core/drupal.ajax`, `core/drupal.dialog.ajax`,
`core/once`, `core/jquery`. `admin` = `css/ck5-column-layout.admin.css`.

## Editor model & converters (JS)

- Registers two model elements: `layoutContainer` (`isObject`, `allowWhere: '$block'`, allows
  attributes `data-xs/sm/md/lg`) and `flexItem` (`isLimit`, `allowIn: layoutContainer`,
  `allowContentOf: '$root'`, selectable).
- **dataDowncast** (saved HTML): `layoutContainer` → `div.cl-flex-row` with `data-xs/sm/md/lg`
  (defaults 1/1/2/3) plus two empty `span[data-cl-marker]` (`row-controls`, `add-col`); `flexItem`
  → `div.cl-flex-col` with a `span[data-cl-marker="item-del"]`. These marker spans are what the
  server-side filter / presave hook remove (see filter doc).
- **editingDowncast** (in-editor view): builds the widget with UI control bars (Settings/Delete,
  Add Column, per-column delete) **only when `hasPermission`**; wrapped via `toWidget` /
  `toWidgetEditable`.
- **upcast** (loading HTML): `div.cl-flex-row` → `layoutContainer` (reads data-attrs, defaults
  1/1/2/3), `div.cl-flex-col` → `flexItem`; a high-priority `element:span` handler consumes any
  `span[data-cl-marker]` so leftover markers are not re-imported as content.
- Attribute live-sync: `data-xs/sm/md/lg` downcast attributeToAttribute on `layoutContainer`.

## Permission gating & the modal round-trip (JS)

- Reads `drupalSettings.ck5_column_layout` (set by `ElementTokenAttachment`, see
  [../config/settings-modal.md](../config/settings-modal.md)): `hasPermission` (bool) and `token`
  (CSRF token). The toolbar button factory returns nothing when `!hasPermission`, and all in-editor
  control bars/buttons are rendered only when `hasPermission` — so a user without the permission
  sees no Columns UI.
- Clicking **Settings** opens a Drupal AJAX **modal** at
  `admin/ck5-column-layout/settings?xs=..&sm=..&md=..&lg=..&token=<token>` via `Drupal.ajax(...)`.
  The modal form's AJAX submit fires a jQuery `columnLayoutApply` event on `body` carrying the four
  values; a `once('columnLayoutInit','body')` listener writes them back onto the selected
  `layoutContainer` with `writer.setAttribute`.
- **Add Column** appends a `flexItem` (containing a `paragraph`); **Delete** buttons remove the
  `flexItem` or the whole `layoutContainer` (`window.confirm` for the section delete).
- Toolbar button `execute` inserts a new `layoutContainer` (defaults 1/1/2/3) with one `flexItem`.

Icon is an inline SVG (`<path>` grid glyph) — static markup, no dynamic content.
