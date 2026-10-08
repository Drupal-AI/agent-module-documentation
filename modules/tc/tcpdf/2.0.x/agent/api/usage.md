# Using the TCPDF wrapper

## The factory

```php
function tcpdf_get_instance(array $params = [], array $class = [], array $config = []): TCPDFDrupal
```

Always use this instead of `new TCPDF(...)`. It returns a fresh `TCPDFDrupal` (subclass of `TCPDF`).

- **`$params`** — merged over defaults `['orientation' => 'P', 'unit' => 'mm', 'format' => 'A4',
  'unicode' => TRUE, 'encoding' => 'UTF-8', 'diskcache' => FALSE, 'pdfa' => FALSE]`, passed to the
  TCPDF constructor.
- **`$class`** — use a custom subclass: `['class' => \Drupal\my_module\MyPdf::class]` (must extend
  `TCPDFDrupal`; enforced by an `assert`). Legacy keys `filetype`/`filename`/`module` can point at a
  sibling class file.
- **`$config`** — use an alternate config include: `['filetype' => 'inc', 'filename' => 'my_tcpdf.config',
  'module' => 'my_module']`. Defaults to the module's own `tcpdf.config`.

Before instantiating, it defines `K_TCPDF_EXTERNAL_CONFIG` (TRUE) and
`\Drupal::moduleHandler()->loadInclude(...)` for the config file.

## Basic usage

```php
$pdf = tcpdf_get_instance();
$pdf->DrupalInitialize([
  'header' => ['callback' => ['function' => 'my_module_header']],
  'footer' => ['html' => 'Confidential — <em>page footer</em>'],
]);
$pdf->AddPage();
$pdf->writeHTML($renderedHtml);            // HTML-to-PDF
$binary = $pdf->Output('doc.pdf', 'S');    // 'S' = return as string
```

## `TCPDFDrupal::DrupalInitialize(array $options)`

Convenience setup without subclassing. Recognized keys include `title`, `keywords` (default
`'pdf, drupal'`), and `header` / `footer`, each either `['html' => '<markup>']` or
`['callback' => ['function' => '<callable>']]`. Overrides `Header()`/`Footer()` to render the
configured section (`drupalGenRunningSection`).

## Config constants (`tcpdf.config.inc`)

Sets TCPDF's `K_*` / `PDF_*` constants **only if not already defined**, so pre-define any of them
(e.g. in another module loaded earlier, or via a custom `$config` include) to override:
- Cache dir: `K_PATH_CACHE = temporary://tcpdf/cache` (realpath).
- Page: `PDF_PAGE_FORMAT = A4`, `PDF_PAGE_ORIENTATION = P`, margins, fonts (`helvetica`/`courier`).
- `K_TCPDF_CALLS_IN_HTML = true` — allows TCPDF method calls via HTML syntax.
- `K_TCPDF_THROW_EXCEPTION_ERROR = false` — `Error()` terminates rather than throwing.

## Requirements

`hook_requirements` (runtime) reports whether the `TCPDF` class is available (library installed) and
whether `temporary://tcpdf/cache` could be created/written.
