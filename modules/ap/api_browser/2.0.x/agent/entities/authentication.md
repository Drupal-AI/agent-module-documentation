<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Authentication & secrets

Both the `listing` and `project` requests carry an `auth` type and a `credentials` mapping.
`ApiBrowserService::authorizeRequest($authType, $credentials, $options)` builds the Guzzle request
options; the credential form is built by `ApiBrowserServiceForm::getAuthConfigScreen()` /
`secretElements()`. Types come from `getAuthTypes()` (alterable via `api_browser_auth_types`).

## The auth types (`authorizeRequest()` switch)

- **`no_auth`** — nothing added.
- **`api_key`** — puts `resolveSecret(credentials,'value')` under the parameter `credentials['key']`,
  in `headers` or `query` per `credentials['location']` (only those two locations accepted).
- **`bearer_token`** — `Authorization: Bearer <resolveSecret(credentials,'token')>`.
- **`oauth2`** — `getOauth2Token()` does a `client_credentials` grant, then
  `Authorization: Bearer <token>`.
- **`basic_auth`** — `Authorization: Basic base64(username:resolveSecret(...,'password'))`. Built by
  hand because requests are PSR-7 objects sent through a pool, which does not honour Guzzle's `auth`
  option.

After the switch, `api_browser_authorize_request[_<id>]` is altered so other modules can adjust
options/credentials.

## Secrets: literal vs Key entity (`resolveSecret()`)

Each secret field has a companion `<field>_key`. `resolveSecret($credentials, $field)`:

- If `<field>_key` is set → require the **Key** module, load `key.repository`→`getKey($id)`, return
  `$key->getKeyValue()`. Missing module or missing key → logs an error and returns `''`.
- Else → return the literal `credentials[$field]`.

So a service can store either the raw secret (written to config exports) or just a key name. The
form's `secretElements()` shows a `key_select` when Key is installed and hides the literal field
when a key is chosen; `ApiBrowserRequirements` (a `runtime_requirements` hook) raises a **Warning**
on the status report listing any service whose `api_key`/`bearer_token`/`basic_auth` secret is a
literal with no key selected (`SECRET_FIELDS = value|token|password`).

## OAuth 2.0 detail (`getOauth2Token()`)

- Needs `credentials['token_url']` + `client_id` (+ optional `scope`); secret via
  `resolveSecret(credentials,'client_secret')`.
- POSTs `grant_type=client_credentials` (form params) to the token URL. The token is cached keyed by
  `md5(url|client_id|secret|scope)` and expires `expires_in - 30`s early, so a huge listing does not
  re-exchange per request.
- On failure it logs only the token URL + HTTP status — **not** the exception/response body — to
  avoid echoing a secret into the log.

## Logging & redaction

When `log_requests` is on, `logRequest()` records method, URL, status and duration on the
`api_browser` channel. `redactUri()` replaces the value of any query-string credential parameter
(`listing`/`project` `credentials['key']`) with `[redacted]`; header-borne credentials are never
logged.
