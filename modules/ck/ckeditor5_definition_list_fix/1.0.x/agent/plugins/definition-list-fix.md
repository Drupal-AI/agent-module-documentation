<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Definition List Fix — CKEditor 5 plugin & setup

Machine name of the plugin: `definitionListFix.CKEditor5DefinitionListFixPlugin`
(class `CKEditor5DefinitionListFixPlugin` in `js/definition-list-fix.js`).

## Install & enable
1. `composer require drupal/ckeditor5_definition_list_fix`
2. `drush en ckeditor5_definition_list_fix -y`
3. `drush cr`

No settings form and no config objects — the module has no `config/install`, `config/schema`, `*.routing.yml`, `*.permissions.yml`, or `*.services.yml`, and `data.json.configure` is null.

## Turn it on for a text format
Go to **Administration » Configuration » Content authoring » Text formats and editors**
(`/admin/config/content/formats`), edit a format that uses **CKEditor 5**, and drag the
**"Definition List Fix Plugin"** button (toolbar id `cke5_definition_list_fix_dummy`,
icon `icons/definition-list-fix.svg`) into the active toolbar. Save. The button's
`execute` handler is intentionally a no-op — its only job is to activate the plugin for
that format; the fix then applies passively during editing.

When the button is on the toolbar, the elements declared under `drupal.elements` in
`ckeditor5_definition_list_fix.ckeditor5.yml` are contributed to the format's allowed
HTML: `<dl id class style>`, `<dt id class style>`, `<dd id class style>`, and
`<i lang dir class id title style>`. On a restrictive format (e.g. Basic HTML) confirm
these are permitted; on Full HTML they are unrestricted already.

## Declaration (`ckeditor5_definition_list_fix.ckeditor5.yml`)
- `ckeditor5.plugins`: `definitionListFix.CKEditor5DefinitionListFixPlugin`
- `drupal.library`: `ckeditor5_definition_list_fix/definition-list-fix`
- `drupal.admin_library`: `ckeditor5_definition_list_fix/admin.definition-list-fix`
- `drupal.toolbar_items.cke5_definition_list_fix_dummy` (label + icon)
- `drupal.elements`: the four tag/attribute grants above

Libraries (`ckeditor5_definition_list_fix.libraries.yml`): `definition-list-fix` loads
`js/definition-list-fix.js` and depends on `core/ckeditor5`; `admin.definition-list-fix`
loads `css/cke5.admin.css` (only styles the toolbar button icon).

## How the fix works (in `init()`)
- **Schema registration** via `editor.model.schema.register(...)`:
  - `definitionList` — `allowWhere: '$block'`, children `definitionTerm`/`definitionDescription`, attrs `id`/`class`/`style`.
  - `definitionTerm` and `definitionDescription` — `allowIn: 'definitionList'`, `allowContentOf: '$block'`, `isLimit`, `isBlock`, `allowChildren: 'paragraph'`, attrs `id`/`class`/`style`.
- **Conversion** (`addDefinitionListConversion`): upcast `dl`→`definitionList`, `dt`→`definitionTerm`, `dd`→`definitionDescription`; and matching `dataDowncast` + `editingDowncast` back to `<dl>`/`<dt>`/`<dd>` via `writer.createContainerElement(...)`. `getAttributes`/`setAttributes` copy only `id`/`class`/`style` across the boundary, which is what stops CKEditor from re-wrapping term/definition content in `<p>`.
- **Allowed-HTML preservation** (`preserveAllowedHtml`): if the `DataFilter` (GHS) plugin is present, calls `dataFilter.allowElement`/`allowAttributes` for `dl`/`dt`/`dd` (id/class/style) and for `i` (lang/dir/class/id/title/style).
- **Redundant `<em>` cleanup** (`cleanRedundantEmAroundI`): wraps `editor.data.processor.toData`; on output, an `<em>` whose only meaningful child is a single `<i>` is unwrapped (DOM path via a `<template>`; a regex fallback when `document` is unavailable). This yields `<i lang="la">et cetera</i>` instead of `<em><i …></em>`.

The plugin object is exposed as `CKEditor5.definitionListFix.CKEditor5DefinitionListFixPlugin`.

## Operate / verify
- After enabling on a format, edit content with a `<dl>`; terms and definitions should save without inner `<p>`.
- Type or paste `<i lang="la">…</i>`; the saved output should not gain an `<em>` wrapper.
- All behaviour is client-side; there is nothing to cron, queue, or configure server-side.
