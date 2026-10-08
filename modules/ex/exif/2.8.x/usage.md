Exif reads EXIF, IPTC and XMP metadata out of uploaded JPEG images and copies it into Drupal fields on nodes, media entities, and files, so camera and photo metadata can be displayed, filtered, or turned into taxonomy terms.

---

Exif extracts image metadata via one of two backends — the PHP `exif`/`iptcparse` extensions (default) or an external `exiftool` binary — selected on the settings page (`/admin/config/media/exif`, route `exif.config`, permission `administer image metadata`). You enable it per bundle by ticking the node, media, or file types to scan, then adding fields to that bundle and assigning one of the module's form widgets: `exif_readonly` (viewable read-only value), `exif_hidden` (populated but not shown on the form), or `exif_html` (a full HTML table of every tag). Each widget instance is bound to an image field and to a metadata tag, chosen either explicitly from the tag list or by the `field_<section>_<tag>` naming convention (for example `field_exif_model`, `field_ifd0_datetime`). On `hook_entity_presave`/`hook_entity_create` (implemented in `src/Hook/ExifHooks.php`, delegating to `src/ExifContent.php`) the module reads the linked image, resolves the requested tag(s), and writes the value into the field, with special handling for text, date/datetime, and taxonomy-term reference fields (auto-creating a `section > tag > value` term hierarchy). Media types gain an alternative UI on the media-type edit form: a mapping of individual fields (and the image `alt` text) to metadata tags stored in the media type's `exif` third-party settings. A quick-start helper (`/admin/config/media/exif/helper`) can scaffold a "photography" vocabulary, node type, or media type in one click, and a sample page renders every tag found in the bundled `sample.jpg`. Legacy Drush-8-style commands (`exif-list`, `exif-update`, `exif-import`) are declared in `exif.drush.inc`. The `exif_dropzonejs` submodule extends the alt/field mapping to DropzoneJS media-library uploads.

---

- Show the camera make and model on photo nodes by adding `field_exif_make` / `field_exif_model` fields.
- Record the shot date from `DateTimeOriginal` into a datetime field (`field_exif_datetimeoriginal`).
- Display exposure settings (ExposureTime, FNumber, ISO, FocalLength) on a photography content type.
- Render a complete metadata table for an image using the `exif_html` widget on a `text_long` field.
- Populate a field silently with the `exif_hidden` widget for use in Views filters without showing it on the edit form.
- Extract GPS latitude/longitude tags (use ImageMagick, not GD, and/or the exiftool backend to avoid GPS stripping).
- Turn IPTC keywords into taxonomy terms in a dedicated vocabulary.
- Auto-build a `section > tag > value` taxonomy hierarchy from image metadata.
- Fill an empty node title from metadata on creation (the module inserts an `EXIF_FILLED` placeholder title).
- Read XMP fields such as Artist, Title, Keywords, Orientation.
- Scan media entities as well as classic nodes by enabling the relevant media types.
- Scan bare file entities (bundle `file`) for metadata.
- Map individual media fields (and image `alt` text) to metadata tags via the media-type edit form.
- Split a multi-value metadata string into multiple field values with a one-character separator.
- Switch the extraction backend from the PHP extension to `exiftool` for richer tag coverage.
- Configure the date parse format used to interpret EXIF date strings.
- Bulk re-read metadata for all entities of a type after a config change via `drush exif-update`.
- Import a directory tree of JPEGs as nodes/media with metadata via `drush exif-import`.
- List which bundles currently have EXIF extraction enabled via `drush exif-list`.
- Scaffold a ready-made "photography" vocabulary, node type, or media type from the helper page.
- Preview every tag available on a reference image via the sample page.
- Use the `exif_readonly` widget so editors can see (but not edit) the extracted value inline.
- Choose which image field on a multi-image bundle supplies the metadata.
- Keep existing values on update by leaving `update_metadata` off (only fill on insert).
- Optionally overwrite metadata fields on every save by enabling `update_metadata`.
- Pre-load metadata into DropzoneJS media-library uploads by enabling the `exif_dropzonejs` submodule.
- Provide a D7-to-D8+ migration field plugin (`ExifReadOnly`) when upgrading legacy Exif fields.
