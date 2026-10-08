<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Swagger UI for OpenAPI UI renders an OpenAPI/Swagger specification as the interactive swagger-ui documentation explorer, by supplying a `swagger` plugin to the OpenAPI UI plugin system.

---

The module is a thin bridge: one plugin class, one JS behavior, one libraries file and no configuration of its own. `Drupal\openapi_ui_swagger\Plugin\openapi_ui\OpenApiUi\SwaggerUi` is annotated `@OpenApiUi(id = "swagger", label = "Swagger UI")` and implements the `build()` method of the `openapi_ui` plugin type, returning a single `<div id="swagger-ui" class="swagger-ui-wrap">` that carries the spec either as `data-openapi-ui-url` (when the render element's `#openapi_schema` resolved to a `Url` object) or as JSON in `data-openapi-ui-spec` (when it resolved to an array), plus the `openapi_ui_swagger/swagger_ui_integration` library. `js/swagger.js` then boots `SwaggerUIBundle()` on that div with the StandaloneLayout preset, the DownloadUrl plugin and a small custom plugin that hides swagger-ui's own top bar, exposing the instance as `window.ui`. The heavy lifting comes from the **swagger-ui** JS/CSS distribution, which must be installed under the docroot at `libraries/swagger-ui/dist/` — `openapi_ui_swagger.libraries.yml` references `/libraries/swagger-ui/dist/swagger-ui-bundle.js`, `swagger-ui-standalone-preset.js` and `swagger-ui.css` by absolute path, and Composer needs `composer/installers` + `mnsami/composer-custom-directory-installer` (or a manual download) to place it there. Nothing about the module is configurable: it has no settings form, no permissions, no schema and no routes. It becomes visible through the **openapi** module, which exposes `/admin/config/services/openapi/{openapi_ui}/{openapi_generator}` — e.g. `/admin/config/services/openapi/swagger/jsonapi` — guarded by openapi's `access openapi api docs` permission.

---

- Give API consumers a browsable, interactive reference for a decoupled Drupal back end.
- Render the JSON:API specification produced by `openapi_jsonapi` as Swagger UI.
- Render the core REST resource specification produced by the `openapi` module.
- Offer "Try it out" request execution against a live endpoint from the docs page.
- Pick Swagger UI instead of ReDoc simply by changing `swagger` in the docs URL.
- Embed an API explorer in a custom admin page with `'#type' => 'openapi_ui'`.
- Embed the explorer for a third-party API by passing an external spec URL.
- Feed the element a spec array built at runtime instead of a URL.
- Feed the element a callback that resolves the spec lazily per request.
- Serve versioned API docs by pointing several routes at different spec URLs.
- Publish internal API documentation behind a role that has `access openapi api docs`.
- Let front-end developers discover JSON:API resource shapes without reading Drupal code.
- Provide a QA page where testers can fire authenticated API calls by hand.
- Ship API docs with the site instead of maintaining a separate Postman/Stoplight workspace.
- Diagnose schema problems by seeing swagger-ui's parse errors directly in the browser.
- Compare two generators (jsonapi vs rest) side by side through their docs URLs.
- Pin the swagger-ui library version in composer.json so docs rendering is reproducible.
- Install swagger-ui manually into `/libraries/swagger-ui` on a non-Composer site.
- Keep the docs page in the admin theme so it inherits the site's admin styling.
- Give partner integrators a stable URL to the API contract during onboarding.
- Screenshot or PDF the rendered docs for a client deliverable.
- Use `window.ui` from the browser console to script or debug the swagger-ui instance.
- Hide swagger-ui's default top bar (URL input) so users cannot point it at another spec.
- Swap in ReDoc later without touching any code that renders the `openapi_ui` element.
