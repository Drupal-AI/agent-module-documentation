<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File processor plugins

Metadata handling is delegated to `@FileProcessor` annotated plugins under
`src/Plugin/FileProcessor/`. Shipped plugins: `JpegProcessor`, `JpgProcessor`,
`PdfProcessor`, all extending `FileProcessorBase` (which implements
`FileProcessorInterface`).

A processor declares the MIME types it supports; `FileProcessorPluginManager`
discovers them and the access check (`FileMetadataCleanerAccessCheck::accessFile`)
only grants the read/clean routes when at least one plugin `supports()` the
file's MIME type.

To add a format, create a plugin in your module implementing
`FileProcessorInterface`, declare its `mime` support, and reuse the
`file_metadata_cleaner.exiftool` service. The actual stripping runs
`exiftool -overwrite_original -all=` with any keep-arguments the processor
configures, executed through Symfony Process with an argument array.
