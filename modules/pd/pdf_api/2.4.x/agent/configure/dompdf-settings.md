# Dompdf settings (`pdf_api.settings`)

The only bundled admin UI. Form `Drupal\pdf_api\Form\DompdfSettingsForm`, route
`pdf_api.settings` at `/admin/config/system/pdf-api`, permission `administer site
configuration`. All values persist to the **`pdf_api.dom_pdf.settings`** config object and
are read by the `dompdf` generator plugin at construction time. Other backends (mpdf, tcpdf,
wkhtmltopdf) do **not** read this config.

## Config keys (`pdf_api.dom_pdf.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `defaultFont` | string | `serif` | Default font family. |
| `dpi` | integer | `96` | DPI used for images/units. |
| `fontHeightRatio` | float | `1.1` | HTML→PDF font point-size ratio. |
| `pdfBackend` | string | `CPDF` | Rendering engine: `CPDF`, `GD`, or `PDFLib`. |
| `pdflibLicense` | string | `''` | PDFlib license key (only for `PDFLib`). |
| `isPhpEnabled` | boolean | `false` | Allow inline PHP in HTML (security risk). |
| `isRemoteEnabled` | boolean | `true` | Allow loading remote images/CSS. |
| `isJavascriptEnabled` | boolean | `true` | Allow inline JavaScript. |
| `chroot` | sequence(string) | `['.']` | Filesystem roots dompdf may read (relative to `DRUPAL_ROOT`). |
| `fontDir` | string | `temporary://` | dompdf font directory. |
| `fontCache` | string | `temporary://` | dompdf font cache directory. |
| `tempDir` | string | `temporary://` | Temp directory. |
| `debugPng`, `debugKeepTemp`, `debugCss`, `debugLayout`, `debugLayoutLines`, `debugLayoutBlocks`, `debugLayoutInline`, `debugLayoutPaddingBox` | boolean | see below | dompdf debug flags. |

Debug defaults from `config/install`: `debugPng`, `debugKeepTemp`, `debugCss`, `debugLayout`
are `false`; `debugLayoutLines`, `debugLayoutBlocks`, `debugLayoutInline`,
`debugLayoutPaddingBox` are `true`.

## Read / write with drush

```bash
drush cget pdf_api.dom_pdf.settings
drush cget pdf_api.dom_pdf.settings dpi
drush cset -y pdf_api.dom_pdf.settings dpi 300
drush cset -y pdf_api.dom_pdf.settings defaultFont sans-serif
drush cset -y pdf_api.dom_pdf.settings isJavascriptEnabled 0   # 0/false disables
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('pdf_api.dom_pdf.settings')
  ->set('dpi', 300)
  ->set('isJavascriptEnabled', FALSE)
  ->save();
```

The `dompdf` plugin reads these via `ImmutableConfig $settings` and maps them onto
`Dompdf\Options` (`setDefaultFont`, `setDpi`, `setIsRemoteEnabled`, `setChroot`, …). Changing
config takes effect on the next generation; no cache rebuild is required for config reads.
