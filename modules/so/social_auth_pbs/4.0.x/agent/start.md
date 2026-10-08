<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Auth PBS (social_auth_pbs) — agent index

**A Social Auth OAuth2 client for PBS Account login, with Apple/Facebook/Google/register sub-network variants.**

- **Version:** 4.0.x · package Social
- **Core:** ^9.5 || ^10 || ^11 · depends on `social_auth`
- **Configure:** `social_auth_pbs.settings_form` → `/admin/config/social-api/social-auth/pbs`
- **Routes:** `social_auth_pbs.redirect` (`user/login/pbs`), `social_auth_pbs.callback` (`user/login/pbs/callback`) — both `_access: 'TRUE'`, `no_cache`
- **Networks:** `social_auth_pbs` + `_apple`, `_facebook`, `_google`, `_register` (all use `PbsAuthManager`, League provider `openpublicmedia/oauth2-pbs`)
- **Controller:** `PbsAuthController` (shared across variants; sub-network carried in the Social Auth data handler via `network` query param)

**Security:** reviewed sound. Routes are open by design (anonymous login start / provider association) — the standard Social Auth pattern. OAuth `state`/CSRF validation and TLS token exchange are handled by the inherited `social_auth` base controller/manager, not re-implemented here. No mutating endpoints beyond the OAuth flow.

See [configure/login.md](configure/login.md)
