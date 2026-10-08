<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & OAuth setup

## Install / enable

`drush en aweber_block`. No dependencies beyond core. You need an AWeber account plus an AWeber developer app (https://labs.aweber.com) that supplies a Client ID and Client Secret.

## Config object: `aweber_block.aweberblockconfig`

Single editable config object. No config schema is shipped (`config/schema/` does not exist), so keys are untyped. Default install values (`config/install/aweber_block.aweberblockconfig.yml`) seed `base_url: https://api.aweber.com/1.0` and `auth_request_url: https://auth.aweber.com/oauth2/authorize`; other keys are empty.

Keys written by `Form\AweberBlockConfigForm::submitForm()` and by the auth service:

| Key | Set by | Purpose |
|-----|--------|---------|
| `base_url` | settings form | AWeber REST base, e.g. `https://api.aweber.com/1.0`. |
| `client_id` | settings form | OAuth2 client id from the AWeber app. |
| `client_secret` | settings form | OAuth2 client secret. |
| `redirect_uri` | settings form | Must be `<site>/aweber_block/getCode`; defaults to `getSchemeAndHttpHost() . '/aweber_block/getCode'`. |
| `auth_request_url` | settings form | OAuth2 authorize endpoint, e.g. `https://auth.aweber.com/oauth2/authorize`. |
| `auth_token` | settings form + callback | Current access token (`access_token`). |
| `refresh_token` | `AweberAuthentication::saveAccessToken()` | Refresh token. |
| `expires_in` | `saveAccessToken()` | Absolute expiry = token `expires_in` + current time. |
| `scopes` | settings form | Checkbox array of selected `AweberScopes::SCOPES` keys. |
| `aweber_account_id` | `AweberBlock` block build | Connected AWeber account id (first account). |
| `enable_redirect` | settings form (Redirect Settings) | Redirect visitor after signup. |
| `redirect_link` | settings form | Internal URL to redirect to (defaults to `/aweber_block/thankyou`). |

Note: the install YAML lists a legacy `api_key` key, but the settings form uses `client_id`/`client_secret`; `api_key` is unused by code.

## Scopes

`AweberScopes::SCOPES` (`src/AweberScopes.php`) maps checkbox keys to AWeber scope strings: `account.read`, `list.read`, `list.write`, `subscriber.read`, `subscriber.write`, `email.read`, `email.write`, `subscriber.read-extended`. Authorizing with no scope selected yields an app that can do nothing — a common setup error.

## Authorize (OAuth2 authorization-code) flow

1. Admin opens `/admin/config/aweber_block/config`, enters credentials/URLs, selects scopes, saves.
2. Admin opens `/admin/config/aweber_block/get_authorization` (`AweberBlockController::getAuthorization()`), which calls `AweberAuthentication::buildAuthorizationUrl()` and renders a link. The URL carries `response_type=code`, `client_id`, `redirect_uri`, space-joined `scope`, and `state`.
3. Admin follows the link, logs into AWeber, approves. AWeber redirects to `redirect_uri` = `/aweber_block/getCode?code=...`.
4. `AweberBlockController::getCode()` reads `code`, calls `AweberAuthentication::getAccessToken($code)` — a Guzzle `POST` to `https://auth.aweber.com/oauth2/token` with HTTP Basic `auth => [client_id, client_secret]` and `grant_type=authorization_code`. The JSON token response is decoded and `saveAccessToken()` stores `auth_token`/`refresh_token`/`expires_in`.

## Token refresh

`AweberAuthentication::getStoredAccessToken()` compares `expires_in` against the current time; if expired it calls `refreshAccessToken()` (Basic-auth `POST` to the token endpoint with `grant_type=refresh_token`), saves the new tokens, and returns the fresh access token. TLS verification uses Guzzle defaults (enabled).

## Routes & permissions

All admin routes (`config`, `get_authorization`, callback `getCode`, `main_menu`) require core `access administration pages`. The thank-you route `aweber_block_redirect.default` (`/aweber_block/thankyou`) requires `access content`. The module defines no permissions of its own.

## Menu / tasks

`aweber_block.links.menu.yml` adds an "Aweber" admin-config group with "Authorize site on Aweber" and "Aweber Settings" children; `aweber_block.links.task.yml` adds Settings/Authorize local tasks on the config form.
