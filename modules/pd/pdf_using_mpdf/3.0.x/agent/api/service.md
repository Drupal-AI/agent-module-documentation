# The conversion service

Service id **`pdf_using_mpdf.conversion`**, class `Drupal\pdf_using_mpdf\Conversion\ConvertToPdf`,
implementing `Drupal\pdf_using_mpdf\ConvertToPdfInterface`.

```php
/** @var \Drupal\pdf_using_mpdf\ConvertToPdfInterface $pdf */
$pdf = \Drupal::service('pdf_using_mpdf.conversion');
$response = $pdf->convert($html, $settings, $context);
```

## `convert(string $html, array $settings = [], array $options = [])`

- `$html` — the HTML body to render (required; empty logs an error and returns `NULL`).
- `$settings` — optional overrides merged over the stored config **and** `getDefaultConfig()`
  (order: stored settings → default mPDF config → your `$settings`). Use the same keys as the
  config object (see configure/settings.md), e.g. `['pdf_page_size' => 'Letter', 'orientation' => 'L']`.
- `$options` — token replacement context, typically `['node' => $node]`; every non-array setting
  string is passed through the Token service with this context.

### Return value depends on `pdf_save_option`

- `0` (browser) → `Symfony\Component\HttpFoundation\Response`, `Content-Type: application/pdf`,
  `inline` disposition. Return it from a controller.
- `1` (download) → same but `attachment` disposition.
- `2` (save to server) → writes the file under `<scheme>://<pdf_save_path>/` and returns `[]`.

On an `MpdfException` the error is logged and the method returns `NULL` (mode 0/1 throw a
`BadRequestHttpException` from the output stage).

## Convert any entity / markup

```php
// Render an entity to HTML, then hand it to the converter.
$view = \Drupal::entityTypeManager()->getViewBuilder('node')->view($node, 'full');
$html = \Drupal::service('renderer')->renderInIsolation($view);
$response = \Drupal::service('pdf_using_mpdf.conversion')
  ->convert((string) $html, ['pdf_filename' => 'invoice-[node:nid]'], ['node' => $node]);
```

The node route (`GeneratePdf::generate`) does exactly this: loads config, invokes
`hook_mpdf_settings_alter`, optionally switches to the anonymous account, renders the node in
`view_mode`, invokes `hook_mpdf_html_alter`, then calls `convert()`.

Other public methods on the service: `getConfig()` (stored settings), `getDefaultConfig()`
(the computed mPDF constructor array), `output()`, `replaceAllSettingsTokens()`.
