# File Download Link — agent index

One **field formatter** — `file_download_link` — for `file` and `image` fields that renders each
file as a configurable download link (custom text, force-download `download` attribute, new tab,
rel, title/ARIA, CSS classes), with optional Token replacement. No config page, permissions, or
Drush. Configure it on a field's *Manage display*.

- **Formatter id, field types, all settings keys, output classes, and Token behaviour** →
  [configure/formatter.md](configure/formatter.md)

Submodule (Media reference fields) → `modules/file_download_link_media/2.0.x/`.

Key facts:
- Formatter id `file_download_link`, field types `file` + `image`. `configure` = null.
- Settings (schema `field.formatter.settings.file_download_link`): `link_text` (default
  "Download"), `link_title`, `aria_label`, `new_tab` (default TRUE), `rel_attribute`,
  `force_download` (default TRUE), `force_download_filename`, `custom_classes`.
- Stored at `core.entity_view_display.<entity>.<bundle>.<mode>` →
  `content.<field>.type: file_download_link` with those `settings`.
- Token module (suggested) enables token replacement in the text/title/aria/filename/classes.
