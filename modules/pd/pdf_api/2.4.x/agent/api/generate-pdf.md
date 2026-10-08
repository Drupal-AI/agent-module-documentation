# Generate a PDF from code

Load a generator plugin from the manager, feed it HTML, then emit.

## Load a generator

```php
/** @var \Drupal\pdf_api\PdfGeneratorPluginManager $manager */
$manager = \Drupal::service('plugin.manager.pdf_generator');
/** @var \Drupal\pdf_api\Plugin\PdfGeneratorInterface $pdf */
$pdf = $manager->createInstance('dompdf'); // or 'mpdf', 'tcpdf', 'wkhtmltopdf', 'puphpeteer'
```

`PdfGeneratorPluginManager::createInstance()` merges any `printable.format.<id>` config into
the plugin configuration before instantiation (integration point for the Printable/Entity
Print module family). `createInstance('dompdf')` works standalone.

## Interface (`PdfGeneratorInterface`)

Key methods you call to build and emit a document:

| Method | Purpose |
|---|---|
| `setter($html, $location, $save, $orientation, $size, $footer, $header, $binary='')` | One-shot setup of content + options. |
| `addPage($html)` | Append a page of HTML. |
| `setHeader($html)` / `setFooter($html)` | Repeating header/footer markup. |
| `setPageOrientation($o)` | `PdfGeneratorInterface::PORTRAIT` (default) or `::LANDSCAPE`. |
| `setPageSize($size)` | e.g. `A4`, `Letter`, `B4`. |
| `save($location)` | Write the PDF to a path. |
| `stream($filelocation)` | Stream inline to the browser. |
| `send()` | Send as a named download. |
| `getObject()` | The underlying library object (`Dompdf`, `Mpdf`, `TCPDF`, …) for advanced use. |
| `setEntity($entity)` / `getEntity()` | Associate the entity being rendered. |
| `getStderr()` / `getStdout()` / `displayErrors()` | Diagnostics (mainly for the external-binary wkhtmltopdf backend). |
| `usePrintableDisplay()` | FALSE in base; a backend returns TRUE to fetch content from the printable entity URL instead of a render array. |

Orientation constants live on the interface: `PdfGeneratorInterface::PORTRAIT`,
`PdfGeneratorInterface::LANDSCAPE`.

## Minimal example

```php
$manager = \Drupal::service('plugin.manager.pdf_generator');
$pdf = $manager->createInstance('dompdf');
$pdf->addPage('<h1>Invoice</h1><p>Hello, PDF.</p>');
$pdf->setPageSize('A4');
$pdf->setPageOrientation(\Drupal\pdf_api\Plugin\PdfGeneratorInterface::PORTRAIT);
$pdf->save('public://invoices/invoice-123.pdf'); // or ->stream(...) / ->send()
```

## Notes

- The bundled backends require their Composer libraries (`dompdf/dompdf`, `mpdf/mpdf`,
  `tecnickcom/tcpdf`, `mikehaertl/phpwkhtmltopdf`) — all declared in the module's
  `composer.json` and autoloaded via the vendor autoload wired up in `pdf_api.module`.
- `wkhtmltopdf` shells out to the `wkhtmltopdf` binary; pass its path as the `$binary` arg /
  configuration when the binary is not on `$PATH`.
- Only the `dompdf` backend reads `pdf_api.dom_pdf.settings` — see
  [../configure/dompdf-settings.md](../configure/dompdf-settings.md).
- This module is the engine; most sites drive it through **Entity Print / Printable** rather
  than calling the manager directly.
