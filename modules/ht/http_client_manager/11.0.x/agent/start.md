# HTTP Client Manager — agent index

Describe a remote HTTP/REST API as a **Guzzle service description** and call its operations
through managed Guzzle clients. Configure route: `http_client_manager.preview` →
`/admin/config/services/http-client-manager` (permission `administer http_client_manager`).
Ships an example submodule (`http_client_manager_example`) targeting JSONPlaceholder.

- **Call an API from code; define a service API (`*.http_services_api.yml` + description); the
  factory/client services; settings.php & config overrides** → [api/clients.md](api/clients.md)
- **HTTP Config Request config entities (pre-configured calls) + the two Action plugins + settings** →
  [configure/config-requests.md](configure/config-requests.md)
- **Plugin types it defines/uses: request locations & API wrappers** → [plugins/plugins.md](plugins/plugins.md)
- **Drush service generator** → [drush/generate.md](drush/generate.md)

Key facts:
- Get a client: `\Drupal::service('http_client_manager.factory')->get('<service_api>')` → `HttpClient`;
  then `->call('<CommandName>', [params])`.
- A service API is declared in `MODULE.http_services_api.yml` (`title`, `api_path`, `config.base_uri`)
  plus a Guzzle description file (operations/models) referenced by `api_path`.
- Override a definition from `settings.php`: `$settings['http_services_api']['<id>'] = [...]`
  (overridable keys: `title`, `api_path`, `config`, `commands`).
- Settings config `http_client_manager.settings`: `enable_overriding_service_definitions` (int), `overrides`.
- Config entity `http_config_request` (`id`, `label`, `service_api`, `command_name`, `parameters`);
  run one with `HttpConfigRequest::load('<id>')->execute()`.
- Plugin type defined: `http_client_manager_request_location`. Permission: `administer http_client_manager`.
