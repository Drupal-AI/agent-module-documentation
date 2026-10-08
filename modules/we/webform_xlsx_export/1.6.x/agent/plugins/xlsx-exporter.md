<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `xlsx` WebformExporter plugin

```php
/**
 * @WebformExporter(
 *   id = "xlsx",
 *   label = @Translation("XLSX"),
 *   description = @Translation("Exports results as an Office Open XML file."),
 * )
 */
class XlsxExporter extends \Drupal\webform\Plugin\WebformExporter\TabularBaseWebformExporter
```

Located at `src/Plugin/WebformExporter/XlsxExporter.php`. The module defines **no plugin type**
— this is one instance of Webform's existing `WebformExporter` type, discovered automatically
by `plugin.manager.webform.exporter`.

Because it extends `TabularBaseWebformExporter` it inherits the whole tabular option set
(`buildHeader()`, `buildRecord()`, header format label/key, multi-value delimiters,
entity-reference item selection, excluded columns…) and only replaces the *writing*.

## Methods it overrides

| Method | Behaviour |
|---|---|
| `create()` | injects `file_system` and `stream_wrapper_manager` on top of the parent. |
| `getFileExtension()` | returns `'xlsx'`. |
| `createExport()` | `$this->xls = new Spreadsheet();` (fresh workbook). |
| `openExport()` | only when `$this->xls` is not already set: resolves the export URI to a real path via `FileSystem::realpath()` when the stream wrapper is `StreamWrapperInterface::LOCAL_NORMAL`, then `IOFactory::load($path)` — PhpSpreadsheet cannot read Drupal stream wrappers (PHPOffice issue #2907). |
| `writeHeader()` | calls the parent, then writes `buildHeader()` into row 1 (`setCellValue([$column + 1, 1], …)`) and applies bold to `A1:<highestColumn>1`. |
| `writeSubmission()` | calls the parent, appends `buildRecord($submission)` at `getHighestRow() + 1`. **If a value is a string longer than 1 char starting with `=`, it is written with a `StringValueBinder`** so PhpSpreadsheet stores it as text rather than a formula. |
| `closeExport()` | `IOFactory::createWriter($this->xls, "Xlsx")->save($this->getExportFilePath())`. |

## Requirements check

`webform_xlsx_export.install` implements `hook_requirements($phase)`; at `runtime` it tries
`new Spreadsheet()` and reports **OK** ("PhpSpreadsheet is installed.") or **ERROR** with a
prompt to install PhpSpreadsheet. Nothing else happens at install/uninstall — there is no
schema, no config, no update hooks.

## Subclassing it

To add column widths, freeze panes, number formats or extra sheets, extend the plugin and
hook the same lifecycle:

```php
namespace Drupal\my_module\Plugin\WebformExporter;

use Drupal\webform_xlsx_export\Plugin\WebformExporter\XlsxExporter;

/**
 * @WebformExporter(
 *   id = "xlsx_styled",
 *   label = @Translation("XLSX (styled)"),
 * )
 */
class StyledXlsxExporter extends XlsxExporter {

  public function writeHeader(): void {
    parent::writeHeader();
    // $this->xls is private in the parent — reach the sheet via the writer lifecycle
    // instead, or copy the parent's body if you need direct access.
  }

}
```

Note `$xls` is declared **private**, so a subclass cannot touch the `Spreadsheet` object
directly; realistic customisation means overriding `createExport()`/`closeExport()` and
keeping your own reference, or copying the parent implementations.

## Ordering / discovery

Plugins are listed at `/admin/reports/webform-plugins/exporters`. To confirm registration:

```bash
drush php:eval 'print_r(array_keys(\Drupal::service("plugin.manager.webform.exporter")->getDefinitions()));'
```
