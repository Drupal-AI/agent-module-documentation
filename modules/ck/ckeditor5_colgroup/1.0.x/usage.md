A client-side CKEditor 5 plugin that teaches the editor about `<colgroup>` and `<col>` table elements so they are not stripped during editing when the core table column-resize plugin is off.

---

CKEditor5 colgroup registers two model elements (`tableColumnGroup`, `tableColumn`) and upcast/downcast converters that map them to the `<colgroup>` and `<col>` view elements, plus the `span` attribute on each. Core CKEditor 5's `table.TableColumnResize` plugin already handles colgroup/col internally; if you do not enable that plugin, the editor's General HTML Support/schema does not know these elements and drops them (see core issue #3397556). This module fills that gap purely on the front end: there is no PHP, no route, no permission, no service, and no config schema. It is enabled by adding the "Colgroup" CKEditor 5 plugin to a text format's toolbar/plugin set. Whether the elements actually persist in saved markup is decided by the text format's `filter_html` "Allowed HTML tags" and the editor's Source Editing `allowed_tags` — the module does not widen or bypass that filter boundary; it only adds structural `colgroup`/`col` and their `span` attribute to the editor model. The project is deliberately narrow and will become obsolete if the upstream CKEditor bug is fixed (its UseCaseTest is written to fail when that happens).

---

- Enable manual `<colgroup>`/`<col>` markup in tables when you are not using CKEditor 5's TableColumnResize plugin.
- Preserve hand-authored column groups added via CKEditor 5 Source Editing so they survive a round-trip through the editor.
- Style whole table columns with a shared class on `<col>` (e.g. highlight a column) without repeating classes on every cell.
- Set a background or width hint on a column via `<col>`/`<colgroup>` instead of per-cell styling.
- Group columns with `<colgroup span="N">` for semantic/structural grouping in data tables.
- Improve table accessibility and semantics by keeping the `<colgroup>` structure editors add.
- Keep imported HTML tables' `<colgroup>`/`<col>` intact when content is re-edited in CKEditor 5.
- Support responsive/print CSS that targets `table col` selectors by ensuring the elements are retained.
- Provide a lightweight alternative to TableColumnResize when column resizing UI is undesirable.
- Let content authors define column spans in complex data tables (e.g. spanning header groups).
- Retain column-level classes (as exercised by the module's test: `<col class="batman">`) through editing.
- Use with a `filter_html` format whose allowed tags include `<colgroup span class>` and `<col span class>`.
- Pair with the Source Editing plugin so authors can paste/edit raw table markup containing colgroups.
- Document tabular datasets where column identity (not just cells) carries meaning.
- Ensure `<col span>`/`<colgroup span>` attributes map correctly between saved HTML and the editor model.
- Avoid the core behavior where colgroup/col are silently discarded on save without this plugin.
- Add the plugin per-format so only chosen text formats gain colgroup support.
- Serve multilingual/complex report tables that rely on column grouping semantics.
- Provide a stable editing experience for tables migrated from other CMSes that used colgroups.
- Combine with theme CSS that zebra-stripes or sizes columns via `col:nth-child()`.
