<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bigin OAuth2 + REST client

Files: `src/BiginAuthService.php`, `src/Rest/RestClient.php`, `src/Controller/BiginController.php`.

## Data-center domains

`BiginAuthService::url_account()` and `url_api()` map the `domain` setting to a fixed pair of hosts
(the request cannot override them):

| domain | accounts (OAuth) | api (REST) |
|---|---|---|
| com | `https://accounts.zoho.com` | `https://www.zohoapis.com` |
| eu | `https://accounts.zoho.eu` | `https://www.zohoapis.eu` |
| cn | `https://accounts.zoho.com.cn` | `https://www.zohoapis.com.cn` |
| in | `https://accounts.zoho.in` | `https://www.zohoapis.in` |

## Connect flow (authorization code)

1. `BiginController::initialize()` (settings page) builds the authorize link:
   `{url_account}/oauth/v2/auth?scope=<scopes>&client_id=<client_id>&response_type=code&access_type=offline&redirect_uri=<callback>&prompt=consent`.
   Scopes: `ZohoBigin.modules.contacts.CREATE,ZohoBigin.settings.layouts.READ,ZohoBigin.modules.deals.CREATE,ZohoBigin.users.READ`.
   `redirect_uri` = `Url::fromRoute('bigin_crm.callback', absolute)` = `/auth/bigin/callback`.
2. Admin clicks it, authorizes at Zoho, Zoho redirects back to `bigin_crm.callback`.
3. `BiginController::callback()` reads `?code=` and calls
   `BiginAuthService::generate_access_token($code)`.
4. `generate_access_token()` POSTs to `{url_account}/oauth/v2/token` with `client_id`,
   `client_secret`, `code`, `grant_type=authorization_code`, `redirect_uri`. On a response with
   both `access_token` and `refresh_token` it **inserts a row** into `bigin_crm_token`
   (access_token, refresh_token, created=now) and logs success.

## Token lifecycle

- `access_token()` — reads the newest `bigin_crm_token` row (`ORDER BY id DESC`), returns
  `access_token` or `''`.
- `refresh_token()` — looks up the row for the current access token, POSTs
  `grant_type=refresh_token` with the stored `refresh_token` + client id/secret to
  `/oauth/v2/token`, then **updates** the row's `access_token` + `created`.
- `revoke_token()` — POSTs the access token to `/oauth/v2/token/revoke`; on `status == 'success'`
  **deletes** the row; otherwise calls `refresh_token()` and returns FALSE. Wired to
  `BiginController::revoke()` (route `bigin_crm.revoke`).

## RestClient (`Rest\RestClient`)

- Constructed with `@http_client` (Drupal core Guzzle), `@config.factory`, `@logger.factory`.
- `api_call($url, $params = [], $body = [], $method = 'GET')`:
  - If the URL targets the REST api host and no access token exists, logs `"Invalid token"` and
    returns `[]`.
  - `request_http()` sets `Content-type: application/json` and
    `Authorization: Zoho-oauthtoken <access_token>`, JSON-encodes the body, merges `query` =
    `$params`, and calls `$this->httpClient->$method($url, $args)` — TLS verification is Guzzle's
    default (on).
  - On HTTP **401** it calls `auth_service->refresh_token()` and retries the request once.
  - `response_http()` returns `json_decode($body)` (a stdClass/array) or `[]` when empty.

## Operating notes

- No API base URL is request-supplied; both hosts derive from the `domain` select. Tokens live in
  the `bigin_crm_token` DB table (not in config); `client_id`/`client_secret` live in the
  `bigin_crm.settings` config object. Everything is admin-only (`administer crm integration`).
