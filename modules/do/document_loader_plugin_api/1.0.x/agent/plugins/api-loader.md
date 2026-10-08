<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ApiLoader — the `document_loader:api` plugin

Source: `src/Plugin/DocumentLoader/ApiLoader.php`. Class `ApiLoader extends
Drupal\document_loader\Plugin\DocumentLoaderBase`.

## Definition (attribute)

```php
#[DocumentLoader(
  id: 'document_loader:api',
  label: new TranslatableMarkup('API Loader'),
  description: new TranslatableMarkup('Load and transform data from API endpoints'),
  document_loader_types: ['document_loader_type:api'],
  output_types: ['json', 'yaml', 'markdown', 'text', 'csv', 'toml'],
)]
```

The `#[DocumentLoader]` attribute is `Drupal\document_loader\Attribute\DocumentLoader` — defined by
the **`document_loader`** module, not here. `document_loader_types` links the plugin to the
`document_loader_type:api` input type (`ApiInput`); `output_types` is echoed back in the
unsupported-format error message.

## Install / enable

- `drush en document_loader_plugin_api` (pulls in `document_loader`). No config, no permissions, no
  admin form — enabling it just makes the plugin discoverable.

## Getting an instance

```php
$manager = \Drupal::service('plugin.manager.document_loader');
$loader = $manager->createInstance('document_loader:api');
```

`ApiLoader::create()` (dependency injection) calls `parent::create()` then sets
`$instance->httpClient = $container->get('http_client')` (Guzzle `ClientInterface`).

## `load()` contract

```php
public function load(DocumentLoaderInputInterface $input, string $output_format = 'text'): DocumentLoaderOutputInterface
```

Steps (verbatim from source):

1. If `$input` is not an `ApiInput`, throw `\InvalidArgumentException('ApiLoader only accepts ApiInput instances')`.
2. `$format = $output_format !== '' ? strtolower($output_format) : 'markdown'` — note the default here
   is **markdown**, whereas the method signature default is `'text'` (so an explicit `''` → markdown).
3. Build Guzzle options: `timeout => 30`; headers = `['User-Agent' => 'Drupal Document Loader',
   'Accept' => 'application/json']` merged with `$input->getHeaders()` (caller headers win).
4. If `$input->getBody() !== NULL` **and** the method (uppercased) is POST/PUT/PATCH, set `body`.
5. `$response = $this->httpClient->request($input->getMethod(), $input->getUrl(), $options)`.
6. `json_decode($body, TRUE)`; on `json_last_error()` set `$data = ['content' => $response_body]`.
7. Build `$metadata`: `source`, `method`, `type => 'api'`, `loader => 'api_loader'`, `status_code`,
   `content_type` (from `Content-Type` header), `fetched_at` (`date('Y-m-d H:i:s')`).
8. `match($format)` → one Output object (see [../api/output-formats.md](../api/output-formats.md)).
   Unknown format → `\InvalidArgumentException` via `getUnsupportedFormatMessage()`.
9. Everything runs in a `try/catch`; any `\Exception` is re-thrown as
   `'Unable to load API endpoint: ' . $e->getMessage()`.

## `ApiInput` (from the `document_loader` module)

`ApiLoader` only reads the input via getters: `getUrl()`, `getMethod()`, `getHeaders()`, `getBody()`.
This module constructs `ApiInput` with a URL plus an options array, e.g. the submodule does:

```php
new ApiInput($url, ['method' => 'POST', 'headers' => [...], 'body' => $body]);
```

`ApiInput` is defined by `document_loader` and is designed to be subclassed (protected properties,
overridable getters) — e.g. override `getHeaders()` to inject a bearer token for authenticated APIs
(see the project README). Nothing about the input class lives in this module.

## Notes

- Uses Drupal's shared `http_client`, so Guzzle's default TLS verification applies (no `verify => false`).
- No caching: every `load()` performs a fresh request. No rate limiting or retries.
- The response body is JSON-decoded into a PHP array and then re-serialized; binary/non-text
  responses are treated as a single `content` string.
