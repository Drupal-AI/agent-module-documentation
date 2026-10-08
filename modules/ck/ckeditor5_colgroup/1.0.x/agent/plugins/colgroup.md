<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Colgroup CKEditor 5 plugin

Source: `js/ckeditor5_plugins/colgroupPlugin/src/index.js` (built to `js/build/colgroupPlugin.js`).
Declared in `ckeditor5_colgroup.ckeditor5.yml`; library in `ckeditor5_colgroup.libraries.yml`.

## Why it exists
Core CKEditor 5 only understands `<colgroup>`/`<col>` when `table.TableColumnResize` is enabled. With
that plugin off, the editor schema has no place for these elements, so they are dropped on edit/save.
This plugin registers the missing model schema + converters so the elements round-trip. (Upstream bug
#3397556; the module's `tests/src/FunctionalJavascript/UseCaseTest.php` demonstrates the drop-without-it
behavior and is designed to fail if core ever fixes it, at which point the module is obsolete.)

## The plugin class (`Colgroup extends Plugin`)
`init()` calls `_defineSchema()` then `_defineConverters()`.

`_defineSchema()` — on `editor.model.schema`:
- `schema.register('tableColumnGroup', { allowIn: 'table', allowAttributes: ['colSpan'], isLimit: true })`
- `schema.register('tableColumn', { allowIn: 'tableColumnGroup', allowAttributes: ['colSpan'], isLimit: true })`

`_defineConverters()` — on `editor.conversion`:
- `elementToElement({ model: 'tableColumnGroup', view: 'colgroup' })`
- `elementToElement({ model: 'tableColumn', view: 'col' })`
- `attributeToAttribute({ model: {name:'tableColumn', key:'colSpan'}, view: {name:'col', key:'span'} })`
- `attributeToAttribute({ model: {name:'tableColumnGroup', key:'colSpan'}, view: {name:'colgroup', key:'span'} })`

That is the entire behavior: two structural elements and the `span` attribute. It adds no toolbar
button, no command, no `style`/event/other attributes.

## Drupal plugin declaration (`ckeditor5_colgroup.ckeditor5.yml`)
```
ckeditor5_colgroup_colgroup:
  ckeditor5:
    plugins:
      - colgroupPlugin.Colgroup
  drupal:
    label: Colgroup
    library: ckeditor5_colgroup/colgroup
    elements:
      - <colgroup>
      - <colgroup span>
      - <col>
      - <col span>
```
The `elements` list is what CKEditor 5 reports to Drupal's filter integration — only the structural
`colgroup`/`col` tags and their `span` attribute. It does not request `style`, `on*`, `class`, or any
other attribute.

## Install / enable
1. `drush en ckeditor5_colgroup` (or via the Extend UI). Requires core `ckeditor5`.
2. Ensure the text format uses the **CKEditor 5** editor and does **not** rely on TableColumnResize for
   colgroup support.
3. There is no settings page. Enable the feature by adding the **"Colgroup"** plugin to the format's
   configuration (Administration › Configuration › Content authoring › Text formats and editors →
   the format). Adding the Source Editing plugin lets authors insert/edit the raw markup.

## What actually persists (the filter boundary)
This plugin only affects the in-editor model. Persistence is governed by:
- **`filter_html` allowed_html** on the text format. To keep the elements, include e.g.
  `<colgroup span class> <col span class>` (as the module's `UseCaseTest` fixture does).
- **Source Editing `allowed_tags`** on the CKEditor 5 editor config, e.g.
  `<colgroup class> <col class>`.
If the format strips `colgroup`/`col`, they will not survive regardless of this plugin. The module does
not widen or bypass filtering — it only adds structural schema, so the format's allowed-HTML remains the
security boundary.

## Not provided
No routes, permissions, services, hooks, PHP classes, config entities/schema, Drush commands, or
submodules. Nothing to review server-side.
