<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Auth SSO (google_auth_sso) — agent index

**Adds IP-restricted Google login + Google Workspace directory -> Drupal role sync on top of Social Auth Google.**

- **Version:** 1.0.x  | **Core:** ^9.3 || ^10  | **Package:** Social
- **Depends:** social_auth_google (which itself pulls social_auth / social_api and league OAuth2 Google).
- **Adds:** `RouteSubscriber` overrides `social_auth_google.settings_form` and sets `_custom_access` (IP allowlist) on `social_auth_google.redirect_to_google`; `GoogleAuthSsoAccessCheck` (IP allowlist); `SyncGoogleRoles` event subscriber; extra `restricted_ips` setting on `social_auth_google.settings`.
- **No routing.yml of its own; no callback of its own.**

**Security review — see report.** Key point: this module does **not** implement the OAuth callback; state generation, id_token/access-token validation, TLS on the token exchange, and email-based account matching all live in the `social_auth_google`/`social_auth` dependency, not here. What this module adds: (1) an optional client-IP allowlist (via spoofable `getClientIp()`), and (2) `SyncGoogleRoles::onUserLogin()` which **strips all of a user's existing roles** and re-adds only roles named in Google Workspace `customSchemas.Drupal.Roles` on every login — so the Workspace admin fully controls Drupal roles (including potentially `administrator`) and a user with no Google roles is stripped of all roles. By design, but high blast-radius; document clearly.
