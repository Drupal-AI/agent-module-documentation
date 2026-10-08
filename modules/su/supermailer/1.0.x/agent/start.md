<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Supermailer (supermailer) — agent index

**Double opt-in newsletter subscribe/unsubscribe forms + blocks that confirm by hashed link and notify a recipient address.**

- **Version:** 1.0.x (1.0.0)
- **Core:** ^10 || ^11
- **Route:** `supermailer.subscribe.confirm` → `/supermailer/subscribe/confirm/{mail}/{hash}` — `_access: 'TRUE'` (anonymous), no_cache; access enforced by `CryptKey::validateHash`
- **Services:** `supermailer.crypt_key` (CryptKey, uses `@private_key` + hash salt), `supermailer.mail_handler` (MailHandler)
- **Blocks:** `SupermailerSubscribeBlock`, `SupermailerUnsubscribeBlock`
- **Config:** `supermailer.settings` (recipient, subscribe_ok_page, crypt_key_expires_interval)
- **Cron:** purges expired tokens (`supermailer_cron`)
- **Optional CAPTCHA points** for both forms (config/optional)

**Security:** the anonymous confirm route is **sound** — the hash is a per-address HMAC (`CryptKey.php:71`) keyed on the site private key + hash salt, stored server-side and matched by exact DB equality with an expiry window (`CryptKey.php:85-95`); not guessable/forgeable, compare is exact not loose. Confirmation only triggers a notification mail to the admin-configured recipient. No other public endpoints.
