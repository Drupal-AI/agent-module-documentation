# H5P — agent index

Adds interactive HTML5 content to Drupal via an `h5p` field type backed by an `h5p_content`
entity, plus library management and a global settings form. Depends on `field` + `file` and the
`h5p/h5p-core` / `h5p/h5p-editor` PHP libraries.

- **Global settings (`h5p.settings`), display options, storage, the admin form** →
  [configure/settings.md](configure/settings.md)
- **The `h5p` field type / widget / formatter and the `h5p_content` entity** →
  [api/field-and-entity.md](api/field-and-entity.md)
- **Hooks to alter semantics, params, styles, scripts, library-installed** →
  [hooks/hooks.md](hooks/hooks.md)
- **The permission set (libraries, results, copy/download/embed)** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Field type `h5p` (label "Interactive Content – H5P"), default widget `h5p_upload`, formatter `h5p_default`.
  With the **h5peditor** submodule you also get the authoring widget `h5p_editor`.
- Content entity `h5p_content` (base_table `h5p_content`): `library_id`, `parameters`, `filtered_parameters`, `disabled_features`.
- Config object `h5p.settings` at `/admin/config/system/h5p` (route `h5p.admin.config.system.h5p`,
  permission `administer site configuration`); library admin at `/admin/content/h5p` (permission `administer h5p libraries`).
- No Drush commands. Submodule `h5peditor` (nested) adds in-browser authoring + Hub install AJAX.
