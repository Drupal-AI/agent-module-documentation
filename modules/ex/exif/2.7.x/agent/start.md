# Exif — agent index

Reads EXIF/IPTC/XMP metadata from uploaded JPEGs and writes it into Drupal fields on nodes, media,
and file entities. Enable per bundle on the settings page, then add fields with an Exif form widget
bound to an image field and a tag. Depends on core `file`, `image`, `taxonomy`. `configure` route
`exif.config` (`/admin/config/media/exif`). Permission: `administer image metadata`.

- **Settings page, backends (PHP ext vs exiftool), enabling bundles, helper/sample pages** →
  [configure/settings.md](configure/settings.md)
- **The three field widgets, tag selection, naming convention, per-type handling** →
  [configure/widgets.md](configure/widgets.md)
- **Reader services/API (`ExifFactory`, `ExifInterface`, `ExifContent`) to call from code** →
  [api/reader.md](api/reader.md)
- **Legacy Drush commands (`exif-list`, `exif-update`, `exif-import`)** → [drush/commands.md](drush/commands.md)
- **Permission gating** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Extraction happens in `hook_entity_presave`/`hook_entity_create` (`exif.module` → `ExifContent`).
- Only JPEG is supported; GD strips GPS tags, so ImageMagick is recommended for GPS.
- Config object `exif.settings`; per-widget settings schema `field.widget.settings.exif_*`.
- The `exif_html` widget stores the tag table with the `full_html` format; see the widgets doc.
