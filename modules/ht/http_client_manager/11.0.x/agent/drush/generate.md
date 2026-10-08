# Drush: scaffold a service

The module provides a Drupal Code Generator plugin (not a classic Drush command), discovered by
`drush generate`:

```bash
drush generate http_client_manager:service
# alias:
drush generate http-service
```

Generator id `http_client_manager:service` (`src/Drush/Generators/ServiceGenerator.php`,
type MODULE_COMPONENT). It interactively asks for: machine name, name, description, method
(get/post), base URI, an operation name, path, and summary, then writes three files into the
target module:

- `{machine_name}.http_services_api.yml` — the service API declaration.
- `src/api/{id}.yml` — the Guzzle service description (imports the resources file).
- `src/api/resources/{id}.yml` — the operations/models resource file.

Use it to bootstrap a new described API instead of hand-writing the YAML. After generating, enable
the module (or clear cache) so `HttpServiceApiHandler` discovers the new `*.http_services_api.yml`.
