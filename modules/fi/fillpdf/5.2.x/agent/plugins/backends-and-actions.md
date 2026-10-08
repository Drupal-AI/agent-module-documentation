# FillPDF plugin types

FillPDF defines two plugin types you can extend.

## 1. PdfBackend — how PDFs are parsed & merged

- Manager: `plugin.manager.fillpdf.pdf_backend` (`PdfBackendManager`, a `FallbackPluginManagerInterface`).
- Directory: `src/Plugin/PdfBackend/`. Base class: `PdfBackendBase`. Interface: `PdfBackendInterface`.
- Annotation: `@PdfBackend(id, label, description, weight)` (weight sorts the settings-form radios).
- Alter hook: `hook_fillpdf_pdfbackend_info_alter()`.

Interface methods:

| Method | Returns | Purpose |
|---|---|---|
| `parseFile(FileInterface $template)` | array of field defs | Parse the template's fillable fields. |
| `parseStream($pdf_content)` | array | Same, from raw bytes. |
| `mergeFile(FileInterface $template, array $field_mappings, array $context)` | string (PDF bytes) / NULL | Fill the template. |
| `mergeStream($pdf_content, array $field_mappings, array $context)` | string / NULL | Same, from bytes. |

`$field_mappings` are keyed by PDF field name; values are `TextFieldMapping` or `ImageFieldMapping`
(`(string) $mapping` gives text; `->getData()` gives image bytes). `$context` includes `flatten` and,
for pdftk, `fid` (used to look up encryption settings).

Built-in backends: `fillpdf_service` (weight 10, XML-RPC remote), `local_server` (weight 5, Guzzle JSON
to a self-hosted API), `pdftk` (weight -5, local `exec`/`passthru` with shell-escaped args + XFDF).
`getFallbackPluginId()` maps the legacy id `local_service` → `local_server`.

Skeleton:

```php
namespace Drupal\my_module\Plugin\PdfBackend;

use Drupal\fillpdf\Plugin\PdfBackendBase;
use Drupal\file\FileInterface;

/**
 * @PdfBackend(
 *   id = "my_backend",
 *   label = @Translation("My backend"),
 *   description = @Translation("Fills PDFs via my service."),
 *   weight = 0
 * )
 */
class MyBackend extends PdfBackendBase {
  public function parseFile(FileInterface $template_file) { /* return field defs */ }
  public function parseStream($pdf_content) { /* … */ }
  public function mergeFile(FileInterface $template_file, array $field_mappings, array $context) { /* return bytes */ }
  public function mergeStream($pdf_content, array $field_mappings, array $context) { /* … */ }
}
```

The active backend is chosen by the `fillpdf.settings:backend` config value; `fillpdf.settings` is
passed as the plugin configuration.

## 2. FillPdfActionPlugin — what happens to the finished PDF

- Manager: `plugin.manager.fillpdf_action.processor` (`FillPdfActionPluginManager`).
- Directory: `src/Plugin/FillPdfActionPlugin/`. Base: `FillPdfActionPluginBase`.
  Interface: `FillPdfActionPluginInterface` (extends `ExecutableInterface`).
- Annotation: `@FillPdfActionPlugin(id, label)`.
- Alter hook: `hook_fillpdf_fillpdf_action_info_alter()`.

`execute()` must return a `Symfony\Component\HttpFoundation\Response` (or subclass) and **must not end
the request**; side effects (e.g. saving a file) are allowed. The plugin receives its inputs via
`$this->configuration`: `form`, `context`, `entities`, `data` (PDF bytes), `filename`.

Built-in actions:

| id | Class | Behavior |
|---|---|---|
| `download` | `FillPdfDownloadAction` | Returns a `Response` with `Content-Disposition: attachment` + `application/pdf`. |
| `save` | `FillPdfSaveAction` | Writes the file via `OutputHandler`. |
| `redirect` | `FillPdfRedirectAction` | Saves then redirects the browser to the file. |

`HandlePdfController::handlePopulatedPdf()` selects the action from the form's storage scheme (and
`destination_redirect`), overriding to `download` when the scheme is missing/unavailable/not allowed.
