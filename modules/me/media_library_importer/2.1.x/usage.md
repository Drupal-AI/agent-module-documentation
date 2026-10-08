Media Library Importer scans a server directory for files and bulk-creates Media entities (via a queue/batch) so existing files become part of the Media Library without re-uploading each one.

---

The module walks a configured import folder (defaulting to the public files directory), matches files by the allowed extensions of the media types you select, and for each new file creates a File entity and a Media entity of the mapped bundle, storing the file in the media type's own field. Work is chunked through a Drupal queue (`media_library_importer`) processed with a batch via the required `queue_ui` module, so large trees import without timeouts. It is idempotent: before queueing it checks whether a Media of that bundle with the file's name already exists, so re-running does not create duplicates. Configuration (`/admin/config/media/media-library-importer`, permission "Configure media library importer") sets the import folder, whether to exclude the image-styles folder, whether to copy source files into each media type's destination directory, which media types to import, and which field on each media type holds the file. Importing is a second screen (`/admin/config/media/media-library-importer/import`, permission "Import files into media library") offering a checkbox tree of folders, or Drush `media-library:import` / `mli`, or a `hook_cron` calling `MediaLibraryImporterService::generateImportQueue()`. A `hook_alter_media_library_importer_media_extra_fields` alter lets other modules add fields to the created media. The `media_image_exif_importer` submodule (optional) adds EXIF extraction to core's Image media source.

---

- Bulk-register an existing folder of images/PDFs/videos into the Media Library as Media entities.
- Onboard a legacy `sites/default/files` tree into managed Media without manual re-upload.
- Import only the media types you choose (e.g. only Image and Document).
- Map each media type to the field that should hold the imported file.
- Copy source files into each media type's configured destination directory on import.
- Import files in place (as unmanaged-path File entities) without duplicating them.
- Exclude the `styles/` derivative folder from scanning (default on).
- Re-run imports safely; already-imported files (matched by bundle + filename) are skipped.
- Import via a batch UI with a per-folder checkbox tree.
- Import from the command line with `drush media-library:import` (alias `drush mli`).
- Schedule incremental imports with a custom `hook_cron` that calls `generateImportQueue()`.
- Process large directories reliably through the `media_library_importer` queue.
- Add extra field values to created media via `hook_alter_media_library_importer_media_extra_fields`.
- Restrict who can configure the importer vs who can run imports using two separate permissions.
- Seed a fresh site's Media Library from a prepared assets directory during deployment.
- Bring editor-uploaded loose files under Media governance retroactively.
- Import a photographer's export folder and, with the EXIF submodule, capture camera metadata.
- Populate Media entities that reference the same file only once across the library.
- Combine with queue_ui's admin UI to inspect/clear the pending import queue.
- Point the importer at a subfolder to import just one campaign's assets.
