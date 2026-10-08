<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# QR Code Generator

Renders a QR code encoding the current page URL as a floating icon block, with a global default style and optional per-page overrides. Admins can also generate a QR image from any text/URL. QR images are produced locally as base64 data URIs by the chillerlan/php-qrcode library — nothing is fetched from a remote service.

---

# Installing & configuring

- Enable the module (pulls in `chillerlan/php-qrcode`).
- Global settings: `/admin/qr-page/config` (icon position/colour/type). Page overrides: `/admin/qr-page/override/add` and `/list`. Ad-hoc: `/admin/generate-qr/from-text-url`. All require `administer site configuration`.
- Place the 'All Pages QR Code Block' to show the floating QR.
- Config stored in `qrcode_generator.settings`; overrides in the `qrcode_generator_settings` table.

---

- `PageQRCode` block builds a QR of `schemeAndHost + requestUri + ?view=qrcode` per request.
- Per-page override rows (matched by request URI) customise the icon; otherwise global config is used.
- `QRCodeFromURL` form renders a QR image from admin-entered text via AJAX (base64 data URI).
- `QrScannerController::scanPage()` (`/scanqrcode`, permission `access content`) returns a themed JS-scanner page.
- QR generation is fully local (library) — no server-side fetching of user-supplied URLs, so no SSRF.
- Override lookups use parameterised DB conditions on the request URI.
- All configuration/override/generation routes require `administer site configuration`.
- The scan page is the only broadly accessible route and only renders a template + JS.
- The block cache max-age is 0 (per-request QR).
- Font Awesome CSS is loaded from a CDN (cdnjs) by the libraries — an external asset dependency.
- Encoded value is the page URL / admin text, not untrusted visitor input.
- Config schema is provided for settings.
- Useful for print-to-mobile hand-off, sharing page URLs, or campaign QR codes.
- No permissions of its own; relies on core `administer site configuration` and `access content`.
- No stored user content is rendered unescaped.
- No security-sensitive behaviour was identified.
