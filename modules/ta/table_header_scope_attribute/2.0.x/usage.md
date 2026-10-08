<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Table Header Scope Attribute adds two text-format filters that improve table accessibility: one sets the correct `scope` attribute on `<th>` cells, the other converts empty `<th>` cells into `<td>`.

---

The module ships two `filter` plugins you enable per text format (no settings page of its own). **"Set scope attribute for table headers"** (`table_header_scope_attribute`) parses each `<table>` in the submitted HTML with DOM/XPath and, for tables that contain at least one `<td>`, sets `scope="col"` on header cells in header-only rows and `scope="row"` on header cells in rows that also contain data cells; a header spanning multiple columns/rows gets `colgroup`/`rowgroup` instead (based on its `colspan`/`rowspan`). It skips `<th>` cells that already have a `scope` and skips empty ones. **"Transform empty table header to table data"** (`table_header_scope_attribute_empty_th_to_td`) replaces empty `<th>` cells with `<td>` (copying children and attributes except `scope`), since an empty header carries no semantic value. Both are `TYPE_TRANSFORM_IRREVERSIBLE` filters. A shared `HtmlElementValidator` service decides "emptiness" — treating Unicode whitespace and comments as empty but void elements like `<img>` as content. A form-alter validation on the text-format add/edit form enforces the critical ordering: the scope filter must run *before* the empty-to-td filter (and both should sit below core's "Limit allowed HTML tags" filter), otherwise headers would be downgraded to `<td>` before being scoped. The module has no config entity, permissions, Drush commands or new plugin types.

---

- Automatically add `scope="col"`/`scope="row"` to table headers in WYSIWYG/body content for screen-reader accessibility.
- Improve WCAG compliance of author-entered tables without manual HTML editing.
- Convert accidental empty `<th>` corner cells into `<td>` so they carry no false header semantics.
- Apply correct `colgroup`/`rowgroup` scope to headers that span multiple columns or rows.
- Fix accessibility of legacy content tables by enabling the filters on their text format.
- Ensure CKEditor-authored tables are announced correctly by assistive technology.
- Enforce accessible table markup on a "Basic HTML"/"Full HTML" format site-wide.
- Skip headers that already declare a `scope`, preserving hand-authored intent.
- Keep `<th>` scoping consistent across all nodes using a given text format.
- Add table accessibility to comment or field text where the format is used.
- Remediate imported HTML tables where headers lack `scope` attributes.
- Provide row-header scoping for tables whose first column acts as a header.
- Provide column-header scoping for tables with a header row.
- Treat non-breaking-space-only `<th>` cells as empty and demote them to `<td>`.
- Avoid marking void-element-only cells (e.g. an icon `<img>`) as empty.
- Guarantee the two filters run in the safe order via the built-in form validation.
- Layer table accessibility on top of core's allowed-HTML filter.
- Reduce manual accessibility QA on editor-produced content tables.
- Standardise table semantics for a design system's rich-text output.
- Apply accessible scoping only to real data tables (tables containing `<td>`), leaving layout-only `<th>` tables alone.
- Let editors keep using the standard table tool while output stays accessible.
- Batch-remediate accessibility across a multisite by exporting the filter-enabled text format.
- Support multilingual content since filtering runs per rendered text regardless of language.
- Prepare content tables for accessibility audits (e.g. axe, WAVE) automatically.
