# Configuration

The QR appearance is set once, site-wide, on the settings form at **Configuration → Endroid
QR Code** (`/admin/config/endroid_qr_code`), behind the core **Administer site
configuration** permission. These settings apply to every QR code the module generates
(the anonymous image routes read the same config). Values are stored in the
`endroid_qr_code.settings` config object.

## The settings

| Setting | Default | Notes |
|---------|---------|-------|
| **Size** | 600 | The QR code's size in pixels. Required; must be between 100 and 1000. |
| **Margin** | 100 | The quiet-zone margin (white border) around the code, in pixels. Required; 0–200. Increase it for print layouts. |
| **Logo file** | (none) | An optional image drawn in the center of every QR code — upload a managed file (for example a company logo). On save the file is made permanent and its file ID is stored. |
| **Logo width** | 50 | The logo's width in pixels (up to 1000). Only relevant when a logo is set. |
| **Label** | (none) | Optional text drawn beneath the QR code. |

Click **Save configuration** to apply. Because these are global, every field displayed with
the Endroid Qr Code formatter uses the same size, margin, logo, and label — there are no
per-field overrides.

## Setting values with Drush

The module has no Drush commands of its own, but you can use core Drush:

```bash
drush cget endroid_qr_code.settings
drush cset endroid_qr_code.settings set_size 400 -y
```

## How the images are generated (for reference)

The formatter renders an `<img>` pointing at one of two module routes, both open to
anonymous visitors so the images load for any reader:

- Valid URLs go to `/image-qr-generate-with-url?path=<url>`.
- Other strings go to `/image-qr-generate/<content>`.

In both cases the value is only *encoded into the QR bitmap* — the module does not fetch the
URL on the server, so these are generators, not proxies. The image is produced with the
`endroid/qr-code` library (high error correction) and served as a JPEG.
