<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 Table Fix (ckeditor5_table_fix) — agent index

A **client-side-only** CKEditor 5 plugin that stops CKEditor 5 from stripping or normalizing
existing HTML **table markup** — `<tfoot>`, `<caption>`, nested lists/`<dl>`/`<div>`/`<p>` inside
cells, and structural attributes (`scope`, `colspan`, `rowspan`, `headers`, `id`, `class`,
`style`) — so legacy/semantic tables survive round-trips through the editor. Aimed at sites migrated
from CKEditor 4 and WCAG/data-table use cases. Package `CKEditor 5`. Core `^10 || ^11`. License
GPL-2.0-or-later. Installed **1.0.9** (version dir `1.0.x`).

**Not** a table-authoring UI: it adds no visible button and no new editing UX. It is pure schema +
converter registration plus Drupal's GeneralHtmlSupport (GHS) allow-list. No PHP routes,
controllers, services, permissions, entities, config schema, or install/update hooks.

## Dependencies

- Drupal module: **`ckeditor5`** (core) — the only dependency (`.info.yml`). No contrib deps, no
  Composer library requirements, no `composer.json` shipped.

## What it provides (from source)

- **CKEditor 5 plugin definition** `ckeditor5_table_fix_plugin` (`ckeditor5_table_fix.ckeditor5.yml`):
  - Loads two CKEditor plugins: `htmlSupport.GeneralHtmlSupport` (core) and the module's own
    `ckeditor5_table_fix.CKEditor5TableFixPlugin`.
  - `htmlSupport.allow` config widens GHS to keep `classes`/`attributes`/`styles` on `table`,
    `thead`, `tbody`, `tfoot`, `tr`, `td`, `th`, `div`, `dl`, `dt`, `dd`, `p`, `ul`, `ol`, `li`,
    `drupal-media`, `drupal-entity` (see note in the security-review deliverable about `style`
    breadth reaching the output filter).
  - `drupal.elements` declares the tags/attributes added to the text format's allowed-HTML list —
    e.g. `<table class style>`, `<th ... style>`, `<div id class style>`, `<dl class style>`,
    `<dd id class style>`, `<drupal-media ... style>`. These are what actually survive filter_html
    on save/output.
  - `drupal.toolbar_items.cke5_table_fix_dummy` — a **faux toolbar button** ("Table Fix Dummy") whose
    only purpose is to let admins attach the plugin per text format via the normal drag-into-toolbar
    workflow. It renders no visible editor UI.
- **JS plugin** `js/table-fix-plugin.js` (`CKEditor5TableFixPlugin`): in `init()` it registers/extends
  the CKEditor **model schema** for `table` (as a `$block`, allowing it inside `div`/`section`),
  `caption`, `thead`/`tbody`/`tfoot`, `tr`, `td`/`th`, `ul`/`ol`/`li`, `dl`/`dt`/`dd`, and `div`/`p`
  inside cells; registers **upcast/downcast element and attribute converters** for those tags and the
  attribute set `scope,colspan,rowspan,headers,id,class,style`; and extends `drupalMedia`/`drupalEntity`
  (and raw `drupal-media`/`drupal-entity`) to be insertable inside `td`/`th`/`dd`/`dt`/`dl`. The dummy
  toolbar component is registered as `componentFactory.add('cke5_table_fix_dummy', () => null)`.
- **Libraries** (`.libraries.yml`): `htmlsupport` (the JS + `css/cke5.admin.css`, depends on
  `core/ckeditor5`) is used as both `library` and `admin_library`; `ckeditor5` (frontend `css/cke5.css`,
  which sets `tfoot { font-weight: normal }` inside `.ck-content`). `css/cke5.admin.css` only sets the
  dummy button's toolbar icon (`icons/table-fix.svg`).
- **Module file** (`ckeditor5_table_fix.module`): one hook — `hook_form_alter()` attaches the
  `ckeditor5_table_fix/ckeditor5` (frontend CSS) library to any form containing a `text_format`
  widget when the `ckeditor5` module is enabled. No data handling.

## Setup (from README)

Per target text format: disable **core's** CKEditor 5 "Table" plugin, enable **CKEditor5 Table Fix**,
drag the **Table Fix Dummy** button into the active toolbar, and ensure the format's allowed-HTML
permits the table elements. No config form; no visible button appears while editing.

## Solution docs

This is a single-plugin, client-side-only module with no server surface — this index plus
[usage.md](../usage.md) and the human guide cover it fully; no further subdocs exist because there is
no additional surface to document.
