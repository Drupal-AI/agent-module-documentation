<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Postoffice Commerce mail

## Point Commerce at the plugin
The plugin id is `postoffice_commerce_mail`. Set it as Commerce's mail interface:
```
drush config:set system.mail interface.commerce postoffice_commerce_mail
```
Most Commerce extensions (e.g. commerce_shipping) send through the commerce core mail
handler and are covered by the line above.

**Commerce License** uses core's mail manager directly, so configure it explicitly too:
```
drush config:set system.mail interface.commerce_license postoffice_commerce_mail
```

## Message routing
`CommerceMail::emailFromMessage($message)`:
- `$message['id'] === 'commerce_order_receipt'` → `OrderReceiptEmail::createFromMessage()`
  (wraps the Commerce order; recipient langcode = customer's preferred langcode when authenticated).
- otherwise → `CommerceEmail::createFromMessage()` (keyed by `$message['key']`, `$message['langcode']`).

Both set from/to/subject and `->html($message['body'])`.

## Theming
`buildThemedEmail()` renders through theme hooks:
- `postoffice_commerce_email` (vars: body, email, key, langcode)
- `postoffice_commerce_order_receipt_email` (vars: body, email, order_type, langcode)

Template suggestions (most specific last):
- `..._email__{langcode}`, `..._email__{key}`, `..._email__{key}__{langcode}`
- `..._order_receipt_email__{langcode}`, `...__{order_type}`, `...__{order_type}__{langcode}`

Place overrides in your theme (works with `postoffice_compat_theme`).

## Notes
- Purely outbound mail transformation — no routes/permissions/config schema of its own.
- Attachments and site/localized email behaviour come from Postoffice's shared traits.
