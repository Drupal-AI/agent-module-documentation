<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Metadata Cleaner removes embedded metadata (EXIF, GPS coordinates, author, device and revision data) from uploaded files using a bundled ExifTool binary.

---

Uploaded images and PDFs frequently carry hidden metadata that leaks author identity, camera model or the exact GPS location a photo was taken. This module solves that by wrapping the `ahmetburkan/exiftool-binary` Composer package in an `Exiftool` service and a pluggable `FileProcessor` plugin system (JPEG, JPG, PDF processors ship in the box). It can clean files automatically on upload (configurable per site) or on demand from a per-file admin page, and it stamps a `metadata_cleaned` computed flag on the file entity so you can tell which files have already been processed.

Operationally it is admin-only: the settings and per-processor configuration pages require the `edit file metadata cleaner settings` permission, and the read/clean pages require core's `access files overview` permission plus a custom access check that verifies a processor plugin actually supports the file's MIME type. The ExifTool wrapper is defensively coded — it invokes the binary through Symfony `Process` with an argument array (no shell string), rejects path traversal and shell metacharacters in file paths, validates arguments, and enforces a 10-second timeout — so there is no command-injection surface. Typical setup is: require the Composer package, enable the module, visit the settings page, choose whether to clean on upload, and optionally tune each file-type processor.

---

- Automatically strip EXIF/GPS/author metadata from images the moment they are uploaded
- Enable or disable clean-on-upload from the settings page
- Manually clean a single existing file from its metadata page
- View the current metadata table for any supported file before cleaning it
- See a per-file `metadata_cleaned` status to tell which files were processed
- Remove GPS coordinates from user-submitted photos on a public site
- Strip author/producer/revision metadata from uploaded PDFs
- Configure the JPEG processor to keep specific tags while stripping the rest
- Configure the PDF processor's stripping behaviour independently
- Review the processor overview page to see which file types are covered
- Add a custom `@FileProcessor` plugin to support a new file format
- Reuse the `file_metadata_cleaner.exiftool` service to read metadata programmatically
- Restrict who can change cleaning settings via the `edit file metadata cleaner settings` permission
- Meet privacy/GDPR obligations by removing hidden metadata from media
- Clean confidential embedded data from client files before publishing
- Vendor the ExifTool binary through the `ahmetburkan/exiftool-binary` Composer package (no manual install)
- Verify metadata was removed by re-opening the file's metadata page after cleaning
- Gate the per-file read/clean pages behind core's `access files overview` permission
