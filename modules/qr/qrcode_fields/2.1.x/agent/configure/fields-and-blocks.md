<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fields, widgets, formatters & blocks

No global settings page. Configure per field (Manage fields / form display / display) or per block.

## Field types (one per QR payload shape)

| Field type id | Encodes | Key stored properties |
|---|---|---|
| `qrcode_url` | URL (`https://…`) | `url` |
| `qrcode_text` | Arbitrary text | `text` |
| `qrcode_phone` | `TEL:` | `phone` |
| `qrcode_sms` | `SMSTO:` | `phone`, `message` |
| `qrcode_email` | `MATMSG:` | `email`, `subject`, `message` |
| `qrcode_wifi` | `WIFI:` | `network_name`, `password`, `encryption`, `hidden` |
| `qrcode_mecard` | `MECARD:` | `fname`,`lname`,`email`,`phone`,`address`,`url`,`note`,`organization`,`birthday` |
| `qrcode_vcard` | vCard v3 `BEGIN:VCARD` | as meCard plus `work_phone`, `title` |
| `qrcode_event` | vCalendar `BEGIN:VCALENDAR` | `summary`,`description`,`location`,`dstart`,`dend` |

Each field type declares its own `default_widget`/`default_formatter`. Every text sub-value
supports **Token** replacement against the host entity type (the widget shows a token tree link).

## Field settings — choosing the generator

Every field type's `fieldSettingsForm()` exposes:

- **`qrcode_plugin`** (select) — which QR-URL-service plugin renders the image. Options come from
  `plugin.manager.qrcode_fields`. **Default `goqr`** (api.qrserver.com). Others: `tec_it`,
  `gchart` (Google Chart API, deprecated). See [plugins/qr-service.md](../plugins/qr-service.md).

Schema: `field.field_settings.qrcode_fields` → `{ qrcode_plugin: string }`.

## Widgets

Widget ids mirror the field type (e.g. `qrcode_url_field_widget`, `qrcode_fields_widget`). Widget
settings include a **Default url/value** and QR image **width/height** (default `200×200`), and the
widget renders a **live preview** of the QR while editing.
Schema: `field.widget.settings.qrcode_fields_widget` → `{ text, image: { width, height } }`.

## Formatters

- `qrcode_fields_formatter` — renders the QR as an `<img>` (theme `image`), sized by the
  formatter's `image.width` / `image.height` (default 200×200); shows a settings summary with the
  active service plugin. `display_text` (bool) can echo the encoded text.
- `qrcode_fields_formatter_url` — variant whose `#alt`/link semantics treat the code as an actionable
  link ("Send email", "Add to contact", "Add event to calendar", …).

Schema: `field.formatter.settings.qrcode_fields_formatter` → `{ display_text: bool, image: { width, height } }`.

## Blocks

Nine blocks (category **QR Code Fields**), one per payload: `qrcode_url_block`, `qrcode_text_block`,
`qrcode_phone_block`, `qrcode_sms_block`, `qrcode_email_block`, `qrcode_wifi_block`,
`qrcode_mecard_block`, `qrcode_vcard_block`, `qrcode_event_block`. Each block form collects the same
data as its field plus `qrcode_plugin`, image dimensions and an optional `display_text`. Tokens are
supported in block values (`[site:url]`, etc.).

## Data flow at render time

Field/block → `qrcode_fields.qrimage` service builds the payload string for the `field_type`,
running each piece through Token replacement → `setPlugin($qrcode_plugin)` → the plugin returns a
remote image URL → rendered as `theme:image`.

## Privacy / external-service caveat (not a vuln, but flag to operators)

The chosen service (`goqr`/`tec_it`/`gchart`) receives the **full QR payload in the request URL**,
and the visitor's browser fetches the image directly from that third party. For sensitive payloads
(WiFi passwords, vCard contact data, private URLs) this means the data leaves your site and the
end-user's network to a third-party host. This is by design (admin/editor chooses the service);
if that is unacceptable, self-hosting a QR generator would require a custom service plugin.
