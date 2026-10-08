A file_mdm submodule that adds an `exif` FileMetadata plugin, reading (and writing) EXIF metadata from image files using the PHP Exif Library (PEL), overcoming the read-only limitation of PHP's built-in EXIF extension.

---

file_mdm_exif registers a FileMetadata plugin with id `exif` under the File metadata manager framework. Given an image URI, you obtain its `FileMetadata` object from the manager and call `getMetadata('exif', $key)` to retrieve individual EXIF tags; each value comes back as an array with a `text` (presentation) and `value` (PEL internal) representation. Because it uses PEL rather than PHP's `exif_read_data()`, it can also **write** EXIF back to files via the manager's `saveMetadataToFile('exif')`, enabling edits such as changing orientation or stripping tags. An `ExifTagMapper` service maps human-readable tag names to their IFD/tag identifiers so callers can reference tags by name. Supported keys cover the standard EXIF/TIFF/GPS tag set. Its caching, like all file_mdm plugins, is controlled globally or overridden per-plugin through the `file_mdm_exif.file_metadata_plugin.exif` config entity. This submodule is chiefly used by image-processing tooling (for example the ImageEffects module's EXIF-orientation auto-rotate effect).

---

- Read the camera make/model from a photo's EXIF data.
- Get the EXIF `Orientation` tag to auto-rotate uploaded images.
- Extract GPS latitude/longitude from geotagged photos.
- Read the original capture timestamp (`DateTimeOriginal`).
- Retrieve exposure, aperture, ISO, and focal-length tags.
- Write corrected EXIF orientation back into a JPEG.
- Strip or overwrite EXIF tags before publishing an image.
- Present EXIF values in a human-readable form via the `text` representation.
- Access raw PEL values for precise processing.
- Map tag names to IFD/tag ids with the ExifTagMapper service.
- Cache EXIF reads to avoid re-parsing large images.
- Override EXIF cache settings independently of other metadata.
- Feed EXIF orientation to the ImageEffects auto-orientation effect.
- Read copyright/artist tags for attribution display.
- Extract the embedded thumbnail dimensions.
- Determine white balance / flash settings for photo galleries.
- Build a metadata sidebar for a media library from EXIF tags.
- Validate that uploaded images contain required EXIF fields.
- Remove privacy-sensitive GPS data on upload.
- Read lens information tags where present.
- Provide EXIF data to a decoupled front end via custom code.
- Normalize orientation across a batch of imported images.
