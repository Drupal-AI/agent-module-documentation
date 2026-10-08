Exif-DropzoneJS wires the parent Exif module's metadata pre-loading into the DropzoneJS media-library upload form, so alt text and mapped fields are populated from image metadata when editors add media through DropzoneJS.

---

This submodule of Exif has no configuration or UI of its own. It implements
`hook_form_FORM_ID_alter()` for `media_library_add_form_dropzonejs`
(`exif_dropzonejs.module`) and reuses the media-type EXIF mapping configured on the parent module
(the media type's `exif` third-party settings: `alt` and `field_map`). When one or more images are
uploaded via DropzoneJS, it loads each new file, reads its metadata with
`\Drupal\exif\ExifContent::getDataFromFileUri()`, and — only where the target is still empty —
pre-fills the image `alt` text and each mapped string/text field, and for taxonomy-term reference
fields finds or creates a `section > tag > value` term hierarchy (via `\Drupal\exif\ExifHelper`),
duplicating the widget rows so multiple terms attach. It requires the `dropzonejs` and `exif`
modules (plus core `file`, `image`, `taxonomy`). A post-update hook
(`exif_dropzonejs_post_update_fix_settings`) migrates any legacy `exif.exif_dropzonejs.field_map`
third-party setting onto the unified `exif.field_map` key. Because it only reacts to the DropzoneJS
form, it does nothing until DropzoneJS media uploads are used.

---

- Auto-fill image `alt` text from a metadata tag when adding media through DropzoneJS.
- Pre-populate mapped string/text media fields from EXIF/IPTC/XMP tags on DropzoneJS upload.
- Populate taxonomy-term reference fields (creating terms as needed) from image keywords/metadata.
- Handle multi-file DropzoneJS uploads, applying mapping to each uploaded image.
- Reuse the exact media-type EXIF field mapping already configured for the core media uploader.
- Extend Exif's alt-preload feature (core uploader only) to the DropzoneJS media-library widget.
- Only overwrite fields that are empty, preserving values an editor already typed.
- Attach multiple keyword terms to a media item by cloning the reference widget rows.
- Migrate legacy `exif_dropzonejs` field-map third-party settings to the unified key via post-update.
- Enable metadata capture for sites that standardise on DropzoneJS for media uploads.
- Keep the parent Exif configuration as the single source of truth for tag-to-field mapping.
- Support photography/DAM workflows where contributors bulk-drop JPEGs into the media library.
- Announce which fields were auto-filled from metadata (status messages via `announceFieldPreloaded`).
- Fall back gracefully (does nothing) when the media type has no EXIF mapping configured.
- Work alongside the parent module's node/media/file presave extraction without duplicating it.
