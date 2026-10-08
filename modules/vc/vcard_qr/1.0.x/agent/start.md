<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# vCard QR (vcard_qr) — agent index

Form-to-QR contact-card generator. Version **1.0.0**. Route `/form/vcard`
(`\Drupal\vcard_qr\Form\VcardForm`).

- **Libraries**: `sabre/vobject` (vCard) + `chillerlan/php-qrcode`, wired via `vcard_qr.services.yml`.
  `QRBarCode::qrCode()` serializes the vCard and returns a base64 data-URI image.
- **Permission bug**: route requires `create vcard qrcode` but `permissions.yml` defines
  `created vcard qrcode` (typo) — no role can actually be granted the route permission as shipped.
- **Security**: `{{ newqrcode|raw }}` renders a module-built data URI, not user text; contact fields
  go into the QR image, not HTML. No XSS/SSRF sink found.
