# Views display: XLS data export into a template workbook

The module does **not** register a new Views display id. Instead
`xls_views_data_export_views_plugins_display_alter()` (in `xls_views_data_export.module`) rewrites
the class of the existing `data_export` display:

```php
$definitions['data_export']['class'] = 'Drupal\xls_views_data_export\Plugin\views\display\XlsDataExport';
```

So every "Data export" display in the Views UI now runs `XlsDataExport extends
views_data_export\...\DataExport`. Extra behaviour only kicks in when the display's chosen format
(via its Style/serializer) resolves to content type `xls` (i.e. an `xls_serialization` XLS/XLSX
encoder is selected). For CSV/XML/JSON it behaves exactly like stock Views Data Export.

## Setup

```bash
composer require drupal/xls_views_data_export drupal/views_data_export drupal/xls_serialization
# phpoffice/phpspreadsheet ^2.3 + ext-zip come from this module's composer.json.
drush en xls_views_data_export -y
```

Then on a view: add a **Data export** display, set its format to the XLS/XLSX serializer, and
configure the export options below under the display's **Path** settings.

Install guard: `xls_views_data_export_requirements()` returns `REQUIREMENT_ERROR` at install if the
PHP `zip` extension is not loaded (message text is a copy/paste stub mentioning "Commerce", but the
check is real).

## Per-display options

Added by `buildOptionsForm()` / `validateOptionsForm()` / `submitOptionsForm()` in the `path`
section of the Data export display. Stored on the `views.display.data_export` display options via
`setOption()`.

| Option key | Form field | Type | Default | Meaning |
|---|---|---|---|---|
| `default_fid` | Default File ID | `entity_autocomplete` (file) | — | A managed **file** entity (an .xls/.xlsx) used as the template when the exporter is not given one at request time. Blank = upload a file on each export. Validated to have an Excel MIME type. |
| `default_worksheet_name` | Default Worksheet Name | `machine_name` (max 31) | `Worksheet` | Name for the sheet the view's rows are written into. Disallowed chars `* \ / : ? [ ]` are stripped. |
| `default_override_sheet` | Override Worksheet if it exists | `checkbox` | `FALSE` | If a sheet of that name already exists in the template, replace it (keep its title/code name) instead of adding a numbered duplicate. |
| `flip_path` | Switch the Export Route | `checkbox` | `FALSE` | Make the export form the **primary** route at the view path; move the plain data route to `<path>/result`. See routing below. |

`validateOptionsForm()` loads `default_fid` and rejects it unless its MIME type is one of
`application/vnd.ms-excel` or `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`.

Set from code (per display) instead of the UI:

```php
$view = \Drupal::entityTypeManager()->getStorage('view')->load('my_view');
$display = &$view->getDisplay('data_export_1');
$display['display_options'] += [
  'default_fid' => 123,             // file entity id of the template .xlsx
  'default_worksheet_name' => 'Report',
  'default_override_sheet' => TRUE,
  'flip_path' => FALSE,
];
$view->save();
```

> Config-schema note: these four keys have **no shipped config schema**. The module contains a
> `hook_config_schema_info_alter()` that would register them on `views.display.data_export`, but it
> is defined with the literal `hook_` prefix (not `xls_views_data_export_...`), so Drupal never
> invokes it. Expect a "missing schema" notice on config export/validation for these keys.

## Routing

`collectRoutes()` first calls the parent, then — only when the data-export route
`view.<view_id>.<display_id>` exists **and** the content type is `xls` — builds an extra export
route via `getExportRoute()`:

- Route name: `view.<view_id>.<display_id>.export`.
- Path: the display path plus `/export/{_excel_file}/{_worksheet_name}/{_override_sheet}`.
  Contextual-filter `%` segments are rewritten to named `{arg_N}` (or `{name}`) parameters and
  recorded in a `_view_argument_map` route option so arguments survive.
- Defaults: `_form => Drupal\xls_views_data_export\Form\XlsExportForm`, plus `_excel_file`
  (from `default_fid`, else `-1`), `_worksheet_name` (from `default_worksheet_name`), and
  `_override_sheet` (from `default_override_sheet`).
- Requirement: `_excel_file` must match `\d+`. Access is inherited from the view's own access plugin
  via `$access_plugin->alterRouteDefinition($route)` (falls back to the `none` access plugin).

If `flip_path` is TRUE: the export form route is placed at the original view path (with an added
`/{_excel_file}/{_worksheet_name}/{_override_sheet}`), and the plain results route is re-registered
as `view.<view_id>.<display_id>.result` at `<path>/result`.

## The export form (`XlsExportForm`, form id `xls_export_form`)

Rendered at the export route. It reads `_excel_file` / `_worksheet_name` / `_override_sheet` from the
route match and shows:

- `export_external` checkbox (default on) — toggles the whole template flow.
- `excel_file` — a **file upload** (validators: extensions `xls xlsx`, size
  `Environment::getUploadMaxSize()`) when no valid default file id was supplied; otherwise a
  disabled `entity_autocomplete` showing the preset template.
- `worksheet_name` — `machine_name` (max 31, disallowed chars stripped).
- `override_sheet` — checkbox.

`validateForm()` saves the upload with `file_save_upload('excel_file', ...)` (unmanaged, index 0) and
errors if no file is present. `submitForm()` reassembles the view args from `_view_argument_map`,
attaches `_excel_file` (File entity), `_worksheet_name`, `_override_sheet`, and calls
`XlsDataExport::buildResponse($view_id, $display_id, $args)`, setting it as the form response.
`worksheetExists()` is a static machine-name "exists" callback that currently always returns FALSE.

## What happens at runtime (`buildResponse()` + `setUpExternal()`)

`XlsDataExport::buildResponse()` overrides the parent:

1. Pulls `_excel_file` / `_worksheet_name` / `_override_sheet` out of `$args`, then lets the parent
   `DataExport::buildResponse()` render the view normally (this is where `xls_serialization` writes
   the rows into a fresh XLSX).
2. If the response content type is `xls` and both a template file and a worksheet name are present,
   it:
   - loads the template with `IOFactory::load(realpath($file->getFileUri()))`;
   - writes the freshly serialized view output to a `temporary://` temp file and loads it too, taking
     its active sheet as the "result sheet";
   - `setUpExternal()` names the result sheet: if `override` and a sheet of that name exists, it
     copies the existing sheet's title/code name and removes the old sheet; otherwise it derives a
     valid, unique title/code name via `ensureValidWorksheetNames()`;
   - `addExternalSheet()` moves the result sheet into the template workbook and sets it active;
   - writes the merged workbook with `IOFactory::createWriter($original, 'Excel2007')` to
     `php://output`, captured via `ob_start()` and returned as a `CacheableResponse` carrying the
     original response headers.
3. On any exception the module logs to the `xls_views_data_export` channel and falls back to the
   original (non-merged) response.

Note: rows are placed into the template by loading an already-serialized XLSX and moving its sheet —
this module never writes individual cell values itself; that is done upstream by the
`xls_serialization` encoder.
