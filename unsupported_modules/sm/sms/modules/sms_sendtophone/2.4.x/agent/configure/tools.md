# Send To Phone — routes, permissions, plugins

## Routes & permissions (`sms_sendtophone.routing.yml`, `.permissions.yml`)

| Route | Path | Permission |
|---|---|---|
| `sms_sendtophone.page` | `/sms/sendtophone/{type}/{extra}` (`type`,`extra` default null) | `access content` |
| `sms_sendtophone.admin_overview` | `/admin/config/smsframework/sendtophone` | `administer smsframework` |

Permission `send to any number` — allows sending to an arbitrary destination number.

## Send form (`SendToPhoneForm`)

`{type}` selects the payload source:
- `node` — `{extra}` is a node id; the node body/content is prepared for sending.
- `field` / `cck` — the `?text=` query value (a field value) is sent.
- `inline` — the `?text=` query value (highlighted text, from the filter link) is sent.

Access logic in `buildForm()`: it loads the current user's phone numbers via
`sms.phone_number`. If the user has `send to any number` **or** has at least one (verified)
phone number, the send form is shown; otherwise the user is prompted to set up/verify a number
or sign in/register. Users with `send to any number` may type any destination; others send to
their own number(s). Delivery uses `sms.provider` with `Direction::OUTGOING`.

## Inline filter (`filter_inline_sms`, `FilterInlineSms`)

Text-format filter. Converts `[sms]TEXT[/sms]` into a highlighted span plus a "send to phone"
link/icon to `sms_sendtophone.page` (type `inline`, `?text=<urlencoded>`). Settings: `display`
(`icon`/`text`), `display_text`, `default_icon` (use the bundled `sms-send.gif`), and
`custom_icon_path`. Enable it on a text format to let editors mark sendable snippets.

## Field widget & formatter

- Widget `SmsSendWidget` (`Plugin/Field/FieldWidget`) — adds a send-to-phone control on a
  field edit form.
- Formatter `SmsLinkFormatter` (`Plugin/Field/FieldFormatter`) — renders a field value with a
  "send to phone" link.

Config schema lives in `config/schema/sms_sendtophone.schema.yml`; a small settings config is
provided in `config/install/`.
