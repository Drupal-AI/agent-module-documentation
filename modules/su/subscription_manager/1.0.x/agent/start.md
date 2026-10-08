<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Subscription Manager (subscription_manager) — agent index

**Local Subscription/Plan entities linked to a remote billing provider via pluggable connector plugins.**

- **Version:** 1.0.x (1.0.0-beta2)
- **Core:** ^9 | ^10 || ^11
- **Configure:** `subscription_manager.admin` — `/admin/config/services/subscription_manager` (perm `administer subscription manager`)
- **Permissions:** `administer subscription manager`, `administer subscription plans`, `administer subscriptions` (all restrict-access), `manage own subscriptions`
- **Routes:** `/user/my-subscriptions`, `/user/{user}/manage-subscription`, `/subscription-manager/subscribe`, `/subscription-manager/api/{my-subscription,portal-url,subscribe-url}` (GET, JSON)
- **Plugin type:** `@SubscriptionManagerConnector` (manager `plugin.manager.subscription_manager.connector_manager`)
- **Services:** `subscription_manager`, `subscription_manager.post_purchase_token`
- **Drush:** yes (`SubscriptionManagerCommands`) · **Views fields:** remote status, will-renew

**Security:** Every route permission-gated and login-required; `manage-subscription` enforces per-user ownership in both `_custom_access` and the controller (IDOR-hardened, gg-ted1). `PostPurchaseTokenService` uses HMAC-SHA256 + `hash_equals`, secret = private key + salt + hash salt, expiring tokens (gg-6kwq). No anonymous mutating endpoints. No security findings.

See [api/api.md](api/api.md) and [plugins/connectors.md](plugins/connectors.md).
