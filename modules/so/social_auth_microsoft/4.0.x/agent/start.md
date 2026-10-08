<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Auth Microsoft (social_auth_microsoft) — agent index

Adds "Log in with Microsoft" to a Drupal site as a provider for the **Social Auth** framework.
It is a thin plugin: it registers one `@Network` plugin (`social_auth_microsoft`, short name
`microsoft`) plus an auth manager, and reuses Social Auth's shared redirect/callback controller,
settings form and login block. OAuth2 is done with the `stevenmaguire/oauth2-microsoft` library
against the consumer **Microsoft Account / Live Connect** endpoints (`login.live.com`,
`apis.live.net/v5.0/me`) — personal Microsoft accounts, not Azure AD tenants (use
`social_auth_entra_id` for organizational/tenant sign-in).

Depends on `social_auth:social_auth` (which pulls in `social_api`). Library
`stevenmaguire/oauth2-microsoft ^2.0`, `drupal/social_auth ^4.1`. PHP >= 8.1. Core `^9.5 || ^10 || ^11`.

Settings page: `/admin/config/social-api/social-auth/microsoft` (Social Auth's generic form route
`social_auth.network.settings_form`, param `network=microsoft`; surfaced as the "Microsoft" tab by
`social_auth_microsoft.links.task.yml`). Note: `info.yml`'s `configure:` key names
`social_auth_microsoft.settings_form`, but no route by that name is defined — the working page is the
generic route above.

This module defines **no permissions of its own, no drush commands, and no plugin types**. It ships
a config schema.

- **Configure client ID/secret, scopes, extra endpoints** → [configure/settings.md](configure/settings.md)
- **Understand the login flow, network plugin, auth manager, account creation/linking** → [api/authentication.md](api/authentication.md)

## Key facts
- Network plugin: `Drupal\social_auth_microsoft\Plugin\Network\MicrosoftAuth` — id `social_auth_microsoft`, `short_name = "microsoft"`, `class_name = \Stevenmaguire\OAuth2\Client\Provider\Microsoft`, `auth_manager = \Drupal\social_auth_microsoft\MicrosoftAuthManager`.
- Service: `social_auth_microsoft.manager` → `Drupal\social_auth_microsoft\MicrosoftAuthManager` (extends `Drupal\social_auth\AuthManager\OAuth2Manager`).
- Config object: `social_auth_microsoft.settings` — keys `client_id`, `client_secret`, `scopes`, `endpoints` (schema `social_auth_microsoft.schema.yml`, type `config_object`).
- Routes (all from base `social_auth`, with `network=microsoft`):
  - redirect `social_auth.network.redirect` → `/user/login/microsoft`
  - callback `social_auth.network.callback` → `/user/login/microsoft/callback`
  - settings `social_auth.network.settings_form` → `/admin/config/social-api/social-auth/microsoft`
- Default OAuth scopes: `wl.basic`, `wl.emails` (Live Connect); extra scopes from config are appended.
- Admin permission for the settings page: `administer social api authentication` (defined by `social_api`).
- Login block: "Social Auth Login" block (`social_auth_login`, from base `social_auth`) renders the Microsoft logo (`img/microsoft_logo.svg`); or link to `/user/login/microsoft` directly.
