# Media PDF Thumbnail — agent index

Generates a thumbnail image from a page of a PDF and uses it as a Media entity's thumbnail,
via a field formatter. Needs the **imagick** PHP extension + **spatie/pdf-to-image**. Admin
lives under the `view.pdf_image_entity.list` view (the `configure` route); config object is
`media_pdf_thumbnail.settings` (schema-less). Defines a `pdf_image_entity` content entity.

- **Admin section, the settings form (destination URIs), Queue/Purge forms, permissions, the
  pdf_image_entity list** → [configure/settings.md](configure/settings.md)
- **The `media_pdf_thumbnail_image_field_formatter` and its per-bundle options (field, page,
  format, link, image style)** → [plugins/field-formatter.md](plugins/field-formatter.md)
- **Tokens for URIs / ids / rendered images** → [api/tokens.md](api/tokens.md)
- **`hook_media_pdf_thumbnail_image_render_alter()`** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Formatter id: `media_pdf_thumbnail_image_field_formatter` (label "Media PDF Thumbnail Image"),
  applied to the media **thumbnail** image field in a view display.
- Config route: `view.pdf_image_entity.list` (Configuration → Media → Media PDF thumbnail);
  extra forms: `media_pdf_thumbnail.settings.global|queue|purge`.
- Config `media_pdf_thumbnail.settings`: `destination_uri_public`, `destination_uri_private`.
- Content entity `pdf_image_entity` caches generated images (source PDF + page + format → file).
- Permissions include `administer_media_pdf_thumbnail` and `view private pdf thumbnails`.
- Generation runs inline or via cron queue (`PdfImageEntityGenerateQueue`).
