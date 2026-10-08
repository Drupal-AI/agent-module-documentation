Swagger UI info renders a single, site-wide Swagger/OpenAPI specification as an interactive Swagger UI page at `/swagger_info`.

---

Swagger UI info is a small companion to the Swagger UI Field Formatter module (`swagger_ui_formatter`), which provides the bundled Swagger UI JavaScript library. Rather than attaching Swagger UI to an entity field, this module exposes one standalone page, `/swagger_info` (route `swagger_ui_info.swagger_info`, title "API info"), that renders whatever OpenAPI/Swagger JSON file an administrator has selected. The spec is chosen on the settings form at `/admin/config/services/swagger_ui_info` (route `swagger_ui_info.admin_settings`), where you either upload a `.json` file (stored as a managed file under `public://swagger_files`) or type an absolute path/URL to an existing JSON file. The chosen location is saved in Drupal's State API (`swagger_ui_file` and `swagger_ui_file_path`) rather than in exportable configuration. The controller (`SwaggerUiInfoController::infoPage`) passes that file URL to the Swagger UI bundle via `drupalSettings`, along with a REST CSRF token (sent as `X-CSRF-Token` on "Try it out" requests) and an OAuth2 redirect URL. Both the display page and the settings form are gated by dedicated permissions marked `restrict access: TRUE`. The module ships an example spec (`accets/swagger/swagger_cart_example.json`) so you can preview the page immediately.

---

- Publish a single browsable API reference for your site's REST/JSON API at `/swagger_info`.
- Give internal or partner developers an interactive "Try it out" console for your API.
- Upload an OpenAPI/Swagger `2.0` or OpenAPI `3.x` JSON file and render it without writing any theme code.
- Point the page at an already-hosted spec by entering its absolute path or URL instead of uploading.
- Preview the module immediately using the bundled `swagger_cart_example.json` example spec.
- Document a Drupal Commerce Cart API (the maintainer's demo) or any other JSON:API/REST surface.
- Provide a stable, permission-gated URL you can link from your developer portal or README.
- Restrict who can see the API docs by granting the "Access swagger information" permission to specific roles.
- Restrict who can change which spec is shown by granting "Access swagger ui admin settings" only to trusted admins.
- Let authenticated developers execute live requests against your API, with Drupal's REST CSRF token attached automatically.
- Support OAuth2 flows in the "Authorize" dialog via the generated `oauth2-redirect.html` redirect URL.
- Swap the displayed spec at any time by re-uploading or re-entering a path on the settings form.
- Keep the API reference in sync with a file you regenerate in your build pipeline (point the path at that file).
- Offer a lightweight alternative to attaching Swagger UI to a field when you only need one global docs page.
- Expand all operations by default (the page uses `docExpansion: 'list'`) for quick scanning of endpoints.
- Show all standard HTTP verbs (GET, PUT, POST, DELETE, OPTIONS, HEAD, PATCH) as executable in the UI.
- Add an "API info" item under Administration → Configuration → Web services for editors to find the settings.
- Stage API documentation on a non-production site for review before publishing changes.
- Serve the same spec to multiple audiences by controlling role access rather than duplicating pages.
- Reuse the Swagger UI library version installed for `swagger_ui_formatter` so you manage the library in one place.
