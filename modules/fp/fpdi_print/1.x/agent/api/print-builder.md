<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PrintBuilder service, positions array & alter hook

## Service

`fpdi_print.print_builder` → `Drupal\fpdi_print\PrintBuilder` (`src/PrintBuilder.php`). Constructor
args: `entity_type.manager`, `stream_wrapper_manager`, `current_user`, `config.factory`,
`file_system`, `%app.root%`.

```php
$pdf = \Drupal::service('fpdi_print.print_builder')
  ->getPdf(array $positions = [], string $filePdfTemplate = '', $header = FALSE, $footer = FALSE);
```

Returns a `Drupal\fpdi_print\Pdf` (a `setasign\Fpdi\Tcpdf\Fpdi` subclass) — or a `\FPDM` instance
when any position uses AcroForm `form:` filling. Output it yourself, e.g.:

```php
$response = new \Symfony\Component\HttpFoundation\StreamedResponse();
return $response->setCallback(function () use ($pdf) {
  ob_clean();
  $pdf->Output();       // inline; or $pdf->Output($name, 'D') to download
});
```

## `getPdf()` behaviour (from source)

- Reads config `fpdi_print.settings`; sets font `dejavusans`; author = current user display name,
  creator = site name (only when authenticated).
- **Header/footer**: string `$header`/`$footer` become `Pdf::$headerHTML`/`$footerHTML` (rendered by
  the custom `Pdf::Header()`/`Footer()` via `writeHTML`); an array `$header` sets `Pdf::$header`
  (logo/title/string layout). `footer_height` config overrides `Pdf::$footerHeight`.
- **Template import**: if `$filePdfTemplate` is set, `getPath()` resolves it (numeric = file entity
  fid → real path; else an existing path as-is; else a site-URL-prefixed URL stripped to a
  root-relative path). `setSourceFile()` returns the page count; each page is `importPage()` +
  `getTemplateSize()` + `AddPage(L|P, size)` + `useTemplate()`. Without a template, `AddPage()` uses
  the `orientation`/`page_format` config.
- **Per-position rendering** for each `$positions[$page][]` entry (default x/y = 0):
  - `text` → `formatText()` (decode entities, `<br>`→newline, `strip_tags`) then `SetXY` +
    `MultiCell` (if `height`) or `Write`.
  - `image` → base64 data URI decoded and passed as TCPDF `@`-data; otherwise `formatImage()`
    resolves it (pulls `<img src>` from an HTML fragment, then `getPath()`, and requires
    `is_file && is_readable && getimagesize`). `eps`/`ai` → `ImageEps`, `svg` → `ImageSVG`, else
    `Image` (sized via `getimagesize`, EXIF auto-rotate for JPEG).
  - `html` → `writeHTML` (or `MultiCell` with `height`), with the optional `default_css` `<style>`
    prepended.
  - `pdf` → `setSourceFile()` + import every page and `useTemplate()` (merge a whole PDF).
  - `form` → collected and applied at the end via `\FPDM($template)->Load($fields, TRUE)->Merge()`
    (AcroForm field fill; requires a PDF-1.4 form template).
  - Any remaining key mapping to a `set<Key>()` method on `Pdf`/TCPDF is invoked with the value
    (string → single arg, array → spread) — e.g. `rotation:`, `textColor:`.

## Positions array shape

```php
$positions = [
  1 => [                                   // page number, MUST start at 1 (not 0)
    ['x' => 10, 'y' => 20, 'text' => 'Text on page 1'],
    ['x' => 15, 'y' => 40, 'height' => 50, 'width' => 50, 'image' => 101], // fid
    ['x' => 15, 'y' => 50, 'image' => '/path/to/image.png'],
    ['x' => 15, 'y' => 60, 'image' => '<img src="/a.png"/><img src="/b.jpg"/>'],
  ],
  2 => [
    ['x' => 10, 'y' => 20, 'height' => 10, 'html' => 'Show <b>html</b> on page 2'],
  ],
  3 => [
    ['pdf' => '/path/to/merge/file.pdf'],  // merge extra PDF pages
  ],
];
```

## Alter hook

```php
/** Implements hook_fpdi_print_views_alter(). */
function mymodule_fpdi_print_views_alter(array &$positions, $view, $filePdfTemplate) {
  // Mutate $positions (page => list of entries) before the PDF is built.
}
```
Invoked in `ViewPrintController::getPdfView()` right before `PrintBuilder::getPdf()`.

## `Pdf` engine (`src/Pdf.php`)

`Pdf extends setasign\Fpdi\Tcpdf\Fpdi`. Overrides `Header()` (draws the logo image + title/slogan or
`headerHTML`) and `Footer()` (HTML footer via `writeHTMLCell` + auto "Page n/N" when >1 page). Public
tunables: `$headerMarginTop` (8), `$footerHeight` (15), `$style`. `getReader()` exposes the FPDI
parser (used by `FormFields` to enumerate AcroForm field names via
`StreamReader::getFormFields()`).

## `FormFields` service

`fpdi_print.form_fields` → `FormFields::get($pdfFile)` opens a template with FPDI and returns
`[pageNo => [fieldName, …]]` of AcroForm fields — a helper for discovering the `form:` names to fill.
It is a standalone service; the module's own routes do not call it.
