<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DaData API — service API reference

Three services (all extend `Drupal\dadata_api\DaDataApiBase`). Inject or fetch via the container,
e.g. `\Drupal::service('dadata_api.suggestions')`. All methods return a JSON-decoded array, or
`NULL` on any non-2xx response or JSON decode error.

## Request mechanics — `DaDataApiBase`
- `getBaseUrl()` — abstract; each subclass returns its API root. `getRequestUrl($path)` appends the
  path.
- `getRequestHeaders()` — always sends `Accept: application/json` and
  `Authorization: Token <api_key>`.
- `sendRequest($url, $options)` — the core call. Option defaults: `method` `GET` (only `GET`/`POST`
  allowed; anything else is coerced to `GET`), `secret` `FALSE`, `timeout` from config,
  `http_errors` FALSE. When `secret => TRUE`, adds header `X-Secret: <secret>`. For `POST`, adds
  `Content-Type: application/json` and sends the Guzzle `body`. Uses the injected Guzzle
  `@http_client` with standard TLS verification. On HTTP 2xx it JSON-decodes the body and returns
  it; otherwise returns `NULL`.

## `dadata_api.info` — `DaDataApiInfo` (base `https://dadata.ru/api/v2`)
- `getVersion()` — GET `version`. Statically cached per request.
- `getBalance()` — GET `profile/balance` with `secret => TRUE`. Statically cached.
- `getStat($date = '')` — GET `stat/daily?date=<date>` (default today) with `secret => TRUE`.
  Cached per date.

## `dadata_api.cleaner` — `DaDataApiCleaner` (base `https://cleaner.dadata.ru/api/v1/clean`)
- `clean(array $data, $type = NULL)` — POST to `clean/<type>` (or `clean` when `$type` is NULL),
  body = JSON of `$data`, `secret => TRUE`. `$type` is a DaData cleaner type such as `address`,
  `name`, `phone`, `email`, `birthdate`, `vehicle`, `passport`. `$data` is the array of raw records
  to standardize.

## `dadata_api.suggestions` — `DaDataApiSuggestions` (base `https://suggestions.dadata.ru/suggestions/api/4_1/rs`)
- `suggest(array $data, $type)` — POST `suggest/<type>` (e.g. `address`, `party`, `bank`, `fio`),
  body = JSON of `$data` (typically `['query' => '...']`). Autocomplete-style suggestions.
- `findById(array $data, $type)` — POST `findById/<type>`; look up a record by identifier
  (e.g. company by INN, bank by BIC).
- `geoLocate(array $data, $type, $method = 'GET')` — `geolocate/<type>` where `$type` is `address`
  or `postal_unit`. GET sends `$data` as query params; POST sends it as a JSON body. Finds nearest
  addresses to lat/lon coords.
- `ipLocate($ip = NULL)` — GET `iplocate/address?ip=<ip>`. When `$ip` is NULL it uses the current
  request's client IP (`\Drupal::request()->getClientIp()`). Cached per IP.

## Notes
- These methods do not check any Drupal permission; enforce access in the calling code if you expose
  them to end users.
- Return is `NULL` (not an exception) on failure — always null-check.
