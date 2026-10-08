# Using the TCPDF wrapper

## The factory

```php
function tcpdf_get_instance(array $params = [], array $class = [], array $config = []): TCPDFDrupal
```

Always use this instead of `new TCPDF(...)`. It returns a fresh `TCPDFDrupal` (subclass of `TCPDF`).
The signature and behaviour are unchanged from 2.x.

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
  'title'  => 'My document',
  'footer' => ['html' => 'Confidential — <em>page footer</em>'],
]);
// DrupalInitialize() already called AddPage(); otherwise call it yourself.
$pdf->writeHTML($renderedHtml);            // HTML-to-PDF
$binary = $pdf->Output('doc.pdf', 'S');    // 'S' = return as string
```

## `TCPDFDrupal::DrupalInitialize(array $options)`

Convenience setup without subclassing. It sets document info, margins, fonts and **calls `AddPage()`**.
Recognized keys:

- `title`, `subject`, `author` — each default to the site name (`system.site` → `name`).
- `keywords` — default `'pdf, drupal'`.
- `logo_path` — path to a logo image for the header.
- `header` / `footer` — each either `['html' => '<markup>']`, or `['callback' => <callable>]`. A callback
  may be a plain callable (receives the `TCPDFDrupal` instance), `[$object, 'method']`, a closure, or an
  array `['function' => <callable>, 'context' => <mixed>]` whose callable receives the instance **and**
  the context. The overridden `Header()`/`Footer()` render whichever was configured (via the private
  `drupalGenRunningSection()`), falling back to `parent::Header()`/`parent::Footer()` when empty.

## Config constants (`tcpdf.config.inc`)

3.0 delegates almost all configuration to TCPDF 7's own `tcpdf_autoconfig.php`, which defines every
`K_*`/`PDF_*` constant the module leaves undefined. The module's include now sets only two, and only if
not already defined — so pre-define any constant (e.g. in `settings.php`) to override:

- `K_PATH_FONTS` — resolved by the `FontDirectory` service (never contains `..` segments, which the
  TCPDF 7 file sandbox rejects). Left undefined if no font directory is found, in which case TCPDF uses
  its own default.
- `PDF_IMAGE_SCALE_RATIO = 1.25` — kept at the value the module has always used (TCPDF 7's own default
  would resize images in existing documents).

Page format, orientation, margins, fonts and the rest come from `tcpdf_autoconfig.php`. There is no
module-managed cache directory in 3.0 (the old `temporary://tcpdf/cache` / `K_PATH_CACHE` handling is
gone).

## Fonts

TCPDF 7 reads fonts from `tecnickcom/tc-lib-pdf-font`, which ships none — they must be built after each
install/update of that package:

```bash
php vendor/tecnickcom/tc-lib-pdf-font/util/build_fonts.php
```

To keep fonts across Composer updates, build them outside `vendor/` and point settings at them:

```php
$settings['tcpdf_fonts_path'] = $app_root . '/../private/tcpdf-fonts';
```

The `FontDirectory` service (`\Drupal\tcpdf\FontDirectory`, autowired) resolves the directory:
`getExpectedPath()` returns the configured path or the package's `target/fonts`; `getPath()` returns it
only if it exists; `hasCoreFonts()` checks for `core/helvetica.json`.

## Local files and HTML (TCPDF 7 sandbox)

TCPDF 7 reads local files only from a trusted-directory list (system temp dir, working dir, some library
dirs). To embed files from elsewhere, pass a real path and add the directory to `K_ALLOWED_PATHS` in
`settings.php`; remote image hosts are controlled by `K_ALLOWED_HOSTS`. `writeHTML()` ignores `<tcpdf>`
tags by default; to allow TCPDF method calls from HTML, define `K_TCPDF_CALLS_IN_HTML` and list the
permitted methods in `K_ALLOWED_TCPDF_TAGS`. All of these are site-level overrides; the module ships none
of them.

## Requirements

`\Drupal\tcpdf\Hook\TcpdfRequirements` implements `hook_runtime_requirements()` (via the
`#[Hook('runtime_requirements')]` attribute) and reports whether the `TCPDF` class is available and
whether the core fonts were found; a missing font build is reported as an error on the status report.
