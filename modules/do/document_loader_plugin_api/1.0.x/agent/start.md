<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Document Loader Plugin - API (document_loader_plugin_api) — agent index

Registers ONE `DocumentLoader` plugin that fetches an HTTP/HTTPS API endpoint and converts the
response into six output formats. Package `Document Loader Plugins`. Depends on
**`document_loader:document_loader`** (composer `drupal/document_loader:^2.0`). Core
`^10.3 || ^11`. License GPL-2.0-or-later. Version 1.0.x (installed `1.0.0-alpha3`).

- **The plugin, its attribute, `load()` flow, ApiInput usage, error handling** →
  [plugins/api-loader.md](plugins/api-loader.md)
- **The six output formats + the `TomlFormatter` utility** →
  [api/output-formats.md](api/output-formats.md)
- **Submodule** `document_loader_plugin_api_tool` (AI Tool wrapper) is documented in its own tree at
  `modules/document_loader_plugin_api_tool/1.0.x/`.

## What it actually is

- One plugin: `ApiLoader` (id **`document_loader:api`**, label *"API Loader"*), in
  `src/Plugin/DocumentLoader/ApiLoader.php`, extending `Drupal\document_loader\Plugin\DocumentLoaderBase`
  and declared with the `#[DocumentLoader]` attribute
  (`document_loader_types: ['document_loader_type:api']`,
  `output_types: ['json','yaml','markdown','text','csv','toml']`).
- One utility: `TomlFormatter` in `src/Utility/TomlFormatter.php` (static array→TOML converter).
- It does **not** define a plugin type, service, route, permission, config, or hook. It is a plugin
  *instance* of the plugin type owned by the `document_loader` module. `provides_plugin_types = []`.
- Reached programmatically: `\Drupal::service('plugin.manager.document_loader')->createInstance('document_loader:api')`
  then `->load($apiInput, $format)`. No admin UI.

## Mechanism (from source)

- `ApiLoader::create()` injects `http_client` (Guzzle `ClientInterface`).
- `ApiLoader::load(DocumentLoaderInputInterface $input, string $output_format = 'text')` requires an
  `ApiInput` (else throws `InvalidArgumentException`). Empty format defaults to `markdown`.
- Builds Guzzle options: `timeout => 30`, default headers `User-Agent: Drupal Document Loader` +
  `Accept: application/json` merged with `$input->getHeaders()`; adds `body` only for POST/PUT/PATCH.
- Sends `httpClient->request($input->getMethod(), $input->getUrl(), $options)`, reads the body,
  `json_decode`s it (non-JSON → `['content' => <raw>]`), builds a `$metadata` array
  (`source, method, type=api, loader=api_loader, status_code, content_type, fetched_at`).
- `match($format)` returns the matching Output object; unknown format → `InvalidArgumentException`
  via `getUnsupportedFormatMessage()`. Any thrown error is re-wrapped as
  `"Unable to load API endpoint: <msg>"`.

## Dependencies & requirements

- Runtime module dep: `document_loader` (provides the plugin manager `plugin.manager.document_loader`,
  `DocumentLoaderBase`, `ApiInput`, and the Output value objects).
- Composer: `drupal/document_loader:^2.0`, `drupal/core:^10.4 || ^11`. No PHP constraint declared.
- Tests: `tests/src/Unit/**` (ApiLoaderTest, TomlFormatterTest) using a Guzzle `MockHandler`.
