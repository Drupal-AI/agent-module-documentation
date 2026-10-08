# ckeditor5_template — agent start

Adds a **Template** button to CKEditor 5 that inserts predefined HTML content chosen from a
picker. Ships one configurable CKEditor 5 plugin — Drupal plugin id
`ckeditor5_template_template` (JS plugin `template.Template`) — that registers the `template`
toolbar item. Depends on core `editor` / CKEditor 5. Configured **per text format** on the
CKEditor 5 toolbar screen; no site-wide settings form and no `configure` route. All state
lives on the per-format `editor` config entity under
`settings.plugins.ckeditor5_template_template`.

- Enable the button per format, the plugin config keys, the JSON template file, drush/config recipe → [configure/ckeditor5_template.md](configure/ckeditor5_template.md)
- The `.ckeditor5.yml` plugin definition, toolbar item, config schema, and template JSON shape → [plugins/ckeditor5_template.md](plugins/ckeditor5_template.md)
