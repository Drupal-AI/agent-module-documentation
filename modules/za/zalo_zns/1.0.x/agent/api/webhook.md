<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Zalo Zns — callback, webhook & sending

## Sending (Helper)
`zalo_zns.helper` (`Drupal\zalo_zns\Helper`):
- `getAccessToken()` — returns the cached OA access token, else refreshes it from the stored
  refresh token via the Zalo SDK and re-stores both (access + refresh) in expirable key-value.
  Also called by `hook_cron` to keep the token warm.
- `sendZnsNotification($devMode, $phone, $templateId, $templateData, $trackingId=NULL, $overrideAccessToken=NULL)`
  POSTs JSON to `https://business.openapi.zalo.me/message/template` (HTTPS) with the token in the
  `access_token` header. `$devMode` adds `mode=development`.
- PKCE (`PKCEUtil`) uses `openssl_random_pseudo_bytes(32)` — a CSPRNG.

## OAuth callback — `ZaloOaCallbackResource` (GET `/api/zalo-zns-zalo-oa-callback`)
Exchanges the stored `code_verifier` for a Zalo token via the SDK and stores it. Returns `Ok`/`Failed`.

## Delivery webhook — `ZaloNotificationWebhookResource` (POST `/api/zalo-zns-zalo-notification-webhook`)
```
$verifySignature = 'mac=' . hash('sha256', $appId . json_encode($data) . $data['timestamp'] . $oaSecretKey);
if ($verifySignature == $signature) { ... mark Message field_status = success ... }
```
- Signature IS verified against `X-Zevent-Signature` (only acts when `X-Zevent-Server == 'ZNS'`).
- **Weakness:** loose, non-constant-time `==` comparison instead of `hash_equals()`; a mismatch is
  only logged. On success it loads `Message::load($data['message']['tracking_id'])` and sets it to
  `success` — the effect is limited to flipping a delivery-status field.

## Config / secrets
App id, `app_secret`, and `oa_secret_key` live in `zalo_zns.settings` (plain config storage).
Both REST resources require the `rest` module and must be enabled/permissioned to be reachable.
