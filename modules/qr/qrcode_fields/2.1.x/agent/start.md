<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# QR Code Fields — agent index

Nine `qrcode_*` field types + blocks that render a QR code image built from field/token data via
a pluggable **external** QR-image service. No global config page (`configure` null), no permissions,
no Drush. Depends on `token`, `block`, `field`. Provides a config schema and one plugin type.

- **Field types, widgets, formatters, blocks, the `qrcode_plugin` setting, image size** →
  [configure/fields-and-blocks.md](configure/fields-and-blocks.md)
- **The `qrcode_fields` QR-URL-service plugin type (goqr/tec_it/gchart) & writing your own** →
  [plugins/qr-service.md](plugins/qr-service.md)
- **The `qrcode_fields.qrimage` service (build a QR render array in custom code)** →
  [api/qrimage.md](api/qrimage.md)

Key facts:
- Field types: `qrcode_url`, `qrcode_text`, `qrcode_phone`, `qrcode_sms`, `qrcode_email`,
  `qrcode_wifi`, `qrcode_mecard`, `qrcode_vcard`, `qrcode_event`.
- Formatters: `qrcode_fields_formatter` (image, sized) and `qrcode_fields_formatter_url`.
- Field setting `qrcode_plugin` selects the service; default **`goqr`** (api.qrserver.com).
- Service plugins live in `src/Plugin/qrcode_fields/`: `goqr`, `tec_it`, `gchart` (deprecated).
- **Privacy note:** payload (incl. WiFi passwords / vCard data) is placed in the external
  service URL and fetched by the visitor's browser — see the configure doc.
- All text inputs support Token replacement against the host entity.
