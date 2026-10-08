<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FileMaker API fetcher — setup & behavior

## Keys (required)
Define three Key entities (module: `key`), values typically via `settings.php`:
```php
$config['key.key.filemaker_auth_endpoint']['key_provider_settings']['key_value'] = "https://<host>/fmi/data/vLatest/databases/<db>/sessions";
$config['key.key.filemaker_username']['key_provider_settings']['key_value'] = "USERNAME";
$config['key.key.filemaker_password']['key_provider_settings']['key_value'] = "PASSWORD";
```

## Flow
1. `authenticate()` POSTs to the auth endpoint with `Authorization: Basic base64(user:pass)` and `{fmDataSource:[]}`; reads `response.token`.
2. Records fetched from the feed **source URL** with `Authorization: Bearer <token>`.
   - **GET:** `_limit`, `_offset`, plus custom `query_parameters`.
   - **POST:** `Content-Type: application/json`, body from `query_criteria` (+ `limit`/`offset`).
3. Batches until fewer than `batch_size` returned or `max_batches` reached; next offset saved in `state` `filemaker_<feedid>_offset`.
4. End-of-data (or FileMaker error `101` "Record is missing") resets offset to 1.
5. Items written to a temp JSON array file → parsed by a `FileMakerJsonParserBase` subclass.

## Options
`batch_size` (1–1000), `max_batches` (0 = unlimited), `throttle_enabled` + `throttle_delay` (>=1s). TLS: Guzzle defaults (verification on). Configure per Feed type in the Feeds admin UI.
