File metadata manager (file_mdm) provides a central service that reads, caches, and writes metadata about files (image dimensions, EXIF, font information) so multiple modules can share a single, cached lookup instead of each re-parsing the file.

---

file_mdm is a developer-oriented utility module: it exposes a `FileMetadataManager` service that, given a file URI, returns a `FileMetadata` object through which you request specific metadata by plugin id (e.g. `getimagesize`, `exif`, `font`). The actual parsing is delegated to **FileMetadata plugins** — the base module ships `GetImageSize` (PHP `getimagesize()` data), while the `file_mdm_exif` and `file_mdm_font` submodules add EXIF (via the `fileeye/pel` library) and TTF/OTF/WOFF font parsing (via `dompdf/php-font-lib`). Retrieved metadata is cached in a dedicated `file_mdm` cache bin with a configurable expiration and per-path disallow list, so repeated requests across a request or across page loads avoid re-reading the file — a meaningful saving for remote/stream-wrapped files that must be copied to a local temp path first. The manager can copy a URI to a temporary local file, load metadata from the file or from cache, modify it in memory, and (for supported formats like EXIF) write it back to the file. Configuration lives at Admin → Configuration → System → File metadata manager, where caching behavior and the missing-file log level are set, and each plugin has its own config entity (`*.file_metadata_plugin.*`) that can override the global cache settings. It is primarily consumed by other modules — most notably the ImageEffects module — rather than used directly by site builders.

---

- Read an image's width/height without repeatedly calling `getimagesize()`.
- Cache expensive file-metadata lookups across requests in a dedicated cache bin.
- Share a single metadata read of a file between several modules.
- Extract EXIF data (camera, orientation, GPS, timestamps) from photos (with file_mdm_exif).
- Auto-rotate images based on the EXIF orientation tag.
- Read TTF/OTF/WOFF font metadata such as family and style (with file_mdm_font).
- Copy a stream-wrapped/remote file to a local temp path for parsing.
- Write modified EXIF metadata back into an image file.
- Provide image-dimension data to image styles / effects efficiently.
- Add a custom metadata type by implementing a FileMetadata plugin.
- Override cache settings per metadata plugin (enable/disable, expiration).
- Exclude specific paths from metadata caching via a disallowed-paths list.
- Control how missing files are logged via the log-level setting.
- Query supported metadata keys for a given file and plugin.
- Set or remove individual metadata keys in memory before saving.
- Invalidate/delete cached metadata for a file after it changes.
- Release an in-memory FileMetadata object to free resources.
- Back the ImageEffects module's metadata needs.
- Determine an image's MIME type from parsed metadata.
- Read metadata from a temporary uploaded file during form processing.
- Alter available plugins via `hook_file_metadata_plugin_info_alter()`.
- Serve as a reusable metadata layer for a media-heavy site.
- Avoid duplicate disk/network I/O in image-processing pipelines.
- Provide a consistent API over PEL, php-font-lib, and getimagesize.
