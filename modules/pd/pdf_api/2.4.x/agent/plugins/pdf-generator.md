# Implement a PDF generator plugin (`@PdfGenerator`)

Add a new PDF backend (e.g. wrap a SaaS PDF API or another library) as a plugin.

## Plugin type mechanics

| Piece | Value |
|---|---|
| Discovery dir | `src/Plugin/PdfGenerator/` |
| Annotation | `@PdfGenerator` (`Drupal\pdf_api\Annotation\PdfGenerator`) |
| Interface | `Drupal\pdf_api\Plugin\PdfGeneratorInterface` |
| Base class | `Drupal\pdf_api\Plugin\PdfGeneratorBase` |
| Manager service | `plugin.manager.pdf_generator` |
| Alter hook | `hook_pdf_api_generator_alter(array &$definitions)` |
| Cache | `cache.discovery`, cid `pdf_api_generator` |

Annotation properties: `id`, `module`, `title` (Translation), `description` (Translation),
and by convention `required_class` (the library class the backend needs — used to check
availability, e.g. `"Dompdf\\Dompdf"`).

## Skeleton

```php
namespace Drupal\my_module\Plugin\PdfGenerator;

use Drupal\pdf_api\Plugin\PdfGeneratorBase;
use Drupal\pdf_api\Plugin\PdfGeneratorInterface;

/**
 * @PdfGenerator(
 *   id = "my_backend",
 *   module = "my_module",
 *   title = @Translation("My Backend"),
 *   description = @Translation("PDF generator using MyLib."),
 *   required_class = "MyVendor\\MyLib\\Client",
 * )
 */
class MyBackendGenerator extends PdfGeneratorBase implements PdfGeneratorInterface {
  // Implement the interface: addPage(), setHeader(), setFooter(),
  // setPageOrientation(), setPageSize(), save(), stream(), send(),
  // getObject(), setter(), getStderr(), getStdout(), displayErrors(),
  // usePrintableDisplay(), setEntity()/getEntity().
}
```

Extend `PdfGeneratorBase` so you only override what differs; look at the bundled plugins as
references — `DompdfGenerator` (pure-PHP, reads `pdf_api.dom_pdf.settings`, implements
`ContainerFactoryPluginInterface` for DI), `MpdfGenerator`, `TcpdfGenerator`,
`WkhtmltopdfGenerator` (shells out to a binary, so `getStderr()`/`getStdout()` matter), and
the submodule's `PuphpeteerGenerator`.

## Register / verify

Clear caches so discovery picks up the plugin:

```bash
drush cr
drush php:eval 'var_export(array_keys(\Drupal::service("plugin.manager.pdf_generator")->getDefinitions()));'
```

Your `id` will appear in the definitions list and can then be loaded with
`createInstance('my_backend')` (see [../api/generate-pdf.md](../api/generate-pdf.md)).
