<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Zammad Webform Handler — configuration

## Connection settings (`/admin/config/system/zammad-webform-handler`)
`zammad_webform_handler.settings`:
- `authentication_method` — currently `http-token`.
- `zammad_url` — Zammad instance base URL.
- `http_token_secret` — Zammad API token (**stored plaintext in config**; treat exports as sensitive).
- `timeout` — request timeout in seconds (0 = none).
- `verify` — SSL certificate verification checkbox; **keep enabled**. The client is built as `new Client(['url'=>..., 'http_token'=>..., 'timeout'=>..., 'verify'=>...])`.

## Handler settings (per webform)
Required: `ticket_title`, `ticket_body`, `ticket_type`, `ticket_group` (all token-aware).
`additional_ticket_field_0..9` — key/value pairs, values token-aware.
User creation:
- `user_creation_fallback` = `simple-user` (email only) or `complex-user`.
- Complex user standard fields: first/second name, web, telephone, mobile, fax, notes.
- `additional_user_field_0..9` — key/value pairs, values token-aware.

## Runtime flow (`postSave`)
- `complex-user`: search Zammad user by `email:{mail}`, create if missing, then create ticket.
- otherwise: create ticket with `customer = {mail}` (Zammad `guess:` behavior links/creates).
- API errors are logged to channel `zammad_webform_handler`.

## Trust boundary
Outbound only; no route accepts inbound Zammad callbacks. The admin form is the only endpoint and is permission-gated.
