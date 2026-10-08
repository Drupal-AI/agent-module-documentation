<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, credentials & configuration

## Install & enable

```bash
composer require drupal/hubspot_api   # pulls hubspot/api-client:^10
drush en hubspot_api -y
```

Requires PHP 8.1+ and Drupal `^10.4 || ^11`. No Drupal module dependencies. Enabling the optional
contrib **markdown** module makes `hook_help()` render `README.md` as HTML on the module help page;
without it the README is shown escaped in a `<pre>` (`hubspot_api.module`, `hubspot_api_help()`).

## Settings form

`Drupal\hubspot_api\Form\SettingsForm` (form id `hubspot_api_settings`, extends `ConfigFormBase`)
at route **`hubspot_api.settings`** → **`/admin/config/services/hubspot-api`** (menu link
`hubspot_api.settings` under *Configuration → Web services*, `_admin_route: TRUE`). Route permission:
core **`administer site configuration`**. This is also the module's `configure` route.

Fields on the form:

| Field | Stored in | Purpose |
|---|---|---|
| **Private App Access token** | config `hubspot_api.settings:access_key` | Server-to-server token; simplest path. |
| **Client ID** | config `hubspot_api.settings:client_id` | OAuth app id. |
| **Client secret** | config `hubspot_api.settings:client_secret` | OAuth app secret. |
| **OAuth Connection Status** | (display only) | Green *Connected* / red *Disconnected* from `oauthIsConnected()`. |
| **Access token / Refresh Token** | State `hubspot_api_tokens` | Read-only; shown only once OAuth tokens exist. |
| **Authorize** | — | Starts the OAuth handshake (`oauthAuthorizeSubmit()`). |
| **Disconnect** | — | `oauthDisconnectSubmit()` deletes the config object **and** the state tokens. |

`submitForm()` saves `access_key` / `client_id` / `client_secret` to config and mirrors the
`access_token` / `refresh_token` form values into State (`hubspot_api_tokens`).
`oauthIsConnected()` returns true only when access_token, refresh_token, client_id and client_secret
are all present.

## Config object & schema

Config object **`hubspot_api.settings`** — install defaults (`config/install/hubspot_api.settings.yml`)
are all empty strings; schema (`config/schema/hubspot_api.schema.yml`, `type: config_object`):

```yaml
hubspot_api.settings:
  access_key:    string   # Private App Access token
  client_id:     string   # OAuth Client ID
  client_secret: string   # OAuth Client secret
```

OAuth access/refresh tokens are **not** in config — they live in **State** under key
`hubspot_api_tokens` (`HubSpotEnum::OAUTH_TOKEN_STATE_KEY`), as
`['access_token', 'refresh_token', 'expire_date']` (`expire_date` = `getExpiresIn() + time()`).

## OAuth handshake (from source)

1. Admin enters Client ID + secret, clicks **Authorize**. `SettingsForm::oauthAuthorizeSubmit()`
   builds the HubSpot authorize URL with `HubSpot\Utils\OAuth2::getAuthUrl($clientId, $redirectUri,
   ['content','oauth'])` where `$redirectUri` = absolute URL of route `hubspot_api.oauth_redirect`,
   and returns a `TrustedRedirectResponse` to HubSpot.
2. HubSpot redirects back to route **`hubspot_api.oauth_redirect`** →
   `/hubspot_api/oauth-redirect` (permission `administer site configuration`, `_admin_route: TRUE`),
   handled by `Drupal\hubspot_api\Controller\OAuth::oauthRedirect()` → `processRequest()`:
   reads `?error=access_denied` (shows error), else reads `?code=…`, calls
   `OAuthService::getTokensByCode($code)`, then `saveTokens()`.
3. `Services\OAuth::getTokensByCode()` exchanges the code via
   `Factory::create()->auth()->oAuth()->tokensApi()->create('authorization_code', $code,
   $redirectUri, $clientId, $clientSecret)`; `saveTokens()` writes access/refresh/expire to State.

## Quick verification

```bash
drush ev '$m=\Drupal::service("hubspot_api.manager"); var_dump((bool)$m->getHandler());'
```
Returns `true` once either a Private App token or OAuth tokens are configured.
