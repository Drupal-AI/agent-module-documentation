HTTP Client Manager lets you describe a remote REST/HTTP API declaratively (as a Guzzle service description) and call its operations through managed, reusable Guzzle client instances — without hand-writing HTTP request code for each endpoint.

---

You register an API by adding a `MODULE.http_services_api.yml` file that names a service API id, a human title, an `api_path` pointing at a Guzzle service description (JSON, YAML, or PHP) and a `config` block (at least a `base_uri`, plus optional `timeout`, `auth`, etc.). The service description lists **operations** (commands) with their HTTP method, URI, parameters and their locations (uri/query/json/header/…) and response models. At runtime you get a client from the `http_client_manager.factory` service (`->get('service_api_id')`, returning an `HttpClient`) and call an operation with `$client->call('CommandName', $params)`, or define a lazy/abstract service that extends `http_client_manager.client_base`. API definitions can be overridden per-environment from `settings.php` (`$settings['http_services_api'][...]`) or from the module's own `overrides` config when `enable_overriding_service_definitions` is on, and values support tokens. Reusable, pre-filled calls can be saved as **HTTP Config Request** config entities (`http_config_request`: id, label, service_api, command_name, parameters) and executed with `$request->execute()`. The module adds a preview/admin UI at `/admin/config/services/http-client-manager` (permission `administer http_client_manager`), plugin **Actions** to run a command or a pre-configured request, events fired around each call (`HttpClientEvents`), a request-location plugin type, an API-wrapper pattern for building a typed PHP facade over an API, and a Drush code generator (`drush generate http_client_manager:service`) to scaffold a new service. It ships with an example submodule targeting the JSONPlaceholder API.

---

- Consume a third-party REST API (CRM, payment, weather, etc.) via declarative operations instead of raw Guzzle code.
- Define an API once in a `*.http_services_api.yml` file and call it from anywhere by service id.
- Point one logical API at different base URIs per environment (dev/stage/prod) via `settings.php` overrides.
- Call an operation with `\Drupal::service('http_client_manager.factory')->get('my_api')->call('GetUser', ['id' => 5])`.
- Expose an API as its own injectable service by extending `http_client_manager.client_base`.
- Store frequently-used, pre-filled requests as `http_config_request` config entities and run them with `->execute()`.
- Manage and preview configured requests from the admin UI at /admin/config/services/http-client-manager.
- Blacklist or whitelist which commands of an API are available in a given environment.
- Insert Drupal tokens (e.g. `[current-user:uid]`) into request parameters, resolved at call time.
- Trigger an HTTP call as a Views/VBO or ECA Action using the `http_client_manager_command` or `http_client_manager_preconfigured_request` action plugins.
- React to every outgoing call by subscribing to the pre-execute / handler-stack events (`HttpClientEvents`).
- Add custom Guzzle request-location handling by implementing a `http_client_manager_request_location` plugin.
- Build a typed PHP facade (API wrapper) with convenience methods like `findPosts()` over the raw commands.
- Scaffold a new service description quickly with `drush generate http_client_manager:service`.
- Configure per-request Guzzle options (timeout, connect_timeout, auth, headers) in the API `config` block.
- Send JSON, form params, multipart, XML or query data by declaring the parameter `location` in the description.
- Centralise API credentials and base URIs so multiple modules reuse one configured client.
- Cache or memoize API results using the module's dedicated cache bins.
- Migrate ad-hoc `\Drupal::httpClient()` calls to a single described, testable API surface.
- Mock or swap an API in tests by overriding its definition to point at a stub base URI.
- Ship a reusable integration module that declares its API and pre-configured requests as config.
- Version and deploy configured requests as exported configuration.
- Give site builders a UI to inspect available API commands and their parameters before wiring code.
