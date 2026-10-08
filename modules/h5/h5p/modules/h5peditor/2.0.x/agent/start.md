# H5P Editor — agent index

Adds the in-browser H5P authoring widget (`h5p_editor`) and the editor's AJAX endpoints, on top of
the base `h5p` module. No config form; you enable it by choosing the widget on an H5P field.

- **Using the `h5p_editor` widget, the AJAX routes, and the permissions** →
  [api/editor.md](api/editor.md)

Key facts:
- Field widget `h5p_editor` (use on an `h5p`-type field via Manage form display; alternative to `h5p_upload`).
- Permissions: `access h5p editor` (use the widget), `install recommended h5p libraries` (Hub installs).
- AJAX controller `H5PEditorAJAXController` on `/h5peditor/{token}/{content_id}/…`
  (libraries, content-type-cache, library-install, library-upload, files, translations, filter).
- Depends on `h5p`; no own config, config schema, or Drush.
