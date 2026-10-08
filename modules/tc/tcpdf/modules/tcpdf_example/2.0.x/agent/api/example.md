# TCPDF Example — the demo endpoint

`tcpdf_example` is a reference/demo submodule. It exposes nothing reusable of its own; it shows how to
call the parent `tcpdf` module's factory to turn rendered HTML into a downloadable PDF. Copy
`TcpPdfExampleController::generateSimplePdf()` as the template for a real endpoint.

## Routes

| Route | Path | Controller method | Permission |
|-------|------|-------------------|------------|
| `tcpdf_example.content` | `/tcpdf_example/content` | `::exampleContents` | `use tcpdf example` |
| `tcpdf_example.download_pdf` | `/tcpdf_example/download/{example_name}` | `::downloadPdf` | `use tcpdf example` |

- `exampleContents()` returns a render array with one `#type => link` to the download route with
  `example_name = simple`.
- `downloadPdf(string $example_name)` accepts only `simple`; anything else throws
  `\InvalidArgumentException('Invalid example name.')`. Then it emits the PDF.

Controller: `\Drupal\tcpdf_example\Controller\TcpPdfExampleController` (final, extends `ControllerBase`,
constructor-injects `\Drupal\Core\Render\RendererInterface`).

## How the PDF is built — `generateSimplePdf()`

```php
$html = $this->renderer->render(['#theme' => 'tcpdf_example_basic_html']);

$tcpdf = tcpdf_get_instance();              // parent factory — never `new TCPDFDrupal()`
$tcpdf->DrupalInitialize([
  'footer' => ['html' => 'This is a test!! <em>Bottom of the page</em>'],
  'header' => ['callback' => [
    'function' => 'tcpdf_example_default_header',
    'context'  => ['welcome_message' => 'Hello, tcpdf example!'],
  ]],
]);
$tcpdf->writeHTML((string) $html);          // DrupalInitialize already added the first page
return $tcpdf->Output('', 'S');             // 'S' = return binary as string
```

`downloadPdf()` then streams it with raw PHP:

```php
header('Content-Type: application/pdf');
header('Content-Length: ' . strlen($pdf));
header('Content-Disposition: attachment; filename="mydocument.pdf"');
print $pdf;
exit;
```

(This bypasses Symfony's `Response` object — fine for a demo, but a real controller should return a
`Response` / `BinaryFileResponse` so Drupal can finish the request normally.)

Parent API details for `tcpdf_get_instance()` and the full `DrupalInitialize()` option list:
[../../../../../2.0.x/agent/api/usage.md](../../../../../2.0.x/agent/api/usage.md).

## Theme hook & template

`hook_theme()` in `tcpdf_example.module` registers:

| Theme hook | Template | Variables |
|------------|----------|-----------|
| `tcpdf_example_basic_html` | `templates/tcpdf_example_basic_html.html.twig` | (none) |

The template is static HTML (a Lorem-ipsum paragraph plus a 3-row bordered table) — the sample content
fed to `writeHTML()`.

## Header callback

`tcpdf_example_default_header(\Drupal\tcpdf\TCPDFDrupal $tcpdf, array $context): void` (in
`tcpdf_example.module`) demonstrates the header-callback contract: it receives the PDF instance (not
`$this`) plus the `context` array you passed under `header.callback.context` in `DrupalInitialize()`.
It draws the active theme's logo via `$tcpdf->Image(...)` when the `system.theme` default theme's
`logo.path` exists, then writes `$context['welcome_message']` via `$tcpdf->Write(...)`. A footer
callback would follow the same shape.

## Menu link

`tcpdf_example.links.menu.yml` adds the menu link `tcpdf_example.content` (title "TCPDF example")
pointing at the content route.

## Operability caveat (2.0.4)

`TcpPdfExampleController` is a concrete (`final`) controller that inherits
`ContainerInjectionInterface` from `ControllerBase` but defines a constructor
(`__construct(RendererInterface $renderer)`) **without** a matching
`public static function create(ContainerInterface $container)`. PHP therefore raises a fatal error when
the class is autoloaded (`... must ... implement the remaining methods (... ::create)`), so **both
routes error under current core as shipped**. To run or reuse the demo, add a `create()` that injects
the renderer:

```php
public static function create(ContainerInterface $container): static {
  return new static($container->get('renderer'));
}
```
