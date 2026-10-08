<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tool: `document_loader_from_api`

Source: `src/Plugin/tool/Tool/DocumentLoaderTool.php`. Class `DocumentLoaderTool extends
Drupal\tool\Tool\ToolBase`.

## Install / enable

- `drush en document_loader_plugin_api_tool` (pulls in `document_loader_plugin_api` and `tool`).
- No config or admin form. The tool becomes available to any Tool-API consumer (e.g. an AI agent).

## Definition (`#[Tool]` attribute)

- `id: 'document_loader_from_api'`, label *"Load Document from API"*.
- `operation: ToolOperation::Read`.
- `input_definitions` (`Drupal\tool\TypedData\InputDefinition`):
  - `location` (string, required) — API endpoint URL.
  - `output_format` (string, optional) — help text lists `text, json, yaml, html, markdown`
    (the loader actually supports json/yaml/markdown/text/csv/toml; `html` is not implemented).
  - `http_method` (string, optional) — GET/POST/PUT/PATCH, default GET.
  - `request_body` (string, optional) — JSON body for POST/PUT/PATCH.
  - `request_headers` (string, optional) — JSON object of extra HTTP headers.
- `output_definitions` (`ContextDefinition`): `content` (loaded content), `format` (format used).

## Execution flow (`doExecute`)

1. `$location = $values['location']`; `$output_format = $values['output_format'] ?? 'markdown'`.
2. Parse `location`: `$ext` from the path, `$scheme` from the URL. `$isUrl = in_array($scheme,
   ['http','https'], TRUE)` — non-http/https schemes are rejected outright.
3. If `$isUrl`, compute `$looksLikeApi` = path matches `#/api(/|$)#i`, or `$ext` in
   `['json','xml','yaml','yml','toml']`, or the URL ends in one of those extensions.
4. Proceed to fetch when `method != GET` **OR** a request body is present **OR** request headers are
   present **OR** `$looksLikeApi`. (So any caller can force the fetch by setting `http_method` or a
   header.)
5. `loadApi($location, $method, $body, $headers_json, $output_format)`:
   - `$headers_json` (if given) is `json_decode`d; invalid JSON → `\InvalidArgumentException`.
   - Builds `new ApiInput($url, ['method' => strtoupper($method), 'headers' => $headers, 'body' => $body])`.
   - `executeLoader('document_loader:api', $input, $format)` →
     `pluginManager->createInstance('document_loader:api')->load($input, $format)`.
6. Success → `ExecutableResult::success('Successfully loaded document from: <location>', ['content' => ..., 'format' => ...])`.
   Loader exceptions → `ExecutableResult::failure('Failed to load document: <error>')`.
   Non-URL / undetermined source → `ExecutableResult::failure('... Unable to determine source type ...')`.

## Access

```php
protected function checkAccess(array $values, AccountInterface $account, bool $return_as_object = FALSE): bool|AccessResultInterface {
  $access = AccessResult::allowedIf($account->isAuthenticated());
  return $return_as_object ? $access : $access->isAllowed();
}
```

Access is granted to **any authenticated user** — the tool defines no permission of its own and does
not require any parent-module or `tool`-module permission in this check. Anonymous callers are denied.

## Relationship to the parent loader

The tool contributes no fetching logic — it constructs an `ApiInput` and hands it to the parent
module's `document_loader:api` plugin (`ApiLoader`), which performs the actual Guzzle request and
format conversion (see the parent tree's `agent/plugins/api-loader.md`).
