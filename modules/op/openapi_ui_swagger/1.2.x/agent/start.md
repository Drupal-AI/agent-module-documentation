<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Swagger UI for OpenAPI UI (openapi_ui_swagger) — agent index

One `@OpenApiUi(id = "swagger")` plugin for the `openapi_ui` plugin type, plus the JS glue
that boots swagger-ui. **No settings form, no routes, no permissions, no config schema, no
Drush.** Depends on `openapi_ui`; the browsable docs pages come from the separate `openapi`
module.

- **Install the swagger-ui library, find the docs URL, who may see it** →
  [configure/install-and-view.md](configure/install-and-view.md)
- **Render Swagger UI yourself (`#type => 'openapi_ui'`), plugin internals, JS behavior** →
  [api/render-element.md](api/render-element.md)

Key facts:

- Plugin id is **`swagger`** (label "Swagger UI"), class
  `Drupal\openapi_ui_swagger\Plugin\openapi_ui\OpenApiUi\SwaggerUi`, discovered from
  `src/Plugin/openapi_ui/OpenApiUi/`.
- Library files are referenced by **absolute** path: `/libraries/swagger-ui/dist/…` — the
  distribution must sit at `<docroot>/libraries/swagger-ui`.
- Docs page (from `openapi`): `/admin/config/services/openapi/swagger/{generator}`, e.g.
  `/admin/config/services/openapi/swagger/jsonapi`; permission `access openapi api docs`.
- `build()` emits `<div id="swagger-ui" class="swagger-ui-wrap" data-openapi-ui-url="…">`
  (or `data-openapi-ui-spec="{json}"`).
