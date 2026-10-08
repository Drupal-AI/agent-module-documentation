<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# QR Code Generator — agent orientation

Floating per-page QR block + admin QR-from-text/URL; uses chillerlan/php-qrcode locally.

- Version 1.0.x, core `^9||^10`, lib chillerlan/php-qrcode. Admin forms under `/admin/qr-page/*` + `/admin/generate-qr/from-text-url` (`administer site configuration`); `/scanqrcode` (`access content`) renders a JS scanner page.
- `PageQRCode` block encodes the current URL; QR built locally as base64 (no remote fetch → no SSRF). Override lookups parameterised.
- Loads Font Awesome from cdnjs (external asset). Admin-gated config. Nothing exploitable found.