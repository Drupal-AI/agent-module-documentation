<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Swagger UI info (swagger_ui_info) — agent index

Renders one site-wide OpenAPI/Swagger JSON spec as an interactive **Swagger UI** page at
**`/swagger_info`**. An admin picks the spec on a settings form; the choice is stored in the
**State API** (not config). Depends on **`swagger_ui_formatter`** (which supplies the bundled
Swagger UI JS library). Core `^11 || ^12`. License GPL-2.0-or-later. Version 2.0.5 (branch
2.0.x — a major bump from 8.x-1.x). No config entities, no plugins, no Drush, no submodules.

- **Choosing the spec (upload or path) and the settings form** →
  [config/settings.md](config/settings.md)
- **The `/swagger_info` display route, how the spec is loaded into Swagger UI, permissions** →
  [api/display.md](api/display.md)

## What it actually is

- One controller: `SwaggerUiInfoController::infoPage()` in
  `src/Controller/SwaggerUiInfoController.php` — the `/swagger_info` page.
- One form: `SwaggerUiSettingsForm` in `src/Form/SwaggerUiSettingsForm.php` — the settings page
  at `/admin/config/services/swagger_ui_info`.
- Two routes (`swagger_ui_info.routing.yml`): `swagger_ui_info.admin_settings` (settings form,
  perm `administer swagger ui settings`) and `swagger_ui_info.swagger_info` (display, perm
  `access swagger ui information`). Both permissions are `restrict access: TRUE`
  (`swagger_ui_info.permissions.yml`).
- One theme hook `swagger_ui_info` (`swagger_ui_info_theme()` in `.module`,
  template `templates/swagger-ui-info.html.twig`) — emits `<div id="swagger-ui-{{ name }}">`.
- One JS asset library `swagger_ui_info/swagger_ui_integration`
  (`swagger_ui_info.libraries.yml` → `accets/js/swagger-ui-formatter.js`) that instantiates
  `SwaggerUIBundle` against the configured spec URL. (Note the misspelled `accets/` directory.)
- State keys used: `swagger_ui_file` (uploaded file id, or NULL) and `swagger_ui_file_path`
  (absolute URL/path of the spec). No `config/install` or `config/schema` in this version.
- Ships an example spec: `accets/swagger/swagger_cart_example.json`.
