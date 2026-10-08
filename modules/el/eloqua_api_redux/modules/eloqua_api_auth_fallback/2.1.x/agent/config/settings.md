<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auth fallback — setup, config, service & Drush command

## Install / enable

`drush en eloqua_api_auth_fallback -y`. Requires `eloqua_api_redux` (declared in its `info.yml`).
Configure the parent module's Client ID/Secret first; then set the fallback credentials here.

## Config object `eloqua_api_auth_fallback.settings`

Install defaults (`config/install/…settings.yml`): `sitename: ''`, `username: ''`, `password: ''`.
Schema (`config/schema/eloqua_api_auth_fallback.schema.yml`), a `config_object` with three `string`
mappings: `sitename` (Site/Company Name), `username`, `password`.

## Settings form — `Form\Settings` (route `eloqua_api_auth_fallback.settings`)

`ConfigFormBase`, form id `eloqua_api_auth_fallback_settings`. Path
`admin/config/services/eloqua_api_redux/auth_settings`, permission `administer eloqua api settings`
(from the parent). Three required textfields — **Instance/Site Name** (the company name used to log
in to Eloqua), **Username**, **Password** — saved to the config object by `submitForm()`.

## The decorated service + Drush command — `Commands\EloquaAuthTokensGenerate`

One class serves two roles:

- **Service decorator** (`eloqua_api_auth_fallback.services.yml`): decorates
  `eloqua_api_redux.auth_fallback_default` (priority -10, non-public), constructor args
  `config.factory`, `logger.factory`, `eloqua_api_redux.client`. So `EloquaApiClient`'s injected
  `EloquaAuthFallbackInterface` is now this class instead of the no-op default.
- **Drush command** (`drush.services.yml`): same class tagged `drush.command`, command
  `eloqua_api_auth_fallback:generate-tokens` / alias `eloqua-gt`.

### `generateTokensByResourceOwner()`

1. Reads `sitename`, `username`, `password` from `eloqua_api_auth_fallback.settings`; if any is empty,
   logs/prints "Eloqua authentication credentials are not set." and returns FALSE.
2. Builds the grant params:
   `grant_type=password`, `scope=full`, `username = "{sitename}\\{username}"`, `password = {password}`.
3. Calls `EloquaApiClient::doTokenRequest($params)` (POST to the parent's token endpoint with Basic
   auth from `client_id`/`client_secret`). On a response containing a `refresh_token`, logs success and
   returns TRUE; the parent client has by then stored the new access + refresh tokens in State.

## How it fits the token flow

When `EloquaApiClient::getAccessTokenByRefreshToken()` finds no valid access token **and** no valid
refresh token, it calls this decorator's `generateTokensByResourceOwner()`. If that succeeds, a fresh
access token is available immediately — no browser round-trip. Run `drush eloqua-gt` manually or from
cron to force the same refresh (e.g. before an unattended sync).
