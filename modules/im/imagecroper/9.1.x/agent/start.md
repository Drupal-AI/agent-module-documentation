# Image Crop Widget (imagecroper) — agent index

A single field widget, `imagecroper` ("Imager Widget"), that adds in-browser rotate/crop/resize
(via the bundled ImagerJS library) to core **Image** fields. Extends `ImageWidget`. No global
config page (`configure` null), no permissions, no Drush, no submodules. Depends on core `image`.
Provides a field-widget settings schema.

- **Enable the widget on a field, its one setting, and how edits are saved (replace vs new file)** →
  [configure/widget.md](configure/widget.md)

Key facts:
- Widget id `imagecroper`, field type `image`; select it on *Manage form display*.
- Only setting: `update_image_type` = `replace` (overwrite original managed file, flush image
  styles + `.webp`) or `new` (create `public://<original-name>`, renamed on collision). Default in
  code is `new`; the settings-form default falls back to `replace`.
- Edited pixels arrive as a base64 data-URI in a hidden textarea; `massageFormValues()` decodes and
  writes the file. Editor assets are the local `imagecroper/imagerjs` library (no CDN).
- `hook_field_widget_info_alter()` also exposes the widget for the core `image_image` field types.
- Schema note: `config/schema/imagecroper.schema.yml` declares key `update_image`, but the plugin
  stores `update_image_type` — the real setting is effectively schema-less (harmless config warning).
