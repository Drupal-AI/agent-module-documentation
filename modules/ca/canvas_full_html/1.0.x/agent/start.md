# Canvas Full HTML (canvas_full_html) — agent index

Replaces Drupal Canvas's restricted rich-text formats (`canvas_html_block`,
`canvas_html_inline`) with a dedicated unrestricted **`canvas_full_html`** text format in
Canvas / Experience Builder WYSIWYG component fields. **One boolean setting**, no permissions,
no Drush, no plugin types. Depends on `canvas`, `ckeditor5`, `editor`, `filter`.

- **The single setting, the config entities it installs, the admin route, and how to
  edit the Canvas toolbar / toggle the feature** → [configure/settings.md](configure/settings.md)

Key facts:
- `configure` route = `canvas_full_html.settings` at `/admin/config/content/canvas-full-html`
  (permission `administer site configuration`). Form: `Drupal\canvas_full_html\Form\SettingsForm`.
- Only stored config: `canvas_full_html.settings:enabled` (boolean, default **TRUE**).
- On install it ships three config entities: `filter.format.canvas_full_html`,
  `editor.editor.canvas_full_html`, and `canvas_full_html.settings`.
- All behavior lives in one autowired hook service
  `Drupal\canvas_full_html\Hook\CanvasFullHtmlHooks`: `hook_canvas_storable_prop_shape_alter()`
  swaps the format for props with `contentMediaType: text/html`; `hook_library_info_alter()`
  attaches `canvas_full_html/ckeditor-fixes` (plus enabled CKEditor 5 plugin libraries) to
  the `canvas/canvas-ui` library.
- Edit the Canvas toolbar at `/admin/config/content/formats/manage/canvas_full_html` — it is a
  normal CKEditor 5 config and does not affect any other format.
- Uninstalling deletes the `canvas_full_html` filter format.
