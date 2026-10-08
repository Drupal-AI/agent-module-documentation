<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The vault service — `azure_key_vault.http_client`

Service id `azure_key_vault.http_client`, class `Drupal\azure_key_vault\AzureKeyVaultRequestHandler`
(`src/AzureKeyVaultRequestHandler.php`), implementing `AzureKeyVaultRequestHandlerInterface`
(`src/AzureKeyVaultRequestHandlerInterface.php`). This is the module's entire public surface for code.

## Injecting it

- Simple: `\Drupal::service('azure_key_vault.http_client')->getSecret("name")`.
- DI: type-hint `AzureKeyVaultRequestHandlerInterface`, inject `@azure_key_vault.http_client` in your
  service, or `$container->get('azure_key_vault.http_client')` in a `create()`.
- Constructor args (services.yml): `@azure_key_vault.configuration`, `@http_client`, `@cache.default`,
  `@logger.channel.azure_key_vault`. **Note:** the constructor immediately calls `getAccessToken()`, so
  instantiating the service performs a live AAD token POST — it is not lazy.

## Authentication (`getAccessToken()`, protected)

POSTs to config `token_url` with `form_params`:
`client_id` = config `vault_id`, `client_secret` = the Key value named by config `vault_secret`,
`scope` = `https://vault.azure.net/.default`, `grant_type` = `client_credentials`. Stores
`$data['access_token']` in `$this->accessToken`. On a Guzzle `ClientException` it logs a `warning` with
the AAD error body + http code and leaves the token empty. `validateConfig()` returns `FALSE` when no
token was obtained, else `TRUE`.

## Request builder (`sendRequest($type, $resource_name, $http_request, $request_body = NULL)`, private)

Base URL = config `azure_url` (empty for the generic `GET` type); path chosen by `$type`; version query
`?api-version=<api_version_number>` (config). Headers: `User-Agent: browser/1.0`, `Accept` +
`Content-Type: application/json`, `Authorization: Bearer <accessToken>`; body via Guzzle `json`. On a
non-200 status it logs an error and throws; on a `ClientException` it adds a messenger error, logs, and
returns `json_decode('{"value":"…api_call_error"}')`. Type → path map:

| type | HTTP | path |
|---|---|---|
| `SECRET` | PUT/GET | `secrets/{name}?api-version=…` |
| `GET_SECRETS` | GET | `secrets?maxresults=25&api-version=…` |
| `DELETE_SECRET` | DELETE | `secrets/{name}?api-version=…` |
| `PURGE_SECRET` | DELETE | `deletedsecrets/{name}?api-version=…` |
| `KEY` | GET | `keys/{name}?api-version=…` |
| `CREATE_KEY` | POST | `keys/{name}/create?api-version=…` |
| `ENCRYPT_KEY` | POST | `keys/{name}/encrypt?api-version=…` |
| `DECRYPT_KEY` | POST | `keys/{name}/decrypt?api-version=…` |
| `DELETE_KEY` | DELETE | `keys/{name}?api-version=…` |
| `GET` | GET | `{full_url}` (base URL blanked, caller supplies the whole URL) |

## Public methods

Secrets:
- `createSecret($secret_name, $value)` → PUT `secrets/{name}`, body `{value}`; returns created-secret array.
- `getSecret($secret_name)` → GET; returns the `["value"]` string.
- `getSecrets()` → GET `secrets?maxresults=25`; returns the list array.
- `deleteSecret($secret_name)` → soft delete (recoverable); returns metadata.
- `purgeSecret($secret_name)` → DELETE `deletedsecrets/{name}` (permanent).

Keys:
- `generateKey($key_name, $key_size)` → POST `create` with `kty=RSA`, `key_size=(int)`, full `key_ops`;
  returns `['key']['n']` (public modulus).
- `getKey($key_name)` → GET; returns `['key']['n']`.
- `encryptKey($value, $key_name)` → POST `encrypt`, alg `RSA1_5`; returns `['value']`.
- `decryptKey($encrypted, $key_name)` → POST `decrypt`, alg `RSA1_5`; then a chain of `str_ireplace`
  swaps (`/`↔`_`, `+`↔`-`) and appends `==` before returning. (Case-insensitive replaces that partly undo
  each other — treat the transform as source-specific, not standard base64url.)
- `deleteKey($key_name)` → DELETE; returns metadata.

Generic/util:
- `getData($full_url)` → GET the caller-supplied complete URL (base URL blanked).
- `validateConfig()` → bool, token present.

## Behaviour notes

- Despite the injected `@cache.default`, the class **does not cache** any response (the README lists
  caching as a future ToDo). Every call is a live HTTP round-trip; each new service instance re-fetches a
  token.
- `getSecret()`/`encryptKey()`/`decryptKey()` blindly index `["value"]`; on the error path `sendRequest`
  returns `{"value":"…error"}`, so callers get that error string rather than an exception.
