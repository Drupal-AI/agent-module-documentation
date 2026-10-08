<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# subscription_manager — routes & JSON API

All routes require login and `manage own subscriptions+administer subscriptions` (OR) unless noted.

| Route | Path | Notes |
|---|---|---|
| `subscription_manager.admin` | `/admin/config/services/subscription_manager` | perm `administer subscription manager` |
| `subscription_manager.my_subscriptions` | `/user/my-subscriptions` | redirects to configured manage route |
| `subscription_manager.manage_subscription` | `/user/{user}/manage-subscription` | ownership-checked; redirects to connector portal |
| `subscription_manager.subscribe` | `/subscription-manager/subscribe` | redirects to connector checkout |
| `subscription_manager.api_my_subscription` | `/subscription-manager/api/my-subscription` | GET → JSON subscription+plan |
| `subscription_manager.api_portal_url` | `/subscription-manager/api/portal-url` | GET → JSON `{portal_url, has_subscription}` |
| `subscription_manager.api_subscribe_url` | `/subscription-manager/api/subscribe-url` | GET → JSON `{subscribe_url}` |

## Access model
`manageSubscriptionAccess($account, $user)`:
- `administer subscriptions` → may manage any user who has a local subscription.
- else self-only: `(int)$user->id() === (int)$account->id()` AND `manage own subscriptions`.
- Controller `manageSubscription()` re-runs the same check and throws `NotFoundHttpException` on forbidden (defense-in-depth vs IDOR).

## PostPurchaseTokenService (`subscription_manager.post_purchase_token`)
- `createToken(string $order_id, ?int $ttl=3600)` → `"{exp}.{hmac_sha256(order_id|exp, secret)}"`.
- `verifyToken(?string $token, string $order_id)` → bool; checks format, `ctype_digit` expiry, not-expired, `hash_equals`.
- Secret = `privateKey->get() . SALT . Settings::getHashSalt()` — site-unique, never leaves the server.
