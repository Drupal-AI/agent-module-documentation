<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vipps MobilePay Login (vipps_mobilepay_login) — agent index

**Social Auth network plugin for "Log in with Vipps MobilePay" over OpenID Connect / OAuth2.**

- **Version:** 1.0.x (1.0.0-alpha2) — core `^10.3 || ^11`; depends on `social_auth`, `vipps_mobilepay`.
- **Network plugin:** id `vipps_mobilepay_login` (short name `vipps`), provider class `\League\OAuth2\Client\Provider\Vipps`, manager `VippsAuthManager` extends Social Auth `OAuth2Manager`.
- **Routes:** delegated to Social Auth (`social_auth.network.redirect` / `.callback`); settings at `/admin/config/social-api/social-auth/vipps` (permission `administer social api authentication`).
- **Scopes:** `openid address email name phoneNumber` (+ extra configured). Credentials come from a selected `vipps_mobilepay` Connection profile (client id/secret, merchant serial, subscription key).
- **Security review:** OAuth `state`/CSRF is generated (`getState()`) and verified by **Social Auth core**; the token exchange runs through the League OAuth2 client over the provider's HTTPS endpoints (Guzzle default TLS verify ON) — no bespoke callback here. No `verify=>false`, no refresh_token placed in a URL, no client secret hardcoded (stored in the connection entity). Admin settings gated. See [configure/social-auth.md](configure/social-auth.md).
