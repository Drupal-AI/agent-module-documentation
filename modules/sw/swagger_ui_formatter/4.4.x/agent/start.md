# Swagger UI Field Formatter — agent index

Renders a referenced OpenAPI/Swagger spec (JSON/YAML) as an interactive Swagger UI widget.
Two field formatters — `swagger_ui_file` (file fields) and `swagger_ui_link` (link fields) —
configured per field on **Manage display**. No config page (`configure` null), no permissions,
no Drush. Depends on core `file`. The Swagger UI JS library is external and located by a
swappable discovery service.

- **The two formatters, every setting, storage, and how the spec URL reaches the browser** →
  [configure/formatter.md](configure/formatter.md)
- **Library discovery (downloaded vs bundled), how to install/switch the Swagger UI assets,
  the `*_alter` hook, and status/requirements** → [api/library-discovery.md](api/library-discovery.md)

Key facts:
- Formatter ids `swagger_ui_file` (field type `file`) and `swagger_ui_link` (field type
  `link`); both use `SwaggerUIFormatterTrait`. Formatter label is "Swagger UI".
- Settings: `validator`, `validator_url`, `doc_expansion`, `show_top_bar`,
  `sort_tags_by_name`, `supported_submit_methods` (schema
  `field.formatter.settings.swagger_ui_file` / `_link`).
- Spec URL + settings are passed as `drupalSettings.swaggerUIFormatter[<field>-<delta>]`;
  `js/swagger-ui-formatter.js` boots Swagger UI.
- Library not bundled: service `swagger_ui_formatter.swagger_ui_library_discovery`
  (alias → `.downloaded` by default; switch to `.bundled` in `services.yml`).
- Theme hook `swagger_ui_field_item` (template `templates/swagger-ui-field-item.html.twig`).
