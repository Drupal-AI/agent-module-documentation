<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Zalo Zns integrates Vietnam's Zalo Notification Service so a site can send templated ZNS messages to users' phone numbers and track delivery.

---

A `Helper` service manages the OAuth token lifecycle: it exchanges/refreshes the Zalo Official Account access token (stored in an expirable key-value store, refreshed on cron) using the app id/secret, and `sendZnsNotification()` POSTs a template id, phone number and template data to `https://business.openapi.zalo.me/message/template` over HTTPS. PKCE code verifier/challenge generation uses `openssl_random_pseudo_bytes`. Admin forms request an access token (`/zalo-zns/zalo-access-token-request`), send a test notification (`/zalo-zns/zalo-zns-test`) and configure app id/secret and OA secret key (`/admin/config/system/zalo-zns-settings`), all gated by `administer zalo_zns configuration`. Two REST resources handle the OAuth redirect callback and the delivery webhook.

Setup: create a Zalo app, store the app id/secret and OA secret key on the settings form, complete the OAuth token request, then send via the ZNS notifier plugin or `Helper::sendZnsNotification()`. Security notes observed while documenting: the delivery webhook (`ZaloNotificationWebhookResource::post`) DOES verify an HMAC-SHA256 signature (`sha256(app_id + json + timestamp + oa_secret_key)`) against the `X-Zevent-Signature` header before marking a Message entity delivered — good — but compares with a loose, non-constant-time `==` rather than `hash_equals()`; the app secret and OA secret key are stored in plain config. The callback/webhook are Drupal REST resources, so they must be explicitly enabled and permissioned.

---
- Send a templated ZNS notification to a phone number.
- Send an OTP or transactional message via a Zalo ZNS template.
- Configure the Zalo app id, secret and OA secret key.
- Request an OAuth access token at `/zalo-zns/zalo-access-token-request`.
- Send a test notification from `/zalo-zns/zalo-zns-test`.
- Refresh the access token automatically on cron.
- Store access/refresh tokens in expirable key-value storage.
- Use the ZNS notifier plugin from other modules.
- Track delivery via the signed webhook updating a Message entity.
- Verify inbound webhook authenticity with the OA secret key.
- Handle the Zalo OA OAuth redirect callback.
- Generate PKCE verifier/challenge for the OAuth flow.
- Send notifications in development mode for testing.
- Attach a tracking id to correlate a message with delivery status.
- Override the access token per call for testing.
- Localise/parameterise messages through Zalo template data.
- Restrict all Zalo config to the `administer zalo_zns configuration` permission.
- Log token refresh and send activity to the `zalo_zns` channel.
