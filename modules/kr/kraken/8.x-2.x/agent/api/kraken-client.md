<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Kraken.io client & processing flow (API)

All logic is in `src/Plugin/ImageAPIOptimizeProcessor/KrakenProcessor.php` plus the requirements
check in `src/Hook/KrakenRequirementsHook.php`. The wire client is the `kraken-io/kraken-php`
`\Kraken` class (global namespace), a thin cURL wrapper.

## `getKrakenClient(): ?\Kraken`

`KrakenProcessor.php:getKrakenClient()` returns `NULL` unless the `\Kraken` class exists **and** both
`api_key` and `api_secret` are non-empty. Otherwise it builds:

```php
new \Kraken($this->configuration['api_key'], $this->configuration['api_secret'], $timeout, $proxy_params);
```

- `$timeout = 5` — hardcoded (there is a `@todo` to make it configurable).
- `$proxy_params['proxy']` is taken from `Settings::get('http_client_config')['proxy']['https']`
  when set (so the Kraken calls honor a configured HTTPS proxy).

## `applyToImage($image_uri)` — the optimize path

Called by `imageapi_optimize` for each derivative. Sequence:

1. Guard: `\Kraken` class present and both credentials set (else logs an error and returns `FALSE`).
2. Build params: `file` = `$this->fileSystem->realpath($image_uri)`, `wait` = `TRUE` (synchronous),
   `lossy` = configured bool; if `webp` is on, adds `convert => ['format' => 'webp']`.
3. `$data = $kraken->upload($params)` → POST multipart to `https://api.kraken.io/v1/upload`.
4. On `!empty($data['success']) && !empty($data['kraked_url'])`: downloads the optimized file with the
   site's Guzzle `http_client` — `$this->httpClient->get($data['kraked_url'])`. If HTTP 200, writes it
   over the derivative with `$this->fileSystem->saveData($body, $image_uri, FileExists::Replace)` and
   returns `TRUE`.
5. Failure branches log to the `imageapi_optimize` channel: download `RequestException` →
   `logger->error`; Kraken reported failure → "could not optimize"; missing creds / missing library →
   error; returns `FALSE`.
6. Success logging: only when the `logging` config key is TRUE — logs file name and original/kraked/
   saved byte counts (never the credentials).

`kraked_url` comes from the account's authenticated API response over the `\Kraken` client (which sets
`CURLOPT_SSL_VERIFYPEER = 1`); the follow-up download uses Drupal's `http_client`, which verifies TLS
by default.

## `getApiKeyHash(): string`

`sha1($api_key . ':' . $api_secret)` — a stable per-account identifier used to group pipelines that
share one Kraken.io account in the requirements report.

## Requirements check — `KrakenRequirementsHook::runtime()`

Runs on `runtime_requirements` (status report). Steps:

- If `\Kraken` class is not loaded → `kraken_class` REQUIREMENT_ERROR ("install dependencies via
  composer").
- Loads all `ImageAPIOptimizePipeline` entities, finds each `KrakenProcessor`, and groups their
  clients by `getApiKeyHash()` (so each distinct account is checked once).
- For each account, calls `$client->status()` (`https://api.kraken.io/user_status`):
  - no `success` → REQUIREMENT_ERROR "Could not connect", lists the affected pipelines.
  - `plan_name` + `quota_total` + `quota_remaining` present → reports plan size and remaining quota;
    severity WARNING when `quota_remaining / quota_total < 0.05` (or `quota_total == 0`), else OK.
  - otherwise → REQUIREMENT_WARNING "Unknown response".

## External calls summary

| Purpose | Method | URL | Transport |
|---|---|---|---|
| Upload/optimize | `\Kraken::upload()` | `https://api.kraken.io/v1/upload` | cURL (`CURLOPT_SSL_VERIFYPEER=1`) |
| Account status/quota | `\Kraken::status()` | `https://api.kraken.io/user_status` | cURL (`CURLOPT_SSL_VERIFYPEER=1`) |
| Download optimized file | `http_client->get()` | `kraked_url` from the upload response | Guzzle (TLS verified) |
