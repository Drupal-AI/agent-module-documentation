<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AT-LS REST client (AtlsApiManager)

Service `at_ls.api_manager` → `Service\AtlsApiManager` (interface `Service\AtlsApiManagerInterface`). Wraps the AT-LS REST API. Constructor args: `at_ls.http_client`, `logger.channel.at_ls`, `config.factory`, `key.repository`, `language_manager`.

## Endpoint & transport
- Base URL constant `ENDPOINT = 'https://rts.at-ls.com/atrts/restapi/'` (interface). HTTPS.
- HTTP is done by `Http\GuzzleHttpClient::handleRequest()` (`at_ls.http_client`), a thin wrapper over a plain `new GuzzleHttp\Client()` calling `$client->request($method, $uri, $options)` and returning the body string (exceptions are caught and logged, returning NULL). Default Guzzle TLS verification applies.
- `AtlsApiManager::request()` sets `REQUEST_TIMEOUT = 10` seconds and headers `X-ATRTS-API-Key: <key>` and `Cache-Control: no-cache`, then `Json::decode()`s the response.

## Auth
`getApiKey($source_language)` reads `at_ls.settings` `api_keys`, finds the entry whose `source_language` matches (or the first key if none given), then loads that **Key** entity id through `KeyRepositoryInterface::getKey()->getKeyValue()`. Missing/absent keys are logged as errors and return NULL. The resolved secret is sent only in the `X-ATRTS-API-Key` request header.

## Language codes
`AtlsTrait::getAtlsLangCode()` / `getLangCode()` translate between Drupal langcodes and AT-LS ISO 639-2 codes using the `at_ls.languages` `langcodes` map. Source/target langs are converted to AT-LS codes before being sent.

## Methods (all return `?array`)
- `ping()` — `GET ping`.
- `getList($source, $target, ?DrupalDateTime)` — `GET getlist` with `sourcelang`, `targetlang`, `datecutoff` (format `Y-m-d\TH:i:s\Z`).
- `translateSynchronous($source, $target, $filename, $text, $encoding=UTF-8)` — `POST translateSynchronous`, `form_params` with `base64 = base64_encode($text)`. Result carries `status` and `base64` (the translated payload).
- `translateAsynchronous($source, $target, $filename, $text, $callbackurl=NULL, $encoding=UTF-8)` — `POST translateAsynchronous`; also sends `callbackurl` and `errnotifiersendto` (the settings `notification_email`). Result carries a `token`.
- `getFileByToken($token, $source)` — `GET getFileByToken?token=…`. Result: `status` (AT-LS numeric code) + `base64`.
- `deleteFileByToken($token, $source)` — `POST delFileByToken` with `token`.

## Result shape used by callers
`AtlsStringInterface::ATLS_STATUS_WORKFLOW_STATE` maps AT-LS numeric status → string workflow state: `10→review, 20→pending, 30→delivered, 40→removed, 100→error`. Translated text is `base64_decode($result['base64'])` then JSON-decoded to `{text: …}` (see `AtlsTranslationRequestManager::decodeJsonText()` / the callback controller).
