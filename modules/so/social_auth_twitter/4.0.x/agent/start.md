<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Auth Twitter (social_auth_twitter) — agent index

**Adds Twitter/X OAuth2 (authorization-code + PKCE) social login to Drupal via the Social Auth / Social API framework.**

- **Version:** 4.0.x
- **Core:** `^10 || ^11`
- **Dependency:** `social_auth:social_auth`
- **Configure:** `social_auth_twitter.settings_form` → `/admin/config/social-api/social-auth/twitter`

Key surfaces:
- `@Network` plugin `TwitterAuth` (id `social_auth_twitter`, short_name `twitter`) wiring the Smolblog Twitter OAuth2 client.
- Service `social_auth_twitter.manager` (`TwitterAuthManager`) — authorization URL, PKCE, token exchange, resource-owner → `SocialAuthUser`.
- Settings form `TwitterAuthSettingsForm` (client_id, client_secret, scopes, endpoints).
- Login/redirect/callback routes are inherited from social_auth.
- Permission reused: `administer social api authentication`.

See [configure/social_auth_twitter.md](configure/social_auth_twitter.md) for credential setup, callback URL, scopes, and the OAuth flow.

**Security:** No findings. Token exchange runs through the League/Smolblog provider with default (verified) TLS — no `verify => false`. State/CSRF and the callback route are owned by the base social_auth controller; PKCE `code_verifier` is stored in-session and re-checked at exchange. No refresh token in any redirect URL; no hardcoded secrets (only the public `https://api.twitter.com` domain is hardcoded).
