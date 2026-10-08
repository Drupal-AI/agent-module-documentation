Media Image EXIF Importer overrides core's Image media source so image media types can extract EXIF metadata (camera model, capture datetime, ISO, exposure, aperture, focal length) as mappable metadata attributes.

---

Shipped inside the Media Library Importer project as an optional submodule, this is a Drupal 10/11 fork of the abandoned Media Entity Image EXIF. Its `.module` implements `hook_media_source_info_alter()` to swap core's `image` media source `class` for `Drupal\media_image_exif_importer\Plugin\media\Source\ImageWithExif`, which extends core's `Image` source. The subclass adds a per-media-type "Whether to gather exif data" setting (`gather_exif`, disabled when PHP's `exif_read_data()` is unavailable) and, when enabled, exposes extra metadata attributes: `model`, `created` (from `DateTimeOriginal`, formatted to Drupal's datetime storage format), `iso`, `exposure`, `aperture`, `focal_length` (fraction values normalized), plus width/height. EXIF is read with `exif_read_data(realpath($uri), 'EXIF')` and cached per source instance. You map these attributes to media fields on the Image media type's edit form exactly like core's built-in metadata mappings. Only `media` is required; it works standalone (you do not have to use the importer to benefit from EXIF mapping). Because it replaces the core Image source class globally, enabling it affects every Image media type on the site.

---

- Extract the camera model from uploaded photos into a Media field.
- Store each photo's original capture datetime as a date field.
- Capture ISO speed, exposure time, aperture (F-number), and focal length.
- Map EXIF attributes to fields via the Image media type's field mapping UI.
- Enable/disable EXIF gathering per Image media type with the `gather_exif` setting.
- Auto-disable EXIF options when the PHP `exif` extension is missing.
- Normalize fractional EXIF values (e.g. exposure `1/200`) for display.
- Backfill photography metadata for a stock-photo or DAM library.
- Combine with Media Library Importer to bulk-import photos and grab their EXIF at once.
- Replace the abandoned Media Entity Image EXIF module on Drupal 10/11.
- Add width/height metadata attributes to Image media beyond core's defaults.
- Populate a searchable "shot on" camera field for filtering media.
- Feed capture-date into content scheduling or sorting.
- Keep using core's Image source behavior for everything except the added EXIF attributes.
- Provide photographers a self-documenting media library.
- Surface aperture/ISO/focal length in a photo's full view mode.
- Support any image media type site-wide (the source class is replaced globally).
- Avoid manual metadata entry for large photo imports.
