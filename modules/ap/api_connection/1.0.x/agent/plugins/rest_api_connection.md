<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `rest_api_connection` plugin type & `sendRequest()`

How to integrate an external REST API. Everything here is in `src/Plugin/**` and
`src/Attribute/RestApiConnection.php`.

## Plugin type wiring

- Manager: `RestApiConnectionManager` (`src/Plugin/RestApiConnectionManager.php`), service
  `plugin.manager.rest_api_connection` (`api_connection.services.yml`, `parent: default_plugin_manager`).
  Constructor args to `DefaultPluginManager`: subdir `Plugin/RestApiConnection`, interface
  `RestApiConnectionInterface`, attribute class `Attribute\RestApiConnection`, annotation class
  `Annotation\RestApiConnection`. Alter hook `api_connection_rest_api_connection_info`; cache key
  `api_connection_rest_api_connection_plugins`.
- Plugin definition properties (attribute `#[RestApiConnection(...)]` or `@RestApiConnection`
  annotation, both resolve to the same fields via `Annotation\ApiConnection`):
  - `id` (string), `label` (TranslatableMarkup),
  - `activated` (bool, default `TRUE`),
  - `urls` (array keyed by environment: `dev`, `test`, `live`).

## Writing a connection plugin

1. Put the class in `your_module/src/Plugin/RestApiConnection/YourApi.php`, extend
   `RestApiConnectionBase`, and declare the attribute:

   ```php
   #[RestApiConnection(
     id: 'your_api',
     label: new TranslatableMarkup('Your API'),
     urls: [
       'dev'  => 'https://dev.example.api',
       'test' => 'https://test.example.api',
       'live' => 'https://live.example.api',
     ],
     activated: TRUE,
   )]
   class YourApi extends RestApiConnectionBase { ... }
   ```

2. Add domain methods that wrap `sendRequest()`:
   `return $this->sendRequest("api/users/{$id}", 'GET');`
3. Instantiate: `\Drupal::service('plugin.manager.rest_api_connection')->createInstance('your_api')`
   (or inject the manager and call `createInstance()` in a controller/service `create()`).

## `sendRequest()` — `RestApiConnectionBase::sendRequest()`

Signature: `sendRequest(string $endpoint, string $method, array $options = [], bool $return_response_object = FALSE)`.

Flow (`src/Plugin/RestApiConnectionBase.php`):
1. If `pluginDefinition['activated'] !== TRUE` → returns `NULL` (when `$return_response_object`) or
   `FALSE` immediately (no call).
2. If `$options[RequestOptions::BODY]` is set, it is `Json::encode()`d.
3. Adds header `Content-Type: application/json` unless already set or `multipart` is used.
4. Resolves base URL: `pluginDefinition['urls'][ getEnvironment() ]`; if that key is missing it
   **throws `RestApiEnvironmentUrlException`**.
5. Sends `client->request($method, $base_url . '/' . $endpoint, $options)` inside `handleRequest()`,
   which catches `GuzzleException` and logs `$e->getMessage()` to the plugin's logger channel,
   returning `FALSE` on failure.
6. On success, `handleResponse()` logs the body if status != 200 (note: the source condition
   `!$response->getStatusCode() == 200` has an operator-precedence quirk), then either returns the
   PSR-7 `ResponseInterface` (`$return_response_object = TRUE`) or `Json::decode()`s the body. An
   empty body with a success status returns `TRUE`; otherwise the decoded array is returned.

Return type: `bool|array|\Psr\Http\Message\ResponseInterface|null`.

## Base classes & configuration

- `ApiConnectionBase` (`src/Plugin/ApiConnectionBase.php`, abstract, extends `PluginBase`) implements
  `ApiConnectionInterface` (which extends `ConfigurableInterface`, `PluginFormInterface`,
  `PluginInspectionInterface`, `ContainerFactoryPluginInterface`). It injects `logger.factory`
  (channel `api_connection_<plugin_id>`) and `config.factory` (reads `api_connection.settings`).
  Provides `getConfiguration()`, `setConfiguration()`, `defaultConfiguration()` (empty),
  `build/validate/submitConfigurationForm()` (no-ops by default) and
  `getEnvironment()` (returns `api_connection.settings:environment`).
- To give a plugin its own settings (API keys, options), override `defaultConfiguration()`,
  `buildConfigurationForm()`, `submitConfigurationForm()`; read them via `$this->configuration`.
  Note the module ships no admin UI that renders those plugin config forms — a consuming module must
  build/persist plugin configuration itself.
- `RestApiConnectionBase::create()` additionally injects `http_client_factory`; the constructor
  builds the Guzzle client from `ClientFactory::fromOptions()` (TLS verification at Guzzle's secure
  default). When `api_connection.settings:enable_logging` is on, it attaches a Guzzle logging
  handler stack (`createLoggingHandlerStack()` / `Middleware::log`) that writes request and response
  lines to the plugin logger channel.
