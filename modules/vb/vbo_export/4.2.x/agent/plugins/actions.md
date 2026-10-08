<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VBO Export: the four export actions

Source under `web/modules/contrib/vbo_export/src/Plugin/Action/`. These **implement** the Views Bulk
Operations action plugin type (`ViewsBulkOperationsActionBase`, `@Action` with `type = ""`); the module
defines no plugin type of its own. There is **no admin/config route and no permission** — everything is
configured per view.

## The four actions

| Plugin id | Class | Ext | Library needed |
|---|---|---|---|
| `vbo_export_generate_csv_action` | VboExportCsv | csv | none (Symfony `CsvEncoder`) |
| `vbo_export_generate_xlsx_action` | VboExportXlsx | xlsx | phpoffice/phpspreadsheet |
| `vbo_export_generate_pdf_action` | VboExportPdf | pdf | dompdf/dompdf |
| `vbo_export_generate_doc_action` | VboExportDoc | docx | phpoffice/phpword |

Labels are "Generate {csv,xlsx,pdf,doc} from selected view results". Missing library ⇒ `generateOutput()`
adds an error message and returns `''` (no file); `hook_requirements` also flags it as a status-report warning.
`VboExportBase` is the shared abstract base; each subclass only sets `EXTENSION` and implements `generateOutput()`.

## How to use (no code)
1. Build a View that includes the **Views bulk operations** field.
2. In that field's settings, under "Selected actions", enable one or more "Generate … from selected view results".
3. Expand the action's preliminary config (see below) to set destination, field selection, etc.
4. On the view page, select rows, pick the action, run it. A batch runs and the operator gets a
   "Export file created, Click here to download" status message linking the temporary file.

## Per-action preliminary config (`buildPreConfigurationForm`)
Stored as `views_bulk_operations.action_config.<id>` (schema in `config/schema/vbo_export.schema.yml`).
Base fields on every action:
- `file_scheme` (radios) — writable+visible stream wrappers only; **default `private`**. At write time an
  unknown scheme falls back to `public`.
- `strip_tags` (checkbox, default off) — `html_entity_decode(strip_tags($value))` on each rendered field value.
- `field_override` (checkbox) + `field_config` table — when checked, only fields marked `active` are exported,
  with an optional custom `label` per field. When unchecked, the header is every visible, non-excluded view
  field (`views_bulk_operations_bulk_form` and `entity_operations` are always excluded).

Extra fields:
- CSV: `separator` radios — `;` (default), `,`, `|`.
- PDF: `paper_size` select (Dompdf `CPDF::$PAPER_SIZES`, default `letter`) + `orientation` radios
  (portrait/landscape).

## Runtime behavior (base class)
- `access($object, $account)` ⇒ `$object->access('view', $account)`. **No extra permission** — a row is
  exportable iff the operator can `view` that entity. Access scope = View/entity `view` access only.
- `executeMultiple()` collects `{id, langcode}` per selected entity, renders the view, and for each result row
  matches on both entity id **and** langcode before reading `style_plugin->getField($key, $field_id)` for each
  header field. Rows are chunked into `tempstore.private` (`vbo_export_multiple` collection); the output file is
  built only once `processed >= total` (last batch). This keeps large exports off-heap.
- Filename: `<view_id>_<Y_m_d_H_i>-<8 hex rand>.<ext>`. File is written via `file.repository` as **temporary**
  (`$file->setTemporary()`), so Drupal's temporary-file cleanup eventually removes it; the download link uses a
  relative URL to avoid mixed-content.

### Format specifics
- **CSV** — Symfony `CsvEncoder` with UTF-8 BOM; values `trim()`+`html_entity_decode`d; duplicate header labels
  are disambiguated as `Label / field_id`.
- **XLSX** — `setCellValueExplicit` with numeric/string type detection; header row bold + auto-filter; whole
  sheet wrap-text + top-align; per-column autosize clamped to width 15–85; document properties set creator to
  current user's display name.
- **PDF** — renders theme hook `vbo_export_pdf` (`templates/vbo-export-pdf.html.twig`: `<h2>` title, `<ol>` of
  rows, `<h3>`label/`<p>`value) via `renderer->renderInIsolation()`, then Dompdf with default font `DejaVu Sans`
  and explicit `UTF-8`. Non-stripped values are wrapped in `Markup::create()` (HTML preserved in the PDF).
- **DOCX** — PhpWord `Word2007` writer with output escaping on; each field printed as bold `label:` then value,
  blank line between rows.

## Extending: add a new export format
Subclass `VboExportBase`, declare an `@Action` with `type = ""`, set `const EXTENSION`, and implement
`protected function generateOutput()` returning the file body string. Reuse `getHeader()` (respects the
field-override config) and `getCurrentRows()` (drains the tempstore chunks). Register default action config to
expose it on views. To restyle PDFs, override `vbo-export-pdf.html.twig` in your theme (theme hook
`vbo_export_pdf`, variables: `title`, `items[].fields[].{label,value}`, `empty_text`, `view_id`, `display_id`).
