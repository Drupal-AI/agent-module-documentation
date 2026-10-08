<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Endroid QR Code — agent index

Field formatter that renders a text/link field value as a QR-code image, plus two on-the-fly
image-generation routes. Uses Composer lib `endroid/qr-code:^6.1`, requires PHP 8.4. Site-wide
settings at `/admin/config/endroid_qr_code` (`configure: endroid_qr_code.admin_settings`). Config
schema present; no permissions.yml of its own, no plugins, no Drush.

- **Settings form + config keys, applying the formatter, the deprecated field type/widget** →
  [configure/qr-code.md](configure/qr-code.md)
- **The QR image routes (anonymous), how the formatter builds their URLs, the response classes** →
  [api/endpoints.md](api/endpoints.md)

Key facts:
- Formatter `endroid_qr_code_formatter` — field types `string`, `link`, `endroid_qr_code`.
- Config `endroid_qr_code.settings`: `set_size` (int, 100–1000), `set_margin` (0–200),
  `logo_file` (fid), `logo_width` (int), `label` (string). Settings form gated by core
  `administer site configuration`.
- Routes (both `_access: 'TRUE'`, anonymous): `endroid_qr_code.qr.generator`
  `/image-qr-generate/{content}` and `endroid_qr_code.qr.url` `/image-qr-generate-with-url?path=…`.
  The value is only encoded into the QR image; no server-side fetch of the URL is performed.
- Field type `endroid_qr_code` + widget `endroid_qr_code_widget` are **@deprecated in 4.1, removed
  in 5.0** (`no_ui = TRUE`) — use a string/link field instead.
