# Content API (lightning_api) — agent index

Glue module that configures a JSON:API + OAuth2 content API for decoupled Drupal. Its own
surface is two config toggles plus an OAuth key-generation form; the real work is done by
`jsonapi` (+ optional `simple_oauth`, `openapi_jsonapi`, ReDoc/Swagger). Depends on `jsonapi`
and `path_alias`. No plugins, no Drush, no own permissions.

- **The two settings toggles + the OAuth key-generation form (routes, permissions)** →
  [configure/settings-and-keys.md](configure/settings-and-keys.md)
- **What enabling does: operation links, hooks, RequestSubscriber, `/api-docs`, entity JSON helper** →
  [api/integration.md](api/integration.md)

Key facts:
- Config `lightning_api.settings`: `entity_json` (bool — "View JSON" operation link on entities),
  `bundle_docs` (bool — "View API Documentation" link on bundles). Both default `false`.
- Settings form `/admin/config/system/lightning/api` (route `lightning_api.settings`, permission
  `administer site configuration`).
- OAuth keys form `/admin/config/system/lightning/api/keys` (route `lightning_api.generate_keys`,
  permission `administer simple_oauth entities`, requires the `simple_oauth` module) — generates a
  key pair and writes the paths into `simple_oauth.settings`.
- On install, creates a `/api-docs` alias when `openapi_ui_redoc` + `openapi_jsonapi` are present.
