<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OpenID Connect Client (oidc) — agent index

Makes Drupal an **OIDC relying party (client)**: users authenticate via the Authorization Code
flow against an external identity provider (Keycloak, Entra ID, Okta, Auth0, Google, ...). Depends
on **`externalauth`** (maps a remote id to a local account) and the **`sop/jwx`** PHP library
(validates the ID token; pulls `sop/crypto-types`, which needs PHP **ext-gmp**). Version **2.3.0**,
core `^10 || ^11`.

Each provider is a **realm** — a plugin of type `OpenidConnectRealm`. The bundled `generic` realm is
derived (one instance per entry in `oidc.settings:generic_realms`) and self-discovers endpoints from
the provider's `.well-known/openid-configuration`. Login/callback routes are per realm
(`/oidc/login/{realm}`, realm constrained to `^[a-z0-9_:-]+$`); all auth routes are `no_cache: true`.

Configure route: **`oidc.admin.settings`** (`/admin/config/people/oidc`), with a `Realms` tab at
`oidc.admin.realms_config` (`/admin/config/people/oidc/realms`). One permission, no drush, no
config entities (realm config is stored in plain config objects `oidc.realm.generic.*`).

- **Set the general options (replace /user/login, redirect 403s, disable register/pass routes)** → [configure/settings.md](configure/settings.md)
- **Add/configure a provider (client id/secret, scopes, claim mapping, endpoints)** → [configure/realms.md](configure/realms.md)
- **Write your own provider (hard-coded endpoints, custom realm plugin)** → [plugins/realms.md](plugins/realms.md)
- **Call the services / react to login (events, token accessors, hooks, user fields)** → [api/services.md](api/services.md)
- **The admin permission** → [permissions/permissions.md](permissions/permissions.md)

## Key facts
- Config objects: `oidc.settings` (general), `oidc.realm.generic.<derivative_id>` (per realm).
  Discovery + JWKS caches live in key-value stores `oidc.config` and `oidc.jwks.<plugin_id>`.
- `oidc.settings` keys: `generic_realms` (seq), `login_path` (path|null), `redirect_403` (bool),
  `disable_user_routes` (bool), `show_session_expired_message` (bool).
- Generic realm keys: `config_url`, `client_id`, `client_secret`, `scopes` (seq, `openid` auto-added),
  `request_userinfo` (bool), `id_claim` (def `sub`), `username_claim` (def `preferred_username`),
  `email_claim` (def `email`), `given_name_claim`, `family_name_claim`, `auth_only` (bool),
  `display_name_format`, `default_rid` (role id|null).
- Routes: `oidc.openid_connect.login` `/oidc/login/{realm}`, `.login_redirect` `/oidc/login-redirect`,
  `.logout` `/oidc/logout`, `.logout_redirect` `/oidc/logout-redirect`, `oidc.admin.settings`,
  `oidc.admin.realms_config`.
- Services: `oidc.openid_connect_session`, `oidc.json_http_client`, `oidc.existing_account_validator`,
  `plugin.manager.openid_connect_realm`, `logger.channel.oidc`. Access checks
  `_oidc_openid_connect_redirect`, `_oidc_openid_connect_logout`.
- Plugin type: `OpenidConnectRealm` — manager `plugin.manager.openid_connect_realm`, annotation
  `Drupal\oidc\OpenidConnectRealm\Annotation\OpenidConnectRealm`, dir `Plugin/OpenidConnectRealm`,
  interface `OpenidConnectRealmInterface` (+ `OpenidConnectRealmConfigurableInterface`).
- Permission: `administer oidc` (`restrict access: true`).
- External-auth provider key: `oidc:<plugin_id>` (e.g. `oidc:generic:ab12...`).
- Adds user base fields `given_name`, `family_name`, computed `display_name`; tokens
  `[user:given-name]`, `[user:family-name]`, `[user:family-name-abbr]`.
