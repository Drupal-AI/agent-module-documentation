<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Endroid QR Code — image-generation routes & responses

Two controller routes generate a QR image on the fly (`QRImageGeneratorController`). **Both are open
to anonymous users** (`requirements: _access: 'TRUE'`), so the `<img>` produced by the formatter
loads for any visitor. Only the third, the settings form, is permission-gated.

| Route | Path | Access | Controller method |
|---|---|---|---|
| `endroid_qr_code.qr.generator` | `/image-qr-generate/{content}` | anonymous | `::image($content)` |
| `endroid_qr_code.qr.url` | `/image-qr-generate-with-url?path=<url>` | anonymous | `::withUrl()` (reads `?path`) |
| `endroid_qr_code.admin_settings` | `/admin/config/endroid_qr_code` | `administer site configuration` | settings form |

Both image methods build a `QRImageResponse($content, logoFile, logoWidth, label, size, margin)`,
pulling `logoFile`/`logoWidth`/`label`/`set_size`/`set_margin` from `endroid_qr_code.settings`. The
`{content}` path segment or `path` query value is the string **encoded into the QR bitmap** — the
module does not fetch that URL server-side, so these routes are QR generators, not proxies/redirects.

## Response pipeline

- `QRImageResponse::sendContent()` → `generateQrCode($data)`:
  - `Endroid\QrCode\QrCode` (UTF-8, `ErrorCorrectionLevel::High`, `size`, `margin`,
    foreground black / background white), optional `Logo(path: logoFile, resizeToWidth: logoWidth)`
    and optional red `Label(text)`, written with `PngWriter`.
  - The PNG is wrapped in `QRCodeResponse` then re-encoded to **JPEG** via GD
    (`imagecreatefromstring` → `imagejpeg`). `sendHeaders()` forces `Content-Type: image/jpeg`.
- `getLogoFile()` loads the file entity by the configured fid and returns its real path or external
  URL (admin-configured; not user input).

## Building the URLs in code

The formatter builds them with `Url::fromRoute()`:
```php
// URL value:
Url::fromRoute('endroid_qr_code.qr.url', [], ['query' => ['path' => $value]])->toString();
// Non-URL string:
Url::fromRoute('endroid_qr_code.qr.generator', ['content' => $value])->toString();
```

No services are exported for reuse; call the routes (or replicate `QRImageResponse`) directly.
