<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# THRONApi service (`thron_api`)

`Drupal\thron\THRONApi` — the integration facade. Injected with config.factory, entity_type.manager, logger.channel.thron, state, date.formatter, language_manager, `cache.thron`, datetime.time, current_user, http_client_factory.

## Capabilities
- `getLoginData()` — authenticates with client_id/app_id/app_key, caches token (`loginData_<client_id>`).
- Content: search / content detail (`contentDetailX` via THRON X tenant), embed-code + player-template generation.
- Taxonomy: classification list, tag-definition list/detail, category list, language list.
- Results cached in the `thron` cache bin, keyed by client_id.

## Transport & TLS
- Guzzle requests pass `'verify' => TRUE` (TLS verification ON).
- Legacy cURL path (`Thronintegration_HTTP::callCurl`) leaves `CURLOPT_SSL_VERIFYHOST/PEER` at cURL defaults (the disable lines are commented out).
- Request URLs are constructed from THRON endpoint config and THRON-returned S3 credentials — never from client request parameters (no SSRF surface).

## Upload flow
`THRONUploadController::uploadChunk` / `finalize` (permission `thron search media`): fetches short-lived S3 credentials via `Thronintegration_Api::getS3UploadCredentials`, initializes an S3 multipart upload, and stores upload state in the session keyed by `md5(fileName.contentName)`.
