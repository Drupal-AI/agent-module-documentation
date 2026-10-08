<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service `unstructured.api` — UnstructuredApi

`Drupal\unstructured\UnstructuredApi` (`src/UnstructuredApi.php`), service id `unstructured.api`.
Constructor args (`unstructured.services.yml`): `@http_client` (Guzzle), `@config.factory`,
`@key.repository`, plus the three formatter services (currently unused by the constructor — the
constructor signature only binds client/config/keyRepository).

## Construction

- Reads config `unstructured.settings`: `api_key` (a Key entity id) → resolved to the secret via
  `keyRepository->getKey($id)->getKeyValue()` when set, else empty string.
- `host` → `$baseHost`, defaulting to `https://api.unstructuredapp.io` when empty.

## `structure(File $file, array $options = []): array`

The only public method. Builds a Guzzle **multipart** body:

- part `files` = `fopen($file->getFileUri(), 'r')` streamed with `$file->getFilename()`.
- each `$options[$key]` becomes one or more `name/contents` parts (arrays expand to repeated parts,
  e.g. `extract_image_block_types => ['Image','Table']`).

Then calls `makeRequest('general/v0/general', [], 'POST', NULL, $guzzleOptions)` and returns
`json_decode(..., TRUE)` — the array of Unstructured **elements** (each `['type' => ..., 'text' => ...,
'metadata' => [...]]`).

## `makeRequest()` (protected)

- Throws if `$baseHost` is empty.
- Sets `connect_timeout`/`read_timeout`/`timeout` to **600s** (parsing is slow/expensive).
- Auth: when the API key is non-empty, adds header `unstructured-api-key: <key>` (header, not URL/query).
- Builds `$new_url = rtrim($baseHost,'/') . '/' . $path` (+ `http_build_query` if a query string is
  passed), then `$this->client->request($method, $new_url, $options)` and returns the raw body.
- Uses the injected Guzzle client with default options (standard TLS verification).

## Direct usage

```php
/** @var \Drupal\unstructured\UnstructuredApi $api */
$api = \Drupal::service('unstructured.api');
$file = \Drupal\file\Entity\File::load(5);
$elements = $api->structure($file, [
  'strategy' => 'hi_res',
  'extract_image_block_types' => ['Image', 'Table'],
]);
```

`$options` keys are passed straight through as Unstructured API form parameters (`strategy`,
`hi_res_model_name`, `extract_image_block_types`, etc.). Feed `$elements` to a formatter
(see [formatters.md](formatters.md)) to get text/markdown/HTML.
