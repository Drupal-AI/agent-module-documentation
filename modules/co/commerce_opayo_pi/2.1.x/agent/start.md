<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Opayo Pi (commerce_opayo_pi) — agent index

**Drupal Commerce payment gateway for Opayo (Elavon) via the Pi REST API**, with browser-side card tokenization and 3D Secure.

- **Version:** 2.1.x
- **Core:** `^9 || ^10 || ^11`  · package Commerce (contrib)
- **Requires:** `commerce:commerce_payment`, `phone_international`, `queue_unique`.
- **Settings:** `commerce_opayo_pi.settings` (`/admin/commerce/config/opayo_pi/settings`, permission `administer opayo transactions`).
- **Flow routes (`access content`, `no_cache`):** `.3d_secure_page` `{order}`, `.3d_secure_result` `{opayo_transaction_id}`, `.merchantsessionkey` `{commerce_order}/{instruction}`, `.merchantsessionkey2` `{gw_id}/{instruction}`.
- **Services:** `OpayoPi` (Pi REST wrapper), `Cron` (+ `queue_unique`), address-format subscriber, logger channel.

**Security:** the four `access content` routes are Opayo 3D-Secure / merchant-session-key checkout-flow endpoints; the merchant session key is a public-flow token (not order-specific sensitive data), so this is a low/no finding (previously reviewed — documented, not re-investigated). Card PAN is tokenized client-side and never reaches the back-end. Admin settings gated by `administer opayo transactions`. No security findings.

See [configure/gateway.md](configure/gateway.md)
