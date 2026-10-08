<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Turbo SMS Notify — agent orientation

Webform-submission SMS/Viber sending via TurboSMS + status webhook.

- Version 1.0.x, core ^10, deps webform.
- Send: `Sender::send()` POSTs to `https://api.turbosms.ua/message/send.json` with `Authorization: Bearer <api_token>` (config). TLS: default Guzzle, `verify` NOT disabled — no TLS finding. API token in config (plaintext, standard).
- Webhook `/turbosms/webhook` (`_access: TRUE`, POST only): `WebhookController::receive` checks `X-TurboSMS-Signature` via `hash_equals` when `webhook_secret` set; **the webhook only logs, it performs no mutation/fulfillment**, so the optional-signature gap is low risk. Sound.
