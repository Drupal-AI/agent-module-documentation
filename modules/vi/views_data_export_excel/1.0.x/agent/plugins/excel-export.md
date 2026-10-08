<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Excel export display and style plugins

## Install & enable

```bash
composer require drupal/views_data_export_excel
drush en views_data_export_excel -y
```

Composer pulls the two module dependencies (`drupal/views_data_export:^1`,
`drupal/xls_serialization:^2.1`) and, transitively, `phpoffice/phpspreadsheet`. XLS Serialization
must be **2.1.0+**. Enabling `views_data_export_excel` requires `views_data_export` and
`xls_serialization` to be enabled too.

## The two plugins

Both plugins share the id **`data_export_excel`**.

### Display plugin — `src/Plugin/views/display/ExcelExport.php`

```php
class ExcelExport extends DataExport {          // Drupal\views_data_export\...\display\DataExport
  use ExcelExportDisplayTrait;                  // from xls_serialization
  protected $contentType = 'xlsx';
```

`@ViewsDisplay(id = "data_export_excel", uses_route = TRUE, returns_response = TRUE)`. It is a
Views **Data Export** display, so — exactly like the CSV/XML/JSON Data Export display — it exposes
a **route** (`uses_route = TRUE`) that streams the rendered file as an HTTP response. This module
adds nothing to how that route is registered or access-checked; both are inherited from Views Data
Export's `DataExport` display and, beneath it, core Views. Access is whatever the View's **access**
plugin (permission / role / custom) is set to, and the query (filters, contextual filters,
row-level access such as node grants) is the View's — the export shows exactly the rows the View
would show.

`buildOptionsForm()` only extends the parent form; per `$form_state->get('section')` it calls the
trait's `buildStyleSectionForm()` (style section), leaves the `path` section to Views Data Export,
calls `buildFormatHeaderSectionForm()` (format-header section), and always calls
`buildConditionalFormattingRulesForm()`. All three form builders live in `ExcelExportDisplayTrait`
(xls_serialization), which also defines `defineOptions()` and `optionsSummary()` (the Excel-sheet
header and conditional-formatting summary categories on the display UI).

### Style plugin — `src/Plugin/views/style/ExcelExport.php`

```php
class ExcelExport extends DataExport {          // Drupal\views_data_export\...\style\DataExport
  use ExcelExportStyleTrait;                    // from xls_serialization
  public function __construct(...) {
    parent::__construct(...);
    $this->initializeSerializerFormats();       // registers the xlsx/xls serializer formats
  }
```

`@ViewsStyle(id = "data_export_excel", display_types = {"data"})`. It reuses the Data Export style
row-rendering and just registers the Excel serializer formats via the trait's
`initializeSerializerFormats()`, so the style's serializer knows the `xlsx`/`xls` formats handled
by XLS Serialization's `Xls`/`Xlsx` encoders.

## Add the export to a View

1. Edit (or create) a View with the data you want.
2. **Add** a display of type **Data Export Excel** (the display plugin's admin label).
3. On that display set the **Path** (Views Data Export path/filename options), the **Style**
   (Data Export Excel — its options include the XLS format and metadata, see
   [../config/options.md](../config/options.md)), and the **Access** (this is what gates who may
   download — set it deliberately for sensitive data).
4. Optionally attach the Data Export display to a page display so a "Download Excel" link appears.
5. Save. Visiting the display path streams the `.xlsx` file.

Everything else — batching large exports, filename, pager/limit — is standard Views Data Export
behaviour, unchanged by this module.

## What this module does NOT provide

No permissions (`*.permissions.yml` absent), no routing file of its own, no services, no `.module`
/ `.install`, no hooks, no Drush, no submodules, no JS/CSS libraries. It is purely two plugin
subclasses plus a config schema.
