<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Auth Vipps — setup

## Prerequisites
- Enable `social_auth` (and Social API). Then enable `social_auth_vipps`.
- A Vipps Login / merchant application with client id, client secret, and the redirect URI set to `https://<site>/user/login/vipps/callback`.

## Configure
Go to `/admin/config/social-api/social-auth/vipps` (permission `administer social api authentication`) and enter the client id/secret (config `social_auth_vipps.settings`). Requested scopes default to `openid, address, email, name, phoneNumber`; extra scopes can be appended.

## Flow
1. `user/login/vipps` → `VippsAuthController::redirectToProvider()` builds the Vipps authorization URL and stores the OAuth2 `state` in the session **and** in Drupal state (timestamped).
2. User authenticates at Vipps; Vipps returns to `/user/login/vipps/callback`.
3. `callback()` → `processCallback()` validates `state` (base + hardened re-check), exchanges the code for a token via `VippsAuthManager`, fetches the `VippsResourceOwner`, enforces `verificationGuard()`, then calls Social Auth's `UserAuthenticator` to log in / register / associate.
4. On a Vipps `error` param, `CallbackEventSubscriber` redirects to `user.login` with the error message.

## Notes
- Place the Social Auth login block (or a link to `user/login/vipps`) to expose the button.
- Authenticated users hitting `user/login/vipps` associate a Vipps identity with their account.
