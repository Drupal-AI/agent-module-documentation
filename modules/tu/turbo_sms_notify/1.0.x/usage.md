<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Turbo SMS Notify

Sends SMS or Viber messages through the TurboSMS gateway when a Webform is submitted, using a Webform handler plugin, and can receive TurboSMS delivery-status webhooks.

- Webform handler `TurboSmsHandler` sends on submission.
- `Sender` service calls the TurboSMS REST API.
- Configurable channel (SMS / Viber transactional / promotional).
- Webhook endpoint receives status callbacks.

---

# Installing & configuring

- Require and enable with Webform (`drush en turbo_sms_notify`).
- Configure API token, sender name, channel, and phone field at `/admin/config/system/turbo-sms`.
- Optionally set a `webhook_secret` to authenticate incoming callbacks.
- Add the "TurboSMS" handler to a Webform and map the phone field.
- The API token is stored in `turbo_sms_notify.settings` config.

---

# Usage & behaviour

- On submit, the handler calls `Sender::send($phone, $text, $overrides)`.
- `Sender` POSTs JSON to `https://api.turbosms.ua/message/send.json` with a Bearer token.
- The outbound call uses the default Guzzle client (TLS verification not disabled).
- For Viber, image/caption/button overrides can be included.
- The webhook route `/turbosms/webhook` accepts POST only, `_access: TRUE`.
- `WebhookController::receive` verifies `X-TurboSMS-Signature` with `hash_equals` when a secret is set.
- If no `webhook_secret` is configured the signature check is skipped.
- The webhook only logs the payload; it performs no data mutation or fulfillment.
- Invalid signatures return 403; bad JSON returns 400.
- The settings form requires `administer site configuration`.
- Missing token/sender causes a logged warning and no send.
- A 15-second timeout applies to outbound sends.
- The phone field used is configurable per Webform.
- Uninstalling removes the handler, service, and routes.
- No secrets are logged (only the first 2000 bytes of the webhook body).
