A developer helper module that lets custom Drupal modules connect to external REST APIs through a plugin architecture with per-environment base URLs.

---

API Connection provides a `RestApiConnection` plugin type so each external REST API / web service integration can be declared as a plugin in a custom module. A plugin declares an id, a label, per-environment base URLs (`dev` / `test` / `live`) and an `activated` flag via a PHP attribute or annotation, and extends `RestApiConnectionBase`, which wraps Drupal's Guzzle `http_client_factory`. The base class exposes one method, `sendRequest($endpoint, $method, $options, $return_response_object)`, that picks the base URL for the site's currently selected environment, JSON-encodes a request body, sets a default `Content-Type: application/json` header, sends the request, logs errors, and JSON-decodes the response. A site-wide settings form (`/admin/config/services/api_connection`) selects the active environment and toggles request/response logging to the Drupal logger. The available environments are provided by the `api_connection.environment` service and can be extended through the `ApiConnectionEnvironmentEvent`. The module itself has no UI-facing feature for end users; it is infrastructure consumed by other modules, and it ships an `api_connection_example` submodule that demonstrates a working ReqRes.in integration.

---

- Give a custom module a clean, reusable client for talking to a third-party REST API without hand-rolling Guzzle setup in every module.
- Declare a `RestApiConnection` plugin with a PHP attribute (`#[RestApiConnection(...)]`) that carries the API's id, label and per-environment base URLs.
- Point the same integration at different base URLs for development, testing/staging and live environments without code changes.
- Switch the whole site between `dev`, `test` and `live` API endpoints from a single admin settings form.
- Turn request/response logging on or off globally to inspect what a plugin is sending to and receiving from an external API during development.
- Send a GET request to fetch a remote resource (e.g. `$this->sendRequest("api/users/{$id}", "GET")`) and get the decoded JSON body back as a PHP array.
- Send a POST/PUT/PATCH request with a PHP array body that is automatically JSON-encoded before sending.
- Retrieve the raw PSR-7 response object instead of the decoded body by passing `$return_response_object = TRUE` (for reading headers, status codes, or streaming bodies).
- Deactivate an API integration site-wide by setting `activated = FALSE` on the plugin, so `sendRequest()` short-circuits without making a call.
- Add custom domain methods (e.g. `getUser()`, `login()`, `createOrder()`) on your plugin class that wrap `sendRequest()` with API-specific logic.
- Store API-specific settings (keys, tokens, options) in plugin configuration by overriding `defaultConfiguration()`, `buildConfigurationForm()` and `submitConfigurationForm()`.
- Use `config_ignore` or `config_split` on `api_connection.settings` so each hosting environment keeps its own environment/logging values.
- Throw and catch a `RestApiEnvironmentUrlException` when a plugin has no base URL configured for the currently selected environment.
- Add extra environments (e.g. `qa`, `sandbox`, `preprod`) by subscribing to the `api_connection.environment` event and calling `addEnvironment()`.
- Build a service-facade controller that instantiates a connection plugin via `plugin.manager.rest_api_connection` and renders remote data on a page.
- Centralize multiple third-party API integrations (payment, CRM, shipping, auth) as separate plugins that all share the same environment switch and logging toggle.
- Alter or extend discovered connection plugin definitions from another module via the `api_connection_rest_api_connection_info` alter hook.
- Learn the pattern from the bundled `api_connection_example` submodule, which connects to ReqRes.in and exposes example login and user-detail routes.
- Restrict who can change the environment / logging settings with the `administer api_connection settings` permission.
