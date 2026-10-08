<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor5 Table Fix stops CKEditor 5 from stripping or normalizing existing HTML table markup, preserving <tfoot>, <caption>, nested content in cells, and structural attributes.

---

CKEditor5 Table Fix is a client-side-only CKEditor 5 plugin. Its goal is preservation, not authoring:
it registers CKEditor model schema and upcast/downcast converters (in `js/table-fix-plugin.js`) and
uses Drupal's GeneralHtmlSupport allow-list (in `ckeditor5_table_fix.ckeditor5.yml`) so that
`<thead>`, `<tbody>`, `<tfoot>`, `<caption>`, `<tr>`, `<td>`, `<th>` and their hierarchy — plus nested
`<div>`, `<dl>/<dt>/<dd>`, `<p>`, and `<ul>/<ol>/<li>` inside cells, and embedded `drupal-media`/
`drupal-entity` — survive round-trips through the editor instead of being flattened. It preserves the
attributes `scope`, `colspan`, `rowspan`, `headers`, `id`, `class`, and `style` on those elements.
It depends only on core `ckeditor5`.

It is enabled per text format, not globally. In each format's CKEditor 5 configuration you disable
core's built-in Table plugin, enable CKEditor5 Table Fix, and drag the faux "Table Fix Dummy" button
into the active toolbar — the button loads the plugin but renders no visible editor UI. Make sure the
format's allowed-HTML (filter_html) permits the table tags/attributes so they survive filtering on
save. There is no configuration form, no permission, and no content entity of its own; the module's
only PHP is a `hook_form_alter()` that attaches a small frontend CSS library to forms containing a
text-format widget. It targets sites upgraded from CKEditor 4 and semantic/WCAG data tables.

---

- Preserve `<tfoot>`, `<thead>`, `<tbody>`, `<caption>` and table hierarchy through editing.
- Keep structural attributes: `scope`, `colspan`, `rowspan`, `headers`, `id`, `class`, `style`.
- Allow nested `<div>`, `<p>`, `<dl>/<dt>/<dd>` and lists inside `<td>`/`<th>`.
- Allow `<ul>`, `<ol>`, `<li>` (with classes) inside table cells and footers.
- Let `drupal-media` / `drupal-entity` embeds sit inside cells and definition lists.
- Register `<table>` as a block so it may nest inside `<div>`/`<section>`.
- Enabled per text format via CKEditor 5 configuration, not sitewide.
- Disable core's Table plugin on the same format first.
- Drag the "Table Fix Dummy" button into the active toolbar to activate.
- No visible editor button appears — the plugin loads silently.
- Ensure filter_html allows the table tags so markup survives on save.
- Depends only on core `ckeditor5`; no contrib or Composer deps.
- No configuration form, permission, route, or entity of its own.
- Client-side only: schema + converters in JS, plus a GHS allow-list.
- `hook_form_alter()` attaches frontend CSS to text-format forms.
- Frontend CSS sets `tfoot` to normal weight inside `.ck-content`.
- Designed for CKEditor 4 → 5 migrations that lost table markup.
- Suited to semantic / WCAG-compliant data tables.
- Adds no new table-editing UX for editors.
- Goal is preservation of existing HTML, not normalization.
