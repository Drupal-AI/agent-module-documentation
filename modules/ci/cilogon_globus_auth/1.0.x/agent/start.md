<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CILogon / Globus Auth (OSP) (cilogon_globus_auth) — agent index

Two ready-made **OpenID Connect client plugins** for the research-computing identity providers
**CILogon** (`ospclscigw`) and **Globus Auth** (`ospgascigw`), plus login-page and
account-provisioning conveniences, built on top of the contributed **`openid_connect`** module.
Package *User authentication*. Core `^10 || ^11`. License GPL-2.0-or-later. Version dir 1.0.x
(installed 1.0.0-beta5). Info `name` is "OpenID Connect One Science Place(OSP) Client".

- **Dependency:** `openid_connect:openid_connect` (composer `drupal/openid_connect:^3.0@alpha`).
  Optional runtime integration with **`key`** (client secret as a Key entity) and **`externalauth`**
  (authmap, pulled in by openid_connect). No `.permissions.yml`, no Drush.

## What it provides (from source)

- **Two OIDC client plugins** (plugin type `openid_connect_client`, defined by openid_connect):
  - `OSPCILogon` (`src/Plugin/OpenIDConnectClient/OSPCILogon.php`, id **`ospclscigw`**, "CILogon (OSP)").
  - `OSPGlobusAuth` (`src/Plugin/OpenIDConnectClient/OSPGlobusAuth.php`, id **`ospgascigw`**, "Globus Auth (OSP)").
  - Both extend `OpenIDConnectClientBase`; the OIDC flow (state token, ID-token validation, token
    exchange over the Drupal `http_client`, account mapping) is **inherited** from openid_connect.
    Details, endpoints/scopes, and the Globus-only authorize params → [plugins/clients.md](plugins/clients.md).
- **Admin settings form** `OSPAuthSettingsForm` at `/admin/config/people/cilogon-globus-auth`
  (route `cilogon_globus_auth.settings`, permission *administer site configuration*), writing the
  config object `cilogon_globus_auth.settings` → [config/settings.md](config/settings.md).
- **hook_install** (`.install`) seeds `openid_connect.settings.ospclscigw` and
  `openid_connect.settings.ospgascigw` (endpoints + default scopes, disabled, empty credentials).
  `hook_update_10101` seeds `session_required_policies`. See [config/settings.md](config/settings.md).
- **Login-page UX**: `hook_theme` override `form--user-login-form.html.twig`, JS toggle library
  `cilogon_globus_auth/login-toggle`, and `hook_form_openid_connect_login_form_alter` (per-client
  button text, help text, primary-button styling) → [login-ux/login-and-logout.md](login-ux/login-and-logout.md).
- **Connected Accounts**: `OSPOpenIDConnectAccountsForm` (extends openid_connect's form) at
  `/user/{user}/connected-accounts`, plus `hook_openid_connect_userinfo_save` storing the IdP
  display name in the authmap and auto-assigning configured roles to new SSO accounts.
- **Logout flow**: `RouteSubscriber` reroutes `user.logout` / `openid_connect.logout` to
  `OSPLogoutController::logout`; `LogoutConfirmSubscriber` handles stale logout clicks;
  `hook_openid_connect_redirect_logout_alter` rewrites the Globus web-logout round trip.
- **Services** (`.services.yml`): `cilogon_globus_auth.openid_connect.session` (`OSPOpenIDConnectSession`,
  extends openid_connect's session to stash Globus transfer tokens), `.route_subscriber`,
  `.logout_confirm_subscriber`.
- **Config schema**: `config/schema/cilogon_globus_auth.schema.yml` (one `config_object`).

## Solution docs

- [plugins/clients.md](plugins/clients.md) — the two client plugins, endpoints, scopes, secret
  handling, Globus session-restriction params, transfer-token session.
- [config/settings.md](config/settings.md) — the settings form, config object + schema keys,
  install-seeded OIDC client config, role auto-assignment, hide-register.
- [login-ux/login-and-logout.md](login-ux/login-and-logout.md) — login-form template/JS,
  button/help alters, Connected Accounts, logout controller + subscribers.
