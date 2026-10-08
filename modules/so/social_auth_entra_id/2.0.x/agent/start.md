<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Microsoft Entra ID SSO Login (social_auth_entra_id) — agent index

Adds a "Log in with Microsoft" flow to Drupal: users authenticate against Microsoft
Entra ID (formerly Azure AD) over OAuth 2.0 Authorization Code, and are matched to a
Drupal account by the email claim (auto-registered when new). Self-contained — it does
NOT depend on the Social API / social_auth framework; only core `user`. Core `^9 || ^10 || ^11`.

Settings page: `/admin/config/services/entra-id/settings` (route `social_auth_entra_id.settings`).

- **Set client id / secret / tenant, account type, login behavior, domain allowlist, admin blocks** → [configure/settings.md](configure/settings.md)
- **The login + callback routes, controller flow, claim→user mapping** → [api/login-flow.md](api/login-flow.md)
- **The "Entra ID Login Block" (login button)** → [blocks/login_block.md](blocks/login_block.md)
- **The permission it declares** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object `social_auth_entra_id.settings`; keys: `client_id`, `client_secret`, `tenant_id`,
  `account_type` (`organization`|`common`|`consumers`, default `organization`),
  `login_behavior` (`register_and_login`|`login_only`, default `register_and_login`),
  `allowed_domains` (comma/newline list), `block_user_1` (bool, default TRUE),
  `block_admin_role` (bool, default TRUE).
- Routes: `social_auth_entra_id.settings` (form, `administer site configuration`);
  `social_auth_entra_id.redirect` at `/user/login/entra-id` (`_access: TRUE`, `no_cache: TRUE`) →
  `SocialAuthEntraIdController::redirectToMicrosoft`; `social_auth_entra_id.callback` at
  `/user/login/entra-id/callback` (`_access: TRUE`, `no_cache: TRUE`) →
  `SocialAuthEntraIdController::handleMicrosoftCallback`.
- Permission `administer social_auth_entra_id settings` is declared but the settings route is
  actually gated by core `administer site configuration`.
- Block plugin id `entra_id_login_block` (class `EntraIdLoginBlockBlock`, category "Login").
- Uses core `http_client` (Guzzle) for the token exchange and Graph `/me` call. No config schema
  for the block; block settings are `login_text` and `custom_class`.
- Font Awesome is pulled from a CDN via the `social_auth_entra_id/font-awesome` library.
- No Drush commands, no hooks of note, no plugin types defined, no `.install`.
