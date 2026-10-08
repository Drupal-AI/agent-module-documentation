<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Send and receive SMS via the Gammu SMSD backend.

---

Gammu SMS Daemon integrates Drupal with the Gammu SMSD (SMS gateway daemon) — sending and receiving SMS through a Gammu-managed modem/gateway, with an admin UI (inbox/sent) and an HTTP send API.

**Security warning (as shipped, 8.x-1.2):** the send API `api/gammu/send` is `_access: 'TRUE'` and authenticates only by comparing the `Authorization` header to a configured `gammu_token` with **loose `==`**; since `gammu_token` is **unset by default**, `null == null` (no Authorization header) passes — so an anonymous attacker can send arbitrary SMS through the gateway (cost abuse / spam / phishing) until a token is set. **Set a strong `gammu_token`** (and ideally the module should reject an empty token and use `hash_equals()`). The admin routes are gated by `administer gammu`. Supports Drupal 8.8 through 11.

---

- Send and receive SMS via Gammu.
- Provide inbox/sent admin UI.
- Expose an HTTP send API.
- WARNING: `api/gammu/send` is `_access: TRUE`.
- Authenticate by a loose `==` token check.
- Bypass auth when `gammu_token` is unset (null==null).
- Risk anonymous SMS abuse until a token is set.
- Require setting a strong `gammu_token`.
- Gate admin routes by `administer gammu`.
- Support Drupal 8.8 through 11.
- Configure the gateway.
- Harden the send token.
- Support Drupal.
- Support Drupal.
- Support Drupal.
