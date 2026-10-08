<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Powerling Translation Provider for TMGMT (tmgmt_powerling) — agent index

**TMGMT translator plugin for Powerling professional human translation, with API callbacks that re-fetch (never trust) results.**

- **Version:** 8.x-1.x (dev-1.x / tag 8.x-1.11) · **Core:** ^10.1 || ^11 · **Depends:** tmgmt, tmgmt_file
- **Plugin:** `PowerlingTranslator` (tmgmt Translator) — Guzzle + `Bearer` token, HTTPS.
- **Routes (anonymous, `_access: 'TRUE'`):** `tmgmt_powerling.order_callback` `/tmgmt_powerling/callback/order/{tmgmt_job}/{order_id}`; `tmgmt_powerling.file_callback` `/tmgmt_powerling/callback/file/{tmgmt_job_item}/{order_id}/{file_id}`.
- **Permissions:** none of its own (uses TMGMT permissions).
- **Security:** callbacks are anonymous but SOUND — they re-fetch order status (`getOrder()`) and translated files (`updateTranslation()`) from Powerling over the authenticated Bearer channel and do not trust the request body; both first assert the job's plugin is `PowerlingTranslator` (`PowerlingController.php:59-116`). TLS at Guzzle defaults. Residual: guessed job+order ids can trigger a redundant authenticated re-fetch (low impact).

See [api/callbacks.md](api/callbacks.md)
