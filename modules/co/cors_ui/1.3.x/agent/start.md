# CORS UI — agent index

Admin UI for Drupal core's CORS middleware (the `cors.config` container parameter normally set in
`services.yml`). Stores settings in config and rebuilds the container so they take effect. Single
permission `administer cors` (`restrict access: true`). No Drush.

- **The form, config object, every key, origin validation, and how it overrides `services.yml`** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config object: `cors_ui.configuration` (`enabled`, `allowedOrigins`, `allowedMethods`,
  `allowedHeaders`, `exposedHeaders`, `supportsCredentials`, `maxAge`). Config schema shipped.
- Configure route: `cors_ui.config_form` → `/admin/config/services/cors` (`administer cors`).
- `CorsUiServiceProvider` + `CorsUiCompilerPass` push the config into the container `cors.config`
  parameter (overriding `services.yml`); `hook_install` seeds config from the current parameter.
- A `ConfigSubscriber` rebuilds the container + invalidates `http_response` when the config changes.
