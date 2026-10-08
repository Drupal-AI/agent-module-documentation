<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Description List (ckeditor_descriptionlist) — agent index

A CKEditor 5 plugin that adds a **"Description list"** toolbar button which inserts an HTML
**`<dl>`** widget with `<dt>` (term) / `<dd>` (description) pairs. On a non-collapsed selection it
splits the text into lines and turns each `Term: definition` line into a `<dt>`/`<dd>` pair
(splitting on the first `:`). Package `CKEditor`. Depends on core **`ckeditor5`**. Core requirement
`^10.5 || ^11` (composer.json requires core `^10.5 || ^11`). License GPL-2.0-or-later. Version 3.0.0.

- **Install/enable, adding the button to a format, the produced markup, and the allowed-HTML
  (`elements`) list** → [ckeditor5/description-list.md](ckeditor5/description-list.md)

## What it actually is

- A CKEditor 5 plugin declared in `ckeditor_descriptionlist.ckeditor5.yml` as
  `ckeditor_descriptionlist_descriptionlist`: CKEditor 5 plugins **`descriptionList.DescriptionList`**
  and **`widget.Widget`**; Drupal label **"CKEditor 5 Description List"**; library
  `ckeditor_descriptionlist/description_list`; `admin_library`
  `ckeditor_descriptionlist/admin.description_list`.
- **One toolbar item:** `toggleDescriptionList` (label **"Description list"**). No dropdown, no
  balloon — a plain `ButtonView`.
- **`elements: [<dl>, <dd>, <dt>]`** — the only HTML the plugin advertises/permits. No attributes,
  no `style`, no wildcard.
- No routes, no permissions, no `.services.yml`, no Drush, no config object, no config schema, no
  submodules. Pure editor plugin.

## The JS plugin (`js/plugins/descriptionList/src/index.js`, built to `js/dist/descriptionList.js`)

- Exports `{ DescriptionList }`; class `DescriptionList extends Plugin`, `pluginName =
  'DescriptionList'`, `requires = [Widget]`.
- **Schema** (`init()`): registers model elements `dl` (`allowWhere: '$block'`, `isBlock`), `dt` and
  `dd` (`allowIn: 'dl'`, `allowContentOf: '$block'`, `isLimit`). Also extends `$root` with
  `allowContentOf: '$block'` and `$text` with `allowAttributes: ['bold']`.
- **Conversion:** upcast and downcast `elementToElement` for `dl`/`dt`/`dd`; the `dl` downcast wraps
  it as a widget via `toWidget(...)` with label "Description list".
- **Button:** `editor.ui.componentFactory.add('toggleDescriptionList', …)` builds a `ButtonView`
  (icon = inline SVG, `tooltip: true`, `withText: false`). It disables itself while
  `SourceEditing.isSourceEditingMode` is on (if that plugin is present).
- **Execute:** creates a `<dl>`. If the selection is not collapsed, it walks the range, groups items
  into lines (breaking on `paragraph`/`br`/`softBreak`), and for each line makes a `dt`+`dd`,
  putting the text before the first `:` in `dt` and the text after it in `dd` (no colon → all text
  in `dt`). It removes the selected range and inserts the new `<dl>`, then selects it.

## PHP

- `src/Plugin/CKEditor5Plugin/DescriptionList.php` — `DescriptionList extends CKEditor5PluginDefault`
  with a `@CKEditor5Plugin` annotation (same id `ckeditor_descriptionlist_descriptionlist`, plugin
  `descriptionList.DescriptionList`, elements `<dl>/<dd>/<dt>`). No custom PHP logic; the
  `.ckeditor5.yml` is the authoritative, fuller definition (it also lists `widget.Widget`, the
  toolbar item, and libraries).

## Assets

- `ckeditor_descriptionlist.libraries.yml`: `description_list` (JS `js/dist/descriptionList.js`,
  depends on `ckeditor5/ckeditor5`) and `admin.description_list` (CSS
  `css/ckeditor_descriptionlist.admin.css`, which sets the toolbar-button icon from
  `icons/description-list.svg`).
