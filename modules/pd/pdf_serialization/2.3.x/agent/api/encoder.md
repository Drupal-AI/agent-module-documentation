# PDF encoder + PdfManager

## What it is
`pdf_serialization` adds a `pdf` **serialization encoder** and wires it into the contrib
**Views Data Export** pipeline. There is NO generic REST `?_format=pdf` support and no route of
its own — PDF output happens only through a Views **Data export** display whose format is `pdf`.

## Wiring
- Encoder service `pdf_serialization.encoder.pdf` (`src/Encoder/PdfEncoder.php`), a Symfony
  `EncoderInterface`/`DecoderInterface`, tagged `{ name: encoder, format: pdf }`. `decode()` is a
  no-op (`[]`); only encoding is meaningful.
- `hook_views_plugins_style_alter` (`pdf_serialization.module`) replaces the `data_export` Views
  style plugin class with `Drupal\pdf_serialization\Plugin\views\style\PdfExport` (extends
  views_data_export `DataExport`). This makes `pdf` selectable as a Data export format and, on
  export, attaches the `pdf_serialization/encoder_styles` CSS library to the feed icon.
- `hook_form_views_ui_edit_display_form_alter` injects the **PDF settings** fieldset into the
  Views UI style options (shown when format = `pdf`).
- Manager service `pdf_serialization.pdf_manager` = `Drupal\pdf_serialization\PdfManager`
  (args `@renderer`, `@file_system`), which owns the mPDF instance.

## Encode flow (PdfEncoder::encode)
1. Called by the serializer with `$data` = the view's normalized rows and `$context` containing
   `views_style_plugin` (the PdfExport/DataExport plugin, giving access to `->view` and `->options`).
2. If `$data['message']` is set (e.g. access denied), returns that string as-is — no PDF.
3. Flattens each row: array field values are `implode(', ', …)`; each value is rendered as
   `['#markup' => $value]` via the renderer.
4. Builds a render array:
   ```
   ['#theme' => 'pdf_serialization_pdf',
    '#content' => ['#type' => 'table', '#header' => <field labels>, '#rows' => <rows>, '#format' => 'full_html'],
    '#view' => <the view>]
   ```
   Headers come from the display's field labels via
   `->view->getDisplay('rest_export_attachment_1')->getOption('fields')`, falling back to the raw key.
5. Reads `export_method` (standard/batch) from the data_export display and `pdf_settings` from the
   style options, then calls `PdfManager::getPdf($output, $options)` and returns the PDF bytes.

## PdfManager::getPdf()
`getPdf(array $content, array $options = [], string $destination = \Mpdf\Output\Destination::STRING_RETURN): string`
(interface: `Drupal\pdf_serialization\PdfManagerInterface`). Reusable from custom code to turn a
render array into PDF bytes.
- Instantiates `\Mpdf\Mpdf(['mode'=>'utf-8', 'format'=> pdf_settings.format ?? 'A4', 'tempDir'=> file temp dir])`.
- If `show_page_number` and export method is empty/`standard`: sets footer `{PAGENO}`.
- If `show_header`: renders `pdf_serialization_pdf_header` (header_content, Xss::filterAdmin) →
  `SetHTMLHeader(..., 'O')`.
- If `show_footer`: renders `pdf_serialization_pdf_footer` → `SetHTMLFooter(...)` (overrides page number).
- Renders `$content` and calls `$mpdf->WriteHTML(...)`, returns `$mpdf->Output('', $destination)`.
- `$destination` accepts any `\Mpdf\Output\Destination` value (default returns the string).

## pdf_settings (per Data export display, stored in style options)
| key | type | default | notes |
|-----|------|---------|-------|
| `format` | string | `a4` | page size; UI offers a1/a2/a3/a4/a5 |
| `show_header` | bool | false | enable HTML header |
| `header_content` | text | '' | mPDF replaceable aliases (e.g. `{PAGENO}`, `{DATE j-m-Y}`); Xss::filterAdmin |
| `show_footer` | bool | false | enable HTML footer; overrides page number |
| `footer_content` | text | '' | mPDF aliases; Xss::filterAdmin |
| `show_page_number` | bool | true | footer `{PAGENO}` when no custom footer + standard export |

Config schema: `views.style.data_export.mapping.pdf_settings` in
`config/schema/pdf_serialization.views.schema.yml` (only `format` + `show_page_number` are typed
there; header/footer keys are handled by the UI/manager).

## How to produce PDF output (no code)
1. View → add **Data export** display → Format = **pdf**.
2. Pager = "Display all items".
3. Path ends in `.pdf` (e.g. `/export/report.pdf`); "Attach to" a Page display for the download icon.
4. Set PDF settings as needed. Visit the page and use the export link (or the `.pdf` path directly);
   Views Data Export handles delivery (standard synchronous or batch export).

## Theming
Override `pdf_serialization_pdf`, `pdf_serialization_pdf_header`, `pdf_serialization_pdf_footer`
(vars: `content`/`header_content`/`footer_content` + `view`). Theme suggestions add
`__{view_id}` and `__{view_id}__{display_id}` for per-view/per-display templates. Default markup
lives in `templates/`; CSS in `css/pdf-encoder.css` (library `pdf_serialization/encoder_styles`).
