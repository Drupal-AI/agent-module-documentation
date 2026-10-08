<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Zalo Zns (zalo_zns) — agent index

**Sends templated Zalo Notification Service messages; handles the Zalo OA OAuth callback and delivery webhook.**

- **Version:** 1.0.x
- **Core:** ^10
- **Depends:** rest
- **Configure:** `/admin/config/system/zalo-zns-settings` (`administer zalo_zns configuration`)
- **Permission:** `administer zalo_zns configuration`

**Routes (all admin, perm-gated):** token request `/zalo-zns/zalo-access-token-request`, test send `/zalo-zns/zalo-zns-test`, settings. **REST resources:** `zalo_zns_zalo_oa_callback` (GET `/api/zalo-zns-zalo-oa-callback`), `zalo_zns_zalo_notification_webhook` (POST `/api/zalo-zns-zalo-notification-webhook`). **Service:** `zalo_zns.helper` (token lifecycle + `sendZnsNotification` to `business.openapi.zalo.me` over HTTPS; cron refresh). PKCE via `openssl_random_pseudo_bytes`.

**Security:** admin UI permission-gated. Delivery webhook verifies an HMAC-SHA256 signature (`app_id+json+timestamp+oa_secret_key`) vs `X-Zevent-Signature` before updating a Message — but uses loose non-constant-time `==` (not `hash_equals`). App secret / OA secret key stored in plain config. REST resources must be explicitly enabled + permissioned.

See [api/webhook.md](api/webhook.md).
