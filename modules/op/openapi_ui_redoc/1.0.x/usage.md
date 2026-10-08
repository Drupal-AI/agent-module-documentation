<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ReDoc for OpenAPI UI supplies a single `openapi_ui` renderer plugin (id `redoc`) that displays an OpenAPI/Swagger specification with the ReDoc JavaScript library, giving Drupal a three-panel, read-only API reference page.

---

The module is a thin bridge: one plugin class (`Drupal\openapi_ui_redoc\Plugin\openapi_ui\OpenApiUi\ReDoc`), one JS shim and one `*.libraries.yml`. It has no settings form, no `configure` route, no permissions, no config schema, no services, no hooks and no Drush commands; its only dependency is the `openapi_ui` framework module, which defines the `openapi_ui` plugin type and the `openapi_ui` render element. `ReDoc::build()` returns an `html_tag` render array producing a `<redoc id="redoc-ui" no-auto-auth>` custom element and attaches the `openapi_ui_redoc/redoc` library. The `#openapi_schema` supplied on the render element decides how the spec reaches the library: a `Drupal\Core\Url` becomes a `spec-url` attribute that ReDoc fetches and auto-initialises, while a PHP array is JSON-encoded into a `spec` attribute and the extra `openapi_ui_redoc/redoc_attr` library is attached — a small jQuery shim (`js/redoc.js`) that on document ready calls `Redoc.init(JSON.parse(spec))` because ReDoc will not self-initialise without `spec-url`. The ReDoc library itself is **not** bundled: `openapi_ui_redoc.libraries.yml` points at `https://rebilly.github.io/ReDoc/releases/latest/redoc.min.js`, an unpinned third-party CDN URL that is (incorrectly) declared without `type: external`. In practice you never instantiate the plugin yourself — the `openapi` module's route `openapi.documentation` (`/admin/config/services/openapi/{openapi_ui}/{openapi_generator}`, permission `access openapi api docs`) hands `redoc` to the render element, so `/admin/config/services/openapi/redoc/jsonapi` renders the JSON:API spec with ReDoc, and the *OpenAPI Resources* listing at `/admin/config/services/openapi` grows an "Explore with ReDoc" link as soon as this module is enabled.

---

- Publish a browsable API reference for a decoupled Drupal site's JSON:API endpoints.
- Add an "Explore with ReDoc" link to `/admin/config/services/openapi` for every generator.
- Render the core REST spec (via `openapi_rest`) as a three-panel ReDoc page.
- Give front-end developers a read-only, print-friendly API reference instead of Swagger UI's try-it console.
- Embed an API reference into a custom admin page with `#type => 'openapi_ui'` and `#openapi_ui_plugin => 'redoc'`.
- Document a third-party API by pointing `#openapi_schema` at an external spec URL.
- Render a spec that is generated on the fly in PHP by passing it as an array.
- Build a spec lazily with a callback so it is only computed when the page is rendered.
- Serve API docs from a private file entity, letting `openapi_ui` convert it to a private URL.
- Offer both Swagger UI and ReDoc side by side by enabling `openapi_ui_swagger` too.
- Route-link straight to `/admin/config/services/openapi/redoc/jsonapi` from a custom menu item.
- Restrict who can read the API docs with the `access openapi api docs` permission.
- Screenshot or PDF-print an API reference for a client deliverable.
- Provide onboarding documentation for a headless Drupal project's API consumers.
- Compare a generated spec against the published one by viewing both in ReDoc.
- Pin the ReDoc library to a known version with `hook_library_info_alter()` instead of `latest`.
- Self-host `redoc.min.js` (air-gapped or CSP-restricted sites) by altering the library definition.
- Fix the missing `type: external` declaration so sites with core's `locale` module stop erroring.
- Swap the whole renderer for a fork by implementing `hook_openapi_ui_alter()`.
- Register ReDoc as the default explorer in a custom controller returning the render element.
- Show API docs for a specific generator only, by hardcoding the generator id in a route link.
- Validate that a hand-written OpenAPI document parses by loading it in ReDoc.
- Use ReDoc's `no-auto-auth` behaviour to hide the auth prompt on a public docs page.
- Give QA a stable URL for the current API contract in each environment.
