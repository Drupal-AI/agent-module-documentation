<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

**Global settings** — `/admin/config/media/file-metadata-cleaner`
(`FileMetadataCleanerSettingsForm`, config `file_metadata_cleaner.settings`):
toggle automatic cleaning on upload.

**Processor overview** — `/admin/config/media/file-metadata-cleaner/processors`
lists the discovered `@FileProcessor` plugins.

**Per-processor** — `/admin/config/media/file-metadata-cleaner/processor/{plugin}`
(`FileProcessorSettingsForm`): each processor can strip everything and be told
which tags to keep.

**Manual per-file** — the file metadata page
`/admin/content/files/metadata/{file}` shows the current metadata table plus a
`metadata_cleaned` status, with a Clean Metadata action to
`/admin/content/files/metadata/{file}/clean` (confirm form).

All pages require `edit file metadata cleaner settings`; per-file pages
additionally require core `access files overview` and a MIME-support check.
Requires the ExifTool binary from `ahmetburkan/exiftool-binary`.
