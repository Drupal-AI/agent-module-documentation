<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `qrcode_fields.qrimage` service

Builds a render array for a QR image from structured data. Used internally by the field
formatters/widgets and blocks; callable from custom code.

Service id: `qrcode_fields.qrimage` → `Drupal\qrcode_fields\Service\QRImage`
(interface `QRImageInterface`). Injects the `qrcode_fields` plugin manager, `token`, `config.factory`.

## Methods

- `setPlugin(string $pluginId): self` — pick the QR-URL-service plugin (`goqr`, `tec_it`, `gchart`,
  or a custom one). Chainable. If never called, defaults to `gchart`.
- `build(array $data, int|string $width, int|string $height): array` — returns a `theme:image`
  render array (`#uri` = the service image URL, optional `#suffix`/`#alt` markup).

## `$data` keys

- `field_type` (required) — one of `qrcode_url|qrcode_text|qrcode_phone|qrcode_sms|qrcode_email|`
  `qrcode_wifi|qrcode_mecard|qrcode_vcard|qrcode_event`. Selects which payload string is assembled.
- The payload fields for that type (e.g. `url`, `text`, `phone`+`message`, `network_name`+`password`
  +`encryption`+`hidden`, vCard/meCard/event fields).
- `objects` — array keyed by entity-type id (`['node' => $node]`) used as the Token replacement
  context, so string values may contain tokens like `[node:url]`.
- `plugin_id` — the *formatter/block* plugin id; when it is `qrcode_fields_formatter_url` the alt
  text is rendered as an action label ("Send email", "Add to contact", …) rather than a data dump.

## Example

```php
$qr = \Drupal::service('qrcode_fields.qrimage');
$build = $qr->setPlugin('goqr')->build([
  'field_type' => 'qrcode_url',
  'url' => '[node:url]',
  'objects' => ['node' => $node],
], 240, 240);
// $build is a theme:image render array pointing at api.qrserver.com.
```

Notes:
- Payload strings follow the standard formats: `TEL:`, `SMSTO:`, `MATMSG:`, `WIFI:T:…;S:…;P:…;`,
  `MECARD:`, `BEGIN:VCARD\nVERSION:3.0…`, `BEGIN:VCALENDAR…VEVENT…`.
- Alt/label pieces are built with `t()` `@placeholder` interpolation (values are HTML-escaped) and
  wrapped in `Markup::create()`.
- The generated `#uri` points at the selected **external** QR service with the payload in the query
  string (see the privacy note in [configure/fields-and-blocks.md](../configure/fields-and-blocks.md)).
