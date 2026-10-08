# File Download Link Media — agent index

Submodule of **file_download_link**. Adds one field formatter — `file_download_link_media` — for
**entity_reference fields targeting Media**, rendering the referenced media as a download link to
its source file/image by delegating to the parent `file_download_link` formatter. No config page,
permissions, or Drush.

- **Formatter id, applicability, settings, and delegation** →
  [configure/formatter.md](configure/formatter.md)

Parent module → `modules/file_download_link/2.0.x/`.

Key facts:
- Formatter id `file_download_link_media`, field type `entity_reference`. `configure` = null.
- `isApplicable()` only offers it when `target_type` is `media` and the referenced media types'
  source fields are file/image.
- Same settings as the parent (schema `field.formatter.settings.file_download_link_media`):
  `link_text` (default "Download"), `link_title`, `aria_label`, `new_tab`, `rel_attribute`,
  `force_download`, `force_download_filename`, `custom_classes`. Token support with `token`.
- Renders by calling the media's source field `->view(['type' => 'file_download_link', ...])`.
- Requires modules `media` + `file_download_link`.
