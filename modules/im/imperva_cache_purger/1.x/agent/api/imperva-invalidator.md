<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service — ImpervaCacheInvalidator (imperva_cache_purger.invalidator)

`src/ImpervaCacheInvalidator.php`, class `ImpervaCacheInvalidator`. Registered in
`imperva_cache_purger.services.yml` as `imperva_cache_purger.invalidator` with one argument,
`@http_client` (Drupal's shared Guzzle `GuzzleHttp\Client`). Constant
`IMPERVA_API_ENDPOINT = 'https://my.imperva.com/api/prov/v2/sites/'`.

This service performs the actual Imperva Cloud Application Security REST calls. The purger
plugin (see plugins/purger.md) is its only caller.

## `invalidate(ImmutableConfig $settings, ?LoggerChannelPartInterface $logger, array $paths, array $tags): void`

- Builds request `$options['headers']` from `getRequestHeaders()`.
- If `$paths` non-empty **and** `purger_type` is `path_cache_tag` or `path`: for each path set
  `$options['query']['url_pattern'] = getRequestQuery($path)` and call `executeRequest()`.
- If `$tags` non-empty **and** `purger_type` is `path_cache_tag` or `cache_tag`: unset the
  leftover `url_pattern` query, then for each tag set `$options['query']['tags'] =
  getRequestQuery($tag)` and call `executeRequest()`. One request per path and per tag
  ("multiple paths are not supported yet").

## Helpers

- `getRequestHeaders(ImmutableConfig $settings): array` → `['x-api-key' => settings.api_key,
  'x-api-id' => settings.api_id, 'Content-Type' => 'application/json']`. Auth is header-based.
- `getRequestQuery($value)` → if array, `implode(',', $value)`; else the value unchanged.
- `getApiEndpoint(ImmutableConfig $settings): string` → base = `settings.api_endpoint` if set,
  else `IMPERVA_API_ENDPOINT`; returns `base . settings.site_id . '/cache'`.

## `executeRequest(array $options, ImmutableConfig $settings, ?LoggerChannelPartInterface $logger)`

- `$this->httpClient->request('DELETE', getApiEndpoint($settings), $options)`.
- If `getStatusCode() != 200` → `errorHandlerApi()` (logs the response body via
  `$logger->error(...)`). Note: Guzzle's default `http_errors` makes 4xx/5xx **throw** a
  `RequestException` before this check, which the purger's try/catch converts to a FAILED state.
- On 200: logs `Successfully invalidated URL: @url` and/or `Successfully invalidated cache
  tags: @tags` (when those query keys are present), then `Json::decode()`s the body and returns
  `$data['debug_info']['id-info']` (Imperva's log reference id).

`errorHandlerApi(object $request, ?LoggerChannelPartInterface $logger)` returns
`$logger->error($request->getBody()->getContents())` — writes the Imperva API response body to
the logger.

## Transport notes

- HTTP transport is Drupal's injected `@http_client` (Guzzle) with default options; the module
  sets only `headers` and `query`. Endpoint host comes from the `IMPERVA_API_ENDPOINT` constant
  unless an admin overrides `api_endpoint`.
- Credentials travel in request **headers** (`x-api-key` / `x-api-id`), not in the URL/query.
- The DELETE method + `url_pattern` / `tags` query parameters follow Imperva's
  `POST/DELETE /sites/{site_id}/cache` purge API shape.
