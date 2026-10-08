Swagger UI Field Formatter renders a referenced OpenAPI/Swagger document (JSON or YAML) as an interactive [Swagger UI](https://swagger.io/tools/swagger-ui/) API-docs widget, via field formatters for **File** fields (`swagger_ui_file`) and **Link** fields (`swagger_ui_link`).

---

The module provides two field formatters that share a common trait (`SwaggerUIFormatterTrait`): `swagger_ui_file` for `file` fields and `swagger_ui_link` for `link` fields. You pick one on an entity's **Manage display** tab; for each field item it resolves a web-accessible URL to the spec (an absolute file URL for file fields, or the link URL for link fields) and hands it to the browser via `drupalSettings.swaggerUIFormatter[<field>-<delta>]`, where `js/swagger-ui-formatter.js` boots Swagger UI. Per-formatter settings cover the spec **validator** (none / swagger.io default / custom URL), **doc expansion**, **top bar** visibility, **sort tags by name**, and which HTTP methods get the **"Try it out"** feature (`supported_submit_methods`); a config schema (`field.formatter.settings.swagger_ui_file` / `_link`) backs them. The Swagger UI JavaScript library itself is **not bundled** — it is located by a swappable *library discovery* service with two implementations: `…FromDownloadedArtifact` (default; a prebuilt dist under `[web root]/libraries/swagger-ui`, e.g. installed via Composer/asset-packagist or scaffold) and `…FromNodeManagedBundledAssets` (the npm `swagger-ui-dist` bundled with the module), switched by aliasing `swagger_ui_formatter.swagger_ui_library_discovery` in `services.yml`. `hook_requirements` reports the detected library path/version (and warns about a missing `oauth2-redirect.js` for OAuth2 flows on lib ≥ 5.29.0), and `hook_swagger_ui_library_directory_alter` lets a module override the resolved directory. The module registers the library dynamically in `hook_library_info_build` and exposes no config page, permissions, or Drush commands.

---

- Publish an interactive API reference by uploading an OpenAPI/Swagger `.json`/`.yaml` file to a File field and formatting it with Swagger UI.
- Render API docs from a remote spec URL held in a Link field (`swagger_ui_link`).
- Give consumers a live "Try it out" console for selected HTTP methods (GET/POST/PUT/…).
- Restrict "Try it out" to safe methods (e.g. only GET) by trimming `supported_submit_methods`.
- Disable "Try it out" entirely by selecting no submit methods (docs still display).
- Show or hide the Swagger UI top bar (spec URL/explorer) per display.
- Control initial expansion (none / list of tags / full operations) via `doc_expansion`.
- Sort operation tags alphabetically with `sort_tags_by_name`.
- Validate the spec against swagger.io's online validator, a custom validator, or none.
- Host versioned API docs as nodes/media and switch specs without code changes.
- Provide developer-portal API pages on a Drupal site.
- Serve the Swagger UI assets from a self-hosted `libraries/swagger-ui` copy (default discovery).
- Use the module-bundled npm `swagger-ui-dist` assets instead, by aliasing the discovery service to `.bundled`.
- Override the Swagger UI library directory for a custom deployment via `hook_swagger_ui_library_directory_alter`.
- Diagnose library install problems from the status report (`hook_requirements` shows path + version).
- Enable OAuth2 authorization flows in Swagger UI (ensure `oauth2-redirect.js`/`.html` is present).
- Render multiple specs on one entity via a multi-value file/link field.
- Expose internal microservice OpenAPI specs to developers behind an access-controlled node.
- Combine with a text/entity access module to gate who can view or "try" the API.
- Theme the widget by overriding the `swagger_ui_field_item` template.
