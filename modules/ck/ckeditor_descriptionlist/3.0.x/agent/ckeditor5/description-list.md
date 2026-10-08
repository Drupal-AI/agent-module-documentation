<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Description list button (CKEditor 5)

Give editors a toolbar button that inserts an HTML **description list** — a `<dl>` holding paired
`<dt>` (term) and `<dd>` (description) children. On a text selection the plugin turns each line into
a `<dt>`/`<dd>` pair, splitting `Term: definition` on the first colon.

## Install & enable

```
composer require 'drupal/ckeditor_descriptionlist:^3.0'
drush en ckeditor_descriptionlist -y
```

`ckeditor_descriptionlist.info.yml` declares `dependencies: [drupal:ckeditor5]`, so core's
**CKEditor 5** module is required/auto-enabled. Core requirement `^10.5 || ^11`.

## Add the button to a text format

The plugin is defined in `ckeditor_descriptionlist.ckeditor5.yml` as
`ckeditor_descriptionlist_descriptionlist`, exposing one `toolbar_items` entry,
`toggleDescriptionList` (label **"Description list"**).

1. *Structure → Text formats and editors* (`/admin/config/content/formats`) → edit a **CKEditor 5**
   format (permission `administer filters`).
2. Drag the **Description list** button from *Available buttons* into the **Active toolbar**.
3. Save. In that editor, click the button (optionally after selecting text) to insert a `<dl>`.

Per-format: repeat for each format that should offer the button. Only toolbars you edit get it.

## What markup it produces

- **Empty insert** (collapsed selection): a `<dl>` widget is inserted at the cursor and selected.
- **On a selection**: `index.js` `execute()` walks the selected range, groups items into lines
  (breaking on `paragraph` / `br` / `softBreak` model nodes), and for each line creates a `<dt>` and
  a `<dd>`. The text **before the first `:`** goes into the `<dt>` (trimmed), the text **after it**
  into the `<dd>` (trimmed). A line with no colon puts all its text into the `<dt>` only. The
  original selection is removed and replaced by the new `<dl>`.
- Result is plain `<dl><dt>…</dt><dd>…</dd>…</dl>` — **no** attributes (`class`, `style`, `id`) are
  ever written.

## How it works internally (`js/plugins/descriptionList/src/index.js`)

CKEditor 5 works on a model, not the DOM. The `DescriptionList` plugin (`requires: [Widget]`):

- **Schema** — registers model elements `dl` (`allowWhere: '$block'`, `isBlock: true`), `dt` and
  `dd` (`allowIn: 'dl'`, `allowContentOf: '$block'`, `isLimit: true`). It also does
  `schema.extend('$root', { allowContentOf: '$block' })` (so a header need not be wrapped in a `<p>`)
  and `schema.extend('$text', { allowAttributes: ['bold'] })`.
- **Conversion** — `upcast` and `downcast` `elementToElement` for each of `dl`/`dt`/`dd`. The `dl`
  **downcast** builds a container element and wraps it with `toWidget(dl, viewWriter, { label:
  'Description list' })`, so the list is an editable widget in the editing view.
- **Button** — `editor.ui.componentFactory.add('toggleDescriptionList', …)` returns a `ButtonView`
  (inline SVG icon, `tooltip: true`, `withText: false`). If the `SourceEditing` plugin is present,
  the button is disabled while source-editing mode is active
  (`button.isEnabled = !sourceEditing.isSourceEditingMode`).

The built bundle shipped/loaded is `js/dist/descriptionList.js` (library
`ckeditor_descriptionlist/description_list`, depends on `ckeditor5/ckeditor5`).

## How the `<dl>/<dt>/<dd>` tags survive `filter_html`

`ckeditor_descriptionlist.ckeditor5.yml` declares:

```yaml
elements:
  - <dl>
  - <dd>
  - <dt>
```

This is the standard CKEditor 5 `elements` mechanism by which a plugin advertises the HTML it
produces. When an admin adds the **Description list** button to a format that uses *Limit allowed
HTML tags* (`filter_html`), core's CKEditor 5 integration adds **`<dl>`, `<dd>`, `<dt>`**
to that format's allowed-HTML list automatically, so the produced markup is not stripped on save.

- The declared elements are exactly the three semantic list tags — **no attributes**, **no `style`**,
  **no wildcard**. Adding the button does not widen the format with any attribute.
- On a restricted format where the button is **not** enabled, a manually typed `<dl>` is stripped by
  `filter_html`. Enabling the button is what grants the tags.
- A fully unrestricted format (no `filter_html`) needs no whitelisting.

## PHP

`src/Plugin/CKEditor5Plugin/DescriptionList.php` is `class DescriptionList extends
CKEditor5PluginDefault` with a `@CKEditor5Plugin` annotation mirroring the same id
(`ckeditor_descriptionlist_descriptionlist`), plugin `descriptionList.DescriptionList`, and elements
`<dl>/<dd>/<dt>`. It adds no custom PHP behavior — the `.ckeditor5.yml` is the fuller, authoritative
definition (it additionally lists `widget.Widget`, the `toggleDescriptionList` toolbar item, and the
libraries).

## Gotchas

- **Add the button, or the tags are stripped.** On a restricted format, only enabling the toolbar
  button teaches `filter_html` to keep `<dl>/<dt>/<dd>`.
- **Colon splitting** — text before the first `:` on a line becomes the term, the rest the
  description; a line with no colon yields a `<dt>` with no matching `<dd>` content.
- **Version 3.x is CKEditor 5 only.** Earlier majors targeted the old CKEditor 4 external JS library;
  3.x is a native CKEditor 5 build with no external library download.
- No settings form, no config object, no config schema, no permissions of its own — nothing to
  configure beyond the per-format toolbar.
- Style the list from your theme/CSS; the module ships only admin CSS
  (`css/ckeditor_descriptionlist.admin.css`) that sets the toolbar-button icon from
  `icons/description-list.svg`.
- Cite points: `ckeditor_descriptionlist.ckeditor5.yml`, `ckeditor_descriptionlist.libraries.yml`,
  `.info.yml`, `src/Plugin/CKEditor5Plugin/DescriptionList.php`, and JS
  `js/plugins/descriptionList/src/index.js` (built `js/dist/descriptionList.js`).
