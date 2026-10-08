<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Signifyd (commerce_signifyd) — agent index

**Drupal Commerce ⇄ Signifyd fraud protection: creates cases, sends order data, ingests signed webhooks, auto-transitions orders.**

- **Version:** 1.0.x
- **Core:** ^10.2 || ^11
- **Depends:** commerce, commerce_order, commerce_log, commerce_payment.
- **Configure:** `/admin/commerce/config/signifyd/settings` (`access commerce administration pages`).
- **Webhook:** `POST /webhook/signifyd/{signifyd_team}` — `_access: TRUE`, authenticated by HMAC-SHA256 of the raw body against the team API key (`X-SIGNIFYD-SEC-HMAC-SHA256`).
- **Entities:** `signifyd_team` (config, holds API key), `signifyd_case` (content).
- **Sub-modules:** `device_fingerprint`, `user_order_data`.
- **Security:** Webhook is `_access: TRUE` but self-authenticates via HMAC-SHA256; invalid/unsigned payloads are rejected (400) before any order-state change. The `ABCDE` fallback key is confined to the case-less `cases/test` topic (Signifyd's documented test placeholder). Minor: comparison uses `==` rather than `hash_equals()` (both equal-length base64 strings). Reviewed as sound.

See [configure/setup.md](configure/setup.md) and [api/webhook.md](api/webhook.md).
