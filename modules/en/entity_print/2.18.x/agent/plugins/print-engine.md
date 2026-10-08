# Add a print engine (plugin)

Print engines are annotation plugins in `Plugin/EntityPrint/PrintEngine`, managed by
`plugin.manager.entity_print.print_engine`. Bundled: `dompdf`, `phpwkhtmltopdf`, `tcpdfv1`.

```php
namespace Drupal\mymodule\Plugin\EntityPrint\PrintEngine;

use Drupal\entity_print\Plugin\PrintEngineBase;

/**
 * @PrintEngine(
 *   id = "my_pdf",
 *   label = @Translation("My PDF"),
 *   export_type = "pdf"
 * )
 */
class MyPdf extends PrintEngineBase {

  public function addPage($content) { /* buffer HTML */ return $this; }
  public function send($filename, $force_download = TRUE) { /* stream */ }
  public function getBlob() { /* return raw bytes */ }

  public static function dependenciesAvailable() {
    return class_exists(\Some\Vendor\Lib::class);   // gates visibility on the settings form
  }
  public static function getInstallationInstructions() {
    return 'composer require some/vendor';
  }
}
```

Key points (`PrintEngineInterface`):
- `export_type` ties the engine to an export type (`pdf`, `epub`, `word_docx`, or your own).
- `dependenciesAvailable()` — return FALSE when the required PHP library is missing; the engine
  is then hidden from the settings form and can't be selected.
- `getInstallationInstructions()` — shown to admins to explain how to install the library.
- Extend `PrintEngineBase` (implements `ConfigurableInterface` + `PluginFormInterface`) to add a
  settings sub-form; store defaults in `config/schema` type `entity_print_print_engine.<id>`.
- New export types are declared in `mymodule.entity_print_export_types.yml` (id → label +
  file_extension), backed by `plugin.manager.entity_print.export_type`.
