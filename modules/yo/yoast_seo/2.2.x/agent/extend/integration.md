# Integration hooks

Yoast SEO plugs into other systems via standard hooks in `yoast_seo.module` (no `*.api.php`):

- **`hook_metatags_alter()`** — if the entity's `yoast_seo` field has a custom `title` or
  `description`, those values replace the Metatag defaults for that page. This is how editor
  overrides reach the actual `<title>`/meta description.
- **`hook_entity_type_build()`** — attaches a `yoast_seo_preview_form` handler
  (`Form\AnalysisFormHandler`) to every entity type so the analysis UI can render.
- **`hook_entity_field_access()`** — access to the `yoast_seo` field requires `use yoast seo`
  or `administer yoast seo` (see [../permissions/permissions.md](../permissions/permissions.md)).
- **`hook_form_field_storage_config_edit_form_alter()`** — hides cardinality for `yoast_seo`
  fields (always single-value).
- **`hook_theme()`** — registers the snippet/score render elements
  (see [../theming/templates.md](../theming/templates.md)).

To customize scored output, alter the Metatag values or the rendered preview produced by
`yoast_seo.entity_analyser` (see [../api/services.md](../api/services.md)).
