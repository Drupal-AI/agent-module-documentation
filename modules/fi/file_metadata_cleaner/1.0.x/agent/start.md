<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Metadata Cleaner (file_metadata_cleaner) — agent index

**Removes embedded EXIF/GPS/author metadata from uploaded files using a bundled ExifTool binary, automatically on upload or manually per file.**

- **Version:** 1.0.x  ·  **Core:** ^10 || ^11
- **Depends on:** file, user, views  ·  requires Composer package `ahmetburkan/exiftool-binary`.
- **Configure:** `/admin/config/media/file-metadata-cleaner` (settings), `/processors` (processor overview), `/processor/{plugin}` (per-processor).
- **Per-file:** `/admin/content/files/metadata/{file}` (read metadata), `/{file}/clean` (confirm clean).
- **Permissions:** `edit file metadata cleaner settings` (config); read/clean routes require core `access files overview` + a custom MIME-support access check.
- **Key services:** `file_metadata_cleaner.exiftool` (Process-based ExifTool wrapper), `plugin.manager.file_metadata_cleaner.file_processor`.
- **Extend:** implement a `@FileProcessor` plugin (see `FileProcessorBase`) to support new file types.

**Security:** all routes permission-gated; ExifTool is run via Symfony Process with an argument array (no shell), and file paths/arguments are validated against traversal and shell metacharacters — no injection surface observed.

See [plugins/processors.md](plugins/processors.md) and [configure/settings.md](configure/settings.md).