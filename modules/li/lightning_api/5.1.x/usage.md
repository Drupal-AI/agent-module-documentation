Content API (machine name `lightning_api`, from the Lightning distribution) is a thin glue module that sets up a standards-based content API for progressive/decoupled Drupal, tying together core JSON:API and (optionally) Simple OAuth and OpenAPI so other applications can read the site's content.

---

The module itself adds only a small settings surface and some convenience wiring; the heavy lifting is done by its dependencies. Its own config object `lightning_api.settings` has two boolean toggles: **`entity_json`** exposes a "View JSON" operation link on content entities (linking to the entity's JSON:API URL), and **`bundle_docs`** exposes a "View API Documentation" operation link on bundle config entities. The settings form is at `/admin/config/system/lightning/api` (route `lightning_api.settings`, permission `administer site configuration`). A second form at `/admin/config/system/lightning/api/keys` (route `lightning_api.generate_keys`, permission `administer simple_oauth entities`, only available when Simple OAuth is installed) generates an OAuth2 public/private key pair and stores the key paths in `simple_oauth.settings` for the OAuth authorization flow. On install, if `openapi_ui_redoc` and `openapi_jsonapi` are present, it creates a friendly `/api-docs` path alias to the generated API documentation. Runtime hooks rebuild routes when `entity_json` is on and a bundle is created, fix the core "content" view so JSON operations don't break, and a `RequestSubscriber` adjusts API requests. It requires `jsonapi` and `path_alias`; Simple OAuth, OpenAPI JSON:API, and a ReDoc/Swagger UI are optional integrations.

---

- Stand up a JSON:API-based content API for a decoupled front end with sensible defaults.
- Add a "View JSON" link to node/entity operations so editors can preview an entity's JSON:API output.
- Add a "View API Documentation" link to content types and other bundles.
- Generate an OAuth2 key pair for token-based API authentication via Simple OAuth.
- Configure the OAuth authorization flow keys without hand-editing `simple_oauth.settings`.
- Publish browsable API docs at `/api-docs` using ReDoc + OpenAPI JSON:API.
- Enable progressive decoupling: keep Drupal's front end but expose content over JSON:API.
- Let a mobile app or SPA ingest content through a standard, authenticated API.
- Toggle the "View JSON" operation link site-wide with the `entity_json` setting.
- Toggle the "View API Documentation" operation link with the `bundle_docs` setting.
- Restrict who can configure the API with the `administer site configuration` permission.
- Restrict OAuth key generation to users with `administer simple_oauth entities`.
- Provide a consistent decoupling baseline across environments by exporting `lightning_api.settings`.
- Integrate with OpenAPI tooling (Swagger UI or ReDoc) for interactive API exploration.
- Preview an entity's JSON:API URL directly from its operations dropdown.
- Bootstrap headless Drupal projects that follow the JSON:API + OAuth2 standards.
- Avoid breaking JSON:API operations in the default content view (handled automatically).
- Combine with `consumers` and Simple OAuth to issue scoped access tokens to API clients.
- Give API documentation a memorable URL alias for developers.
- Keep the content-API configuration in code for repeatable deployments.
