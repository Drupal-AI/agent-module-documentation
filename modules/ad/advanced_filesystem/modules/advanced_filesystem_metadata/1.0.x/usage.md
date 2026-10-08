Extracts EXIF, IPTC, XMP, PDF, audio and video metadata from uploaded files and stores it as native, Views-compatible fields on the File entity.

---

The Metadata sub-module of Advanced Filesystem turns the metadata embedded in uploaded files into first-class Drupal data. On upload it reads camera EXIF, IPTC/IIM captions and keywords, XMP packets, basic image info, PDF document properties, and — when ffprobe/ffmpeg are installed — audio and video metadata including embedded captions, and writes each value into an adfs_-prefixed field on the File entity. Because those are real fields, they can be filtered, sorted and displayed in Views. Extraction runs automatically on insert/update (synchronously or via a queue), and can be re-run per file or in bulk from the UI, Batch or Drush. A per-file detail page shows every value grouped by category with a completeness score, and helper Views fields render a GPS map link, an inline thumbnail and a fill-score. A media source makes the metadata available to media types. All administration is gated behind the restricted "administer advanced_filesystem_metadata" permission.

---

- Automatically extract metadata from images the moment they are uploaded.
- Store camera make, model and software from EXIF as searchable fields.
- Capture exposure settings (aperture, shutter, ISO, focal length) from EXIF.
- Record GPS latitude/longitude from photos and expose them as fields.
- Extract IPTC captions, keywords, categories and copyright from images.
- Parse XMP packets embedded in JPEG, TIFF, PNG, WebP and PDF files.
- Read PDF document-information (title, author, subject, producer, page count).
- Extract audio tags (title, artist, album, genre) when ffprobe/getID3 is available.
- Extract video metadata and embedded subtitle/caption tracks via ffprobe/ffmpeg.
- Build Views listings filtered or sorted by any extracted metadata field.
- Add a "GPS Map Link" Views field linking to OpenStreetMap or Google Maps.
- Add an inline "Image Thumbnail" Views field for file listings.
- Add a "Metadata Fill Score" Views field showing how complete a file's metadata is.
- Inspect all metadata for one file on a grouped detail page at /admin/content/files/{file}.
- Re-extract metadata for a single file from the file listing operations.
- Bulk re-extract metadata across many files with the Batch-powered form.
- Run extraction asynchronously through a queue to keep uploads fast.
- Choose exactly which metadata groups (EXIF camera, GPS, IPTC, XMP, PDF, audio, video, …) to enable.
- Control whether re-extraction overwrites existing values.
- Extract or check metadata from the command line: `drush metadata:extract`, `metadata:status`, `metadata:missing`.
- Expose file metadata to media types through the "File (ADFS Metadata)" media source.
- Automatically create and remove the metadata fields as groups are enabled or disabled.
- Detect and report which files are still missing metadata.
