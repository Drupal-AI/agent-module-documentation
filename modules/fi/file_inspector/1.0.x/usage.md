File Inspector scans the file system for files Drupal does not track, and lets an administrator inspect them, delete them, or import them into the media library.

---

Over a long-lived Drupal site's lifetime, files accumulate on disk that Drupal has no record of in the `file_managed` table: uploads left by a module that has since been removed, files restored from a backup, artefacts of a migration, or files copied in over SFTP. File Inspector walks the configured stream wrappers (`public://` by default), records every file it discovers into a dedicated `file_inspector` table, and then classifies each row as managed or unmanaged by comparing it against `file_managed`. The results are exposed through a Views-based report at `/admin/reports/file-inspector` with status, MIME-type and date filters, per-row action links, and bulk operations. Scanning and classification run through Drupal's Batch API with generator-based iteration, so the module stays within memory and time limits even on file systems with 100k+ files. Configuration lives at `/admin/config/media/file-inspector`, where you set the stream wrappers to scan, excluded folders, an allowed-MIME-type list, batch size, and "embedded web" folders whose supporting assets should be ignored. Deletion and import are each gated behind their own permission and always run through a confirmation form; import creates a managed File entity and, when the core Media module is enabled, wraps it in a Media entity so it becomes available in the media library.

---

- Find files that exist on disk but Drupal does not know about.
- Build a full inventory of what is on disk versus what is in `file_managed`.
- Discover storage consumed by orphaned uploads.
- Clean up leftover files after a contrib or custom module was removed.
- Audit files left behind by a content migration.
- Import an unmanaged file into the media library as a File + Media entity.
- Bulk-import many unmanaged files into a chosen media bundle at once.
- Permanently delete orphaned files through a confirmation form.
- Bulk-delete a validated set of unmanaged files in one operation.
- Run the scan as a resumable batch job on very large file systems (100k+ files).
- Exclude specific folders (by name) from the scan.
- Restrict the scan to an allow-list of MIME types.
- Scan a non-default stream wrapper such as `private://`.
- Filter the report by status: unprocessed, managed, unmanaged, imported, deleted, or web-embedded.
- Filter the report by MIME type or discovery date.
- See per-status counts and a grand total on the overview page.
- Trace each imported file back to the Media entity it produced.
- Mark folders that hold embedded web apps (flipbooks, microsites) so only their entry file is recorded.
- Keep viewing, importing and configuring as three separately grantable permissions.
- Reduce a site's overall storage footprint before a backup or migration.
- Investigate unexplained growth in the files directory.
- Inspect a file's path, size and MIME type before deciding to delete or import it.
- Toggle whether deletion and import operations are allowed site-wide from settings.
