<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SAML Drupal Login — agent index

Submodule of **saml_sp** that logs Drupal users in from a validated SAML response. Login starts at
`/saml/drupal_login/{idp}`; config UI at `/admin/config/people/saml_sp/login`
(route `saml_sp_drupal_login.config`, permission `configure saml sp`). Depends on `saml_sp`.

- **Login flow, all `saml_sp_drupal_login.config` keys, routes, account handling** →
  [configure/login.md](configure/login.md)
- **`hook_saml_sp_drupal_login_user_attributes()` — sync IdP attributes onto the user** →
  [hooks/user-attributes.md](hooks/user-attributes.md)

Key facts:
- Registers callback `saml_sp_drupal_login__saml_authenticate($is_valid, Response $response, Idp $idp)`;
  matches a user via `saml_sp_drupal_login_get_user()` and calls `user_login_finalize()`.
- Routes: `saml_sp_drupal_login.login` (`/saml/drupal_login/{idp}`),
  `saml_sp_drupal_login.config` (`/admin/config/people/saml_sp/login`),
  `saml_sp_drupal_login.register` (`/user/saml_sp_drupal_login_register`).
- Config `saml_sp_drupal_login.config` keys: `idp` (enabled IdPs), `logout`, `logged_in_redirect`
  (default `<front>`), `update_email`, `update_language`, `force_authentication`, `force_saml_only`,
  `account_request_request_account`, `account_request_create_account`,
  `no_account_authenticated_user_role`, `no_account_authenticated_user_account`.
- No permissions/plugins/Drush of its own.
