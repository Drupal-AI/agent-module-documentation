<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup, configuration & the OAuth flow

## Install / enable

`drush en eloqua_api_redux -y`. No Drupal module dependencies. Needs an Oracle Eloqua subscription and
a registered Eloqua OAuth application (Client ID + Client Secret). Config link: *Configuration → Web
services → Eloqua API settings* (`admin/config/services/eloqua_api_redux`, menu link in
`eloqua_api_redux.links.menu.yml`).

## Config object `eloqua_api_redux.settings`

Install defaults (`config/install/eloqua_api_redux.settings.yml`):

- `client_id: ''`
- `client_secret: ''`
- `api_uri: 'https://login.eloqua.com/auth/oauth2/'`

The main module ships **no config schema** (`config/schema/` does not exist). Only `client_id` and
`client_secret` are editable through the settings form; `api_uri` is set by the install default.

## Settings form — `Form\Settings` (route `eloqua_api_redux.settings`)

`ConfigFormBase` subclass (form id `eloqua_api_redux_settings`), injected with `date.formatter` and
`eloqua_api_redux.client`.

- `buildForm()` renders a **Client ID** and **Client Secret** textfield. Once both are set, it shows a
  *Access and Refresh Tokens* details group with the human-readable expiry of each stored token (read
  via `EloquaApiClient::getEloquaToken()`), and a link to (re)authenticate.
- If no refresh token is stored yet, it adds an error message with a "log into Eloqua" link built by
  the private `accessUrl()`.
- `accessUrl()` builds the Eloqua authorize URL: `{api_uri}authorize?response_type=code&client_id=…&redirect_uri=…`,
  where `redirect_uri` = the absolute URL of `internal:/eloqua_api_redux/callback`.
- `submitForm()` saves `client_id` and `client_secret` into `eloqua_api_redux.settings`.

## OAuth authorization-code flow

1. Admin sets Client ID / Secret and clicks the login link → browser goes to Eloqua's authorize
   endpoint with `response_type=code` and the callback `redirect_uri`.
2. Eloqua redirects back to `eloqua_api_redux/callback?code=…`.
3. `Controller\Callback::callbackUrl(Request)` reads `code` and calls
   `EloquaApiClient::getAccessTokenByAuthCode($code)`, then redirects to the settings page with a
   success/error message.

## Routes & permission

Both routes (`eloqua_api_redux.routing.yml`) require permission **`administer eloqua api settings`**
(`eloqua_api_redux.permissions.yml`, `restrict access: TRUE`):

- `eloqua_api_redux.settings` → `_form: Form\Settings`, path `admin/config/services/eloqua_api_redux`.
- `eloqua_api_redux.callback` → `_controller: Callback::callbackUrl`, path `eloqua_api_redux/callback`,
  methods `[GET]`.

## Token & base-URL handling (`Service\EloquaApiClient`)

Tokens are **not** stored in config — they live in Drupal **State** (survives the `post_update`
migration `eloqua_api_redux_post_update_move_tokens`, which moved them out of the deprecated
`eloqua_api_redux.tokens` config object). Keys via `getStateKey()`: `eloqua_api_redux.access_token`,
`eloqua_api_redux.refresh_token`, `eloqua_api_redux.api_base_uri`. Each value is `{value, expire}`.

- `doTokenRequest($params, $res='token')` — POSTs to `{api_uri}` + `$res` with HTTP Basic auth
  (`client_id`/`client_secret`) and `form_params`; on 200 stores `access_token` + `refresh_token` in
  State and calls `doBaseUrlRequest()`.
- `getAccessTokenByAuthCode($code)` — returns a cached valid access token, else exchanges the auth
  `code` (`grant_type=authorization_code`).
- `getAccessTokenByRefreshToken()` — returns a cached valid access token; else if a valid refresh
  token exists, refreshes (`grant_type=refresh_token`); else calls the injected
  `EloquaAuthFallbackInterface` service (`generateTokensByResourceOwner()`, a no-op unless the
  `eloqua_api_auth_fallback` submodule decorates it), and otherwise logs an error pointing to the
  settings page.
- `eloquaApiCacheAge()` — access token / base URL cached 8h (28800s), refresh token 1y, minus a 1h
  offset so refresh happens early. `getValidEloquaToken()` returns the stored value only while
  `expire > now`.
- `doBaseUrlRequest()` / `getBaseUrl()` — GET `https://login.eloqua.com/id` with a bearer token to
  discover the account's data-center base URL, cached in State. Eloqua requires resolving the base URL
  before other API calls.

## Uninstall / config export note

`client_id`, `client_secret`, and `api_uri` are stored in the `eloqua_api_redux.settings` config
object (exported by `drush config:export`). Tokens are in State and are **not** part of a config
export.
