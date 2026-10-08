<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ReDoc for OpenAPI UI (`openapi_ui_redoc`) — agent index

One plugin, two libraries, nothing else. **No config form (`configure` = null), no
permissions, no config schema, no services, no hooks, no Drush, no submodules.** Requires
`openapi_ui` (the plugin framework); the `openapi` module supplies the admin routes.

Whole module = `src/Plugin/openapi_ui/OpenApiUi/ReDoc.php` (≈45 lines),
`openapi_ui_redoc.libraries.yml` (2 libraries) and `js/redoc.js` (a 25-line shim).

- **The `redoc` plugin: `build()` output, `spec-url` vs `spec`, attributes** →
  [plugins/redoc-renderer.md](plugins/redoc-renderer.md)
- **Where ReDoc is reachable, and how to embed it yourself (render element, routes, controller)** →
  [api/embed-and-routes.md](api/embed-and-routes.md)
- **The two JS libraries, the unpinned CDN URL, and the `locale` 500 bug + fix** →
  [theming/library-and-gotchas.md](theming/library-and-gotchas.md)

Key names:

| Thing | Value |
|---|---|
| plugin type / manager | `openapi_ui` / `plugin.manager.openapi_ui.ui` (from `openapi_ui`) |
| plugin id, label | `redoc`, "ReDoc" (`@OpenApiUi` annotation) |
| class | `Drupal\openapi_ui_redoc\Plugin\openapi_ui\OpenApiUi\ReDoc` extends `Drupal\openapi_ui\Plugin\openapi_ui\OpenApiUi` |
| render element | `#type => 'openapi_ui'`, `#openapi_ui_plugin => 'redoc'`, `#openapi_schema => Url|array|string|callable|file` |
| rendered markup | `<redoc id="redoc-ui" no-auto-auth spec-url="…">` or `… spec="{json}">` |
| libraries | `openapi_ui_redoc/redoc` (CDN `redoc.min.js`), `openapi_ui_redoc/redoc_attr` (shim, deps jquery+drupal+redoc) |
| admin URL | `/admin/config/services/openapi/redoc/{generator}` (route `openapi.documentation`, permission `access openapi api docs`) |

**Biggest gotcha:** the CDN JS is declared without `type: external`, so Drupal treats it as a
local file — with core's `locale` module enabled every ReDoc page throws
*"Only local files should be passed to _locale_parse_js_file()."* and returns **HTTP 500**.
Fix in [theming/library-and-gotchas.md](theming/library-and-gotchas.md).
