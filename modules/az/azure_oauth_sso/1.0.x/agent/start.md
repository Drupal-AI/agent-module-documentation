<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Azure OAuth Client SSO (azure_oauth_sso) — agent index

Microsoft **Entra ID (Azure AD)** login for Drupal. Implements the OAuth 2.0 authorization-code
flow **directly** against `login.microsoftonline.com` for a single Azure application (not through a
shared `openid_connect` client), then reads the profile from **Microsoft Graph** (`/v1.0/me`).
Version **1.0.9**. Core `^9 || ^10 || ^11`. Package `user`. No declared module dependencies (uses
core `field`/`file`/`user`).

## What it provides

- **Routes** (`azure_oauth_sso.routing.yml`):
  - `azure_oauth_sso.oauthLogin` — `/oauth/login` — `OauthLogin::oauthLogin`; the redirect-to-Azure
    and OAuth callback in one controller. `_permission: access content`, `no_cache: TRUE`.
  - `azure_oauth_sso.testOauthLogin` — `/oauth/test-login` — `OauthLogin::testOauthLogin`; the
    settings form's "Test Configuration" link. `_permission: access content`.
  - `azure_oauth_sso.customerSetup` — `/admin/config/people/azure_oauth_sso/basic-config` —
    `OauthConfigForm` (settings). `_permission: administer site configuration`.
  - `azure_oauth_sso.OauthFieldsMappingForm` — `/admin/config/people/azure_oauth_sso/fields-mapping`
    — `OauthFieldsMappingForm`. `administer site configuration`.
  - `azure_oauth_sso.OauthRolesMappingForm` — `/admin/config/people/azure_oauth_sso/roles-mapping`
    — `OauthRolesMappingForm`. `administer site configuration`.
- **Service**: `azure_oauth_sso.token_service` → `Service\OAuthTokenService` — `getToken()`,
  `refreshToken()`, `apiCall($url, $params, $method)`.
- **Trait**: `BaseOAuth` — config getters (`getClientId`, `getAdTenant`, `getClientSecret`,
  `getRedirectUri`) shared by the controller, service and settings form.
- **Config objects**: `azure_oauth_sso.settings` (schema in `config/schema`),
  `azure_oauth_sso.fields_mapping`, `azure_oauth_sso.roles_mapping` (created at runtime by their
  forms).
- **User fields** (installed in `config/install`): `field_access_token`, `field_refresh_token`
  on `user` — store the Graph tokens. Removed on uninstall (`azure_oauth_sso.install`).
- **Hooks** (`azure_oauth_sso.module`): `hook_form_alter` (login button), `hook_preprocess_page`
  (immediate redirect of `/user/login`), `hook_user_logout` / `hook_menu_links_discovered_alter`
  (optional Microsoft sign-out).
- **No** permissions file, Drush commands, or plugin types.

## Solution docs

- [`agent/config/settings.md`](config/settings.md) — the three config objects, the settings +
  field-mapping + role-mapping forms, routes, permissions, and where the client secret lives.
- [`agent/api/login-flow.md`](api/login-flow.md) — the redirect → Azure → callback sequence, how a
  Drupal user is matched/provisioned from Graph claims, roles/photo sync, and the token service.
