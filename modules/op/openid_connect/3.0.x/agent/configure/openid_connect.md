# Configure clients & settings

## Clients (config entities)

A provider is an `openid_connect_client` config entity (`openid_connect.client.{id}`). Manage at
`/admin/config/people/openid-connect`. Routes (all gated by `administer openid connect clients`):

| Route | Path | Purpose |
|---|---|---|
| `entity.openid_connect_client.list` | `/admin/config/people/openid-connect` | List clients (**`configure`** route) |
| `entity.openid_connect_client.add_form` | `/…/add/{plugin_id}` | Add a client for a given plugin |
| `entity.openid_connect_client.edit_form` | `/…/{client}/edit` | Edit |
| `entity.openid_connect_client.delete_form` | `/…/{client}/delete` | Delete |
| `entity.openid_connect_client.enable` / `.disable` | `/…/{client}/enable`\|`/disable` | Toggle (CSRF) |
| `openid_connect.admin_settings` | `/…/settings` | Global settings form |

Each entity stores `id`, `label`, `plugin` (the client plugin id), and `settings` (validated by
`openid_connect.client.plugin.{plugin}` schema). Common plugin settings: `client_id`,
`client_secret`, `iss_allowed_domains`, `prompt` (`none`/`login`/`consent`/`select_account`).
The **generic** plugin adds `issuer_url` (enables `.well-known` auto-discovery), plus
`authorization_endpoint`, `token_endpoint`, `userinfo_endpoint`, `end_session_endpoint`, `scopes`.
Okta adds `okta_domain` + `scopes`; Facebook adds `api_version`.

The OAuth callback lands at `/openid-connect/{openid_connect_client}` (route
`openid_connect.redirect_controller_redirect`) — register this (absolute) URL as the redirect URI
with the provider.

## Global settings — `openid_connect.settings`

Config object edited at `openid_connect.admin_settings` or via `drush cset openid_connect.settings <key>`.
Install defaults:

| Key | Default | Meaning |
|---|---|---|
| `always_save_userinfo` | `true` | Re-map & save userinfo to the account on every login (else only on create) |
| `connect_existing_users` | `false` | Auto-connect a provider identity to an existing local account (by email) |
| `override_registration_settings` | `false` | Allow account creation even when site registration is admin-only |
| `end_session_enabled` | `true` | Propagate logout to the IdP (single logout / end session) |
| `user_login_display` | `'hidden'` | Show external providers on the core login form (`hidden`/`above`/`below`/`replace`) |
| `redirect_login` | `'user'` | Path to redirect to after login |
| `redirect_logout` | `''` | Path to redirect to after logout |
| `userinfo_mappings` | `{timezone: zoneinfo}` | Map of Drupal user property → OIDC claim |
| `role_mappings` | `{}` | Map Drupal roles from provider data |
| `autostart_login` | `false` | Immediately start the login redirect (single-provider SSO) |

Settings and client entities are config, so they export/deploy with `drush config:export`.
Schema: `config/schema/openid_connect.schema.yml`.
