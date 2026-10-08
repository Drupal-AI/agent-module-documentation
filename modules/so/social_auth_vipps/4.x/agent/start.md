<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Auth Vipps (social_auth_vipps) — agent index

**Vipps OAuth2 login/registration provider for the Social Auth framework (Authorization Code grant against api.vipps.no).**

- **Version:** 4.x
- **Core:** ^9.5 || ^10 || ^11 — depends on social_auth:social_auth.
- **Routes:** `user/login/vipps` (`redirectToProvider`, `_access: 'TRUE'`), `/user/login/vipps/callback` (`callback`, `_access: 'TRUE'`), settings `admin/config/social-api/social-auth/vipps` (permission `administer social api authentication`).
- **Key classes:** `Controller/VippsAuthController` (extends `OAuth2ControllerBase`), `VippsAuthManager`, `Plugin/Network/VippsAuth`, `Provider/Vipps` + `VippsResourceOwner`, `EventSubscriber/CallbackEventSubscriber`.

**Security:** The callback is `_access: 'TRUE'` **but the OAuth2 `state` IS verified** — `VippsAuthController::processCallback()` calls `parent::processCallback()` (Social Auth base validates `oauth2state`), so login CSRF is covered. The module further hardens this: `redirectToProvider()` records the state in Drupal state with a timestamp and `processCallback()` re-checks it within a ~2-min window, then flushes it (single-use). Token exchange uses the League Vipps provider over `https://api.vipps.no` (no `verify=>false` seen). No refresh-token-in-URL. Sound OAuth-client posture.

See [configure/setup.md](configure/setup.md).