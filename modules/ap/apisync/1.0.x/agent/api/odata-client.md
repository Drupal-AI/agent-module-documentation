<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ODataClient — talking to the remote API

Service `apisync.odata_client` = `Drupal\apisync\OData\ODataClient` (implements `ODataClientInterface`). Wraps core Guzzle `@http_client`; adds auth headers, JSON encode/decode, and metadata caching.

## Request pipeline
`ODataClient::request($method, $uri, $options, $retry = TRUE)` (protected):
- If `$uri` doesn't start with `http`, prefixes `getInstanceUrl()` (`apisync.settings:instance_url`, trailing `/` trimmed).
- Sets `http_errors => TRUE` and **`allow_redirects => FALSE`**.
- Calls `$this->authManager->appendAuthHeaders($headers)` — the active provider injects `Authorization` (Basic or Bearer).
- On `ClientException` with 401/403 and a token-based provider (`isTokenBasedProvider()`), clears the access token and retries once; otherwise wraps everything as `Drupal\apisync\Exception\ApiException`.
- TLS: uses Guzzle defaults. HTTPS depends on the `instance_url` scheme.

`apiCall($path, $params, $method, $returnObject)` sets `Content-type: application/json` (adds `If-Match: *` for PATCH), JSON-encodes the body, and JSON-decodes the response.

## Public methods (ODataClientInterface)
- `query(SelectQueryInterface $q): SelectQueryResultInterface` — GET `/{query}`; `$q` stringifies via `SelectQuery::__toString()`.
- `queryAll($q)` — GET `/queryAll?q=…`.
- `queryMore(SelectQueryResultInterface $r)` — follows `@odata.nextLink` (`nextRecordsUrl()`), instance URL stripped.
- `objects(bool $reset=FALSE): array` — parse `$metadata` (from `getMetadataUrl()`) → schema properties; cached `odata:objects` for `short_term_cache_lifetime`.
- `objectDescribe(string $name, $reset=FALSE)` — one object's description.
- `objectCreate(string $type, array $params): ODataObjectInterface` — POST `/{type}`.
- `objectRead(string $path): ODataObjectInterface` — GET.
- `objectUpdate(string $path, array $params): void` — PATCH (`If-Match: *`).
- `objectDelete(string $path, bool $throwException=FALSE): void` — DELETE; swallows 404 unless asked to throw.
- `getInstanceUrl()`, `getMetadataUrl()`, `getShortTermCacheLifetime()`.

## Query building
`Drupal\apisync\OData\SelectQuery` builds an OData `$select/$filter/...` string; `SelectQueryResult` wraps `{ totalSize, done, records, nextRecordsUrl }`; `ODataObject` wraps a single record (`fields()`, `field()`); `ODataMetadataParser` + `XMLResponse` parse the metadata XML.

## Drush
`src/Commands/ApiSyncCommands.php` (service `apisync.commands`): `odata:list-objects`, `odata:describe-fields {object}`, `odata:query-object`, `odata:list-providers`.

Note: `apisync.services.yml` also declares `apisync.http_client_wrapper` (`Client\HttpClientWrapper`), but that class is not present on disk in this release and nothing references the service; the OData client uses `@http_client` directly.
