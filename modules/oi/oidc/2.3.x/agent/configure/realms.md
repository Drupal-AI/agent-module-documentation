<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — realms (providers)

A *realm* is one identity provider. Configure realms with form
`Drupal\oidc\Form\RealmsConfigForm` at route **`oidc.admin.realms_config`**
(`/admin/config/people/oidc/realms`, tab "Realms"). The page shows the two redirect URLs the
provider must whitelist, then one collapsible section per realm with **Add generic realm** /
**Delete** (AJAX) buttons.

The bundled realm plugin is **`generic`** (`GenericOpenidConnectRealm`), a *derived* plugin: one
instance per id listed in `oidc.settings:generic_realms`, with full plugin id `generic:<derivative_id>`
(the derivative id is a `_`-normalized UUID generated on "Add generic realm"). Its config lives in a
plain config object **`oidc.realm.generic.<derivative_id>`** (schema `oidc.realm.generic.*`).

## Redirect URLs to register at the provider
- Login redirect: `oidc.openid_connect.login_redirect` → `/oidc/login-redirect`
- Logout redirect: `oidc.openid_connect.logout_redirect` → `/oidc/logout-redirect`

Per-realm the login entry point is `oidc.openid_connect.login` → `/oidc/login/generic:<id>`.

## Generic realm config keys (`oidc.realm.generic.<id>`)

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `name` | string | – | Human label for the realm. |
| `config_url` | uri | – | URL of the `.well-known/openid-configuration` document. Endpoints (`authorization_endpoint`, `token_endpoint`, `userinfo_endpoint`, `jwks_uri`, `issuer`, `end_session_endpoint`) are discovered from it and cached in the `oidc.config` key-value store. Changing it clears the cache + JWKS. |
| `client_id` | string | – | OAuth2 client id (also the expected ID-token `aud`). |
| `client_secret` | string | – | OAuth2 client secret; sent as HTTP Basic auth on the token endpoint. |
| `scopes` | sequence | `['profile']` | Requested scopes; `openid` is appended automatically. Entered space/comma separated. |
| `request_userinfo` | bool | `false` | If TRUE, after the token exchange the userinfo endpoint is called (Bearer access token) and its fields merged in as claims. |
| `id_claim` | string | `sub` | Claim used as the stable external authname (`oidc:<plugin_id>` / this value). |
| `username_claim` | string | `preferred_username` | Claim synced to the Drupal username. |
| `email_claim` | string | `email` | Claim synced to the Drupal e-mail (and used for existing-account linking). |
| `given_name_claim` | string | `given_name` | Claim synced to the `given_name` base field. |
| `family_name_claim` | string | `family_name` | Claim synced to the `family_name` base field. |
| `auth_only` | bool | `false` | If TRUE, authenticate + copy claims but then forget the OIDC session — no tokens stored, no provider-side logout, no refresh. |
| `display_name_format` | string | `[user:account-name]` | Token pattern for the user's display name (options: account-name, given-name, given+family, given+family-abbr, mail). |
| `default_rid` | string or null | `null` | Role id auto-assigned to newly registered users (only offered when >2 roles exist). |

## Add a realm via PHP (no UI)

```php
$uuid = \Drupal::service('uuid')->generate();
$id = str_replace('-', '_', $uuid);          // derivative id
$plugin_id = 'generic:' . $id;               // full plugin id

// 1. Register the derivative.
$settings = \Drupal::configFactory()->getEditable('oidc.settings');
$realms = $settings->get('generic_realms') ?: [];
$realms[] = $id;
$settings->set('generic_realms', $realms)->save();

// 2. Write the realm config.
\Drupal::configFactory()->getEditable('oidc.realm.generic.' . $id)
  ->set('name', 'Keycloak')
  ->set('config_url', 'https://idp.example.com/realms/main/.well-known/openid-configuration')
  ->set('client_id', 'drupal')
  ->set('client_secret', $secret)
  ->set('scopes', ['profile', 'email'])
  ->set('request_userinfo', FALSE)
  ->set('id_claim', 'sub')
  ->set('username_claim', 'preferred_username')
  ->set('email_claim', 'email')
  ->set('given_name_claim', 'given_name')
  ->set('family_name_claim', 'family_name')
  ->set('auth_only', FALSE)
  ->set('display_name_format', '[user:given-name] [user:family-name]')
  ->set('default_rid', NULL)
  ->save();

// 3. Rebuild derivatives so /oidc/login/generic:<id> exists.
\Drupal::service('plugin.manager.openid_connect_realm')->clearCachedDefinitions();
```

Login URL for the above: `/oidc/login/generic:<id>`.

## What happens at login (trace)
1. `/oidc/login/{realm}` → `OpenidConnectController::login` initializes the realm on the session,
   generates a random `state`, and 302s to the provider's `authorization_endpoint` with
   `response_type=code`, `scope`, `client_id`, `state`, `redirect_uri`.
2. The provider returns to `/oidc/login-redirect?code=...&state=...`. The `_oidc_openid_connect_redirect`
   access check requires the caller to be anonymous and the returned `state` to equal the session state.
3. `OpenidConnectController::loginRedirect` calls the token endpoint (Basic auth), receives
   `id_token`/`access_token`, validates the ID token, extracts claims (optionally userinfo), then via
   `externalauth`: loads the mapped account by `oidc:<plugin_id>` + id claim, else links an existing
   local account by e-mail (see api/services.md — `LinkExistingAccountEvent`), else registers a new one.
4. `externalauth.userLoginFinalize()` logs the user in; `UpdateUserSubscriber` syncs username/e-mail/names.

## Config-schema note
`config/schema/oidc.settings.schema.yml` defines `oidc.settings`; `config/schema/oidc.realm.generic.schema.yml`
defines `oidc.realm.generic.*`. The realm secret is stored in plain config (no Key entity), so it is
included in exported configuration.
