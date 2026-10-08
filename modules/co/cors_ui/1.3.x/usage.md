CORS UI provides an admin form for Drupal core's CORS (Cross-Origin Resource Sharing) middleware, which is otherwise only configurable by editing the `cors.config` parameter in `services.yml`. It turns those settings into editable config and rebuilds the container so they take effect.

---

Drupal core ships a CORS middleware whose behavior is controlled by the `cors.config` service-container parameter (normally hand-edited in `sites/default/services.yml`). CORS UI exposes the same options at `/admin/config/services/cors` (permission `administer cors`, `restrict access: true`) and stores them in the `cors_ui.configuration` config object. A service provider + compiler pass (`CorsUiServiceProvider`/`CorsUiCompilerPass`) feed that config back into the container's `cors.config` parameter, so the saved values override `services.yml`. On install, `hook_install` seeds `cors_ui.configuration` from the site's current `cors.config` parameter (normalized to the config schema), so enabling the module does not change existing behavior. Because CORS is a container-level parameter, a `ConfigSubscriber` marks the container for rebuild (and invalidates the `http_response` cache tag) whenever `cors_ui.configuration` changes, on kernel destruct. The form edits `enabled`, `allowedOrigins`, `allowedMethods`, `allowedHeaders`, `exposedHeaders`, `supportsCredentials`, and `maxAge`; origins are validated (each must be a valid scheme+host+port with no path/query/fragment, and the `*` wildcard cannot be combined with explicit origins). Textareas take one value per line, or `*` to allow all. There is no Drush command; the module ships config schema (`cors_ui.configuration`) for the stored settings.

---

- Turn on Drupal core's CORS middleware from the admin UI instead of editing `services.yml`.
- Configure which origins may make cross-origin requests to the site (allowed origins).
- Allow every origin with a `*` wildcard (for public read-only APIs).
- Restrict cross-origin access to a specific list of trusted front-end origins.
- Choose which HTTP methods are permitted cross-origin (GET, POST, etc.).
- Whitelist request headers browsers may send on cross-origin requests (allowed headers).
- Expose specific response headers to cross-origin JavaScript (exposed headers).
- Enable credentialed cross-origin requests (cookies/auth) via "Supports credentials".
- Set the preflight cache lifetime with `Access-Control-Max-Age` (maxAge).
- Enable CORS for a decoupled/headless front end (React, Vue, Next.js) consuming JSON:API or REST.
- Adjust CORS for third-party widgets or embeds that call the site's API.
- Keep CORS configuration in Drupal config (exportable, deployable) rather than in `services.yml`.
- Seed the module's config from the site's existing `cors.config` on install without behavior changes.
- Have CORS setting changes take effect immediately via automatic container rebuild.
- Validate origin values (scheme + host + port only) before saving to avoid malformed CORS config.
- Prevent the invalid combination of the `*` wildcard alongside explicit origins.
- Toggle CORS on or off globally with a single checkbox.
- Give site builders control of CORS without shell/file access to the server.
- Review the current CORS policy in one place at `/admin/config/services/cors`.
- Manage CORS for multiple environments through config split / overrides.
