<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exif (exif) — agent index

Reads EXIF/IPTC/XMP metadata from uploaded JPEGs and writes it into Drupal fields on nodes, media,
and file entities. Enable per bundle on the settings page, then add fields with an Exif form widget
bound to an image field and a tag. Depends on core `file`, `image`, `taxonomy`.
`core_version_requirement: ^9 || ^10 || ^11 || ^12`. `configure` route `exif.config`
(`/admin/config/media/exif`). Permission: `administer image metadata`. Ships submodule
`exif_dropzonejs`.

- **Settings page, backends (PHP ext vs exiftool), enabling bundles, helper/sample pages** →
  [configure/settings.md](configure/settings.md)
- **The three field widgets, tag selection, naming convention, per-type handling, media-type mapping** →
  [configure/widgets.md](configure/widgets.md)
- **Reader services/API (`ExifFactory`, `ExifInterface`, `ExifContent`, `ExifHelper`) to call from code** →
  [api/reader.md](api/reader.md)
- **Legacy Drush commands (`exif-list`, `exif-update`, `exif-import`)** → [drush/commands.md](drush/commands.md)
- **Permission gating** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Hook logic lives in `src/Hook/ExifHooks.php` (attribute `#[Hook]`, autowired service); thin
  `#[LegacyHook]` shims remain in `exif.module`.
- Extraction runs in `entity_presave`/`entity_create` → `src/ExifContent.php`; backend chosen by
  `src/ExifFactory.php` (`ExifPHPExtension` default, `SimpleExifToolFacade` for exiftool).
- Only JPEG is read by the PHP-extension backend (`readExifTags`); GD strips GPS, so exiftool or
  ImageMagick is recommended for GPS.
- Config object `exif.settings`; per-widget settings schema `field.widget.settings.exif_*`; media
  type mappings in `media.type.*.third_party.exif`.
- Submodule `exif_dropzonejs` documented at
  `../../modules/exif_dropzonejs/2.8.x/agent/start.md`.
