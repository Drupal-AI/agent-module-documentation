<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Endroid QR Code provides a field formatter that renders the value of a text or link field as a scannable QR code image, using the `endroid/qr-code` PHP library.

---

The module exposes one field formatter, `endroid_qr_code_formatter` ("Endroid Qr Code"), applicable
to `string`, `link`, and the module's own (deprecated) `endroid_qr_code` field types. For each field
value it builds an `<img>` whose `src` points at a module route that generates the PNG/JPEG QR code
on the fly: valid URLs are routed to `endroid_qr_code.qr.url` (`/image-qr-generate-with-url?path=…`)
and non-URL strings to `endroid_qr_code.qr.generator` (`/image-qr-generate/{content}`). Both image
routes are intentionally **open to anonymous users** (`_access: 'TRUE'`) so the images render for
any visitor; the supplied value is only encoded into the QR bitmap (no server-side fetch of the URL
happens). A site-wide settings form at `/admin/config/endroid_qr_code`
(`endroid_qr_code.admin_settings`, gated by the core `administer site configuration` permission)
controls the QR `set_size` (100–1000px), `set_margin` (0–200px), an optional center `logo_file`
(managed file) with `logo_width`, and an optional `label`, stored in `endroid_qr_code.settings`.
Generation happens in `QRImageResponse` (Endroid v6 `QrCode` with high error correction, then
re-encoded to JPEG via GD). The `endroid_qr_code` field type and its widget are **deprecated in 4.1
and removed in 5.0** — use a plain string or link field with this formatter instead. The module
requires PHP 8.4 and the Composer library `endroid/qr-code:^6.1`.

---

- Render a URL link field as a scannable QR code on a node.
- Turn a plain text field (e.g. a product code) into a QR image.
- Add a "scan to open this page" QR code using a link field with the page URL.
- Generate QR codes for event tickets or check-in URLs stored in a field.
- Show a QR code for a Wi-Fi/contact string held in a string field.
- Embed a company logo in the middle of every generated QR code.
- Set a consistent QR size site-wide (e.g. 600px) via the settings form.
- Adjust the quiet-zone margin around QR codes for print layouts.
- Add a text label under generated QR codes.
- Display QR codes for vCard or mailto strings.
- Provide print-ready QR codes on flyers rendered from Drupal content.
- Let anonymous visitors load QR images without authentication (public routes).
- Generate a QR code directly from a URL via `/image-qr-generate-with-url?path=<url>`.
- Generate a QR code from arbitrary text via `/image-qr-generate/<content>`.
- Migrate off the deprecated Endroid QR field type to a string/link field + formatter.
- Add QR codes to link fields in Views-rendered listings.
- Produce QR codes for coupon or promotion codes.
- Show a QR pointing at the current entity's canonical URL (store the URL in a field).
- Serve QR codes as image files reusable in emails or exports.
- Standardize QR appearance (size, margin, logo, label) across the whole site from one config page.
