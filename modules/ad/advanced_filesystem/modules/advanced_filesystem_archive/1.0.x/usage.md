Bundle selected managed files into a single downloadable ZIP, extract an uploaded ZIP into individual Drupal-managed files, and browse a ZIP's contents in place — all from the Drupal admin.

---

Advanced Filesystem: Archive is an optional submodule of the Advanced FileSystem project. It gives site administrators three ZIP-oriented tools over Drupal's managed files. A download tool streams any set of selected file entities to the browser as one ZIP (created with PHP's `ZipArchive`, written to a temp file and streamed with `fpassthru`, with in-archive name-collision handling and every request logged with the requester's UID and IP). An extraction tool takes an uploaded ZIP and turns each contained file into its own managed `File` entity, applying an optional MIME-prefix filter, a per-file size cap, filename sanitisation, and recording parent→child lineage. A browse tool lists the entries inside a ZIP (name, size, compressed size, directory flag, modified time) without extracting anything. Limits and defaults live in the `advanced_filesystem_archive.settings` config object, editable at `/admin/config/media/advanced_filesystem/archive`. Each tool is protected by its own permission.

---

- Let editors download a whole set of managed files as one ZIP instead of clicking each file individually.
- Package the files attached to a node (galleries, document sets) into a single archive for a client to download.
- Offer a "download all" action for a media library selection.
- Cap how many files a single ZIP download may contain (`max_files_per_download`, default 500).
- Cap the total ZIP size so a download request cannot pack unbounded gigabytes (`max_zip_size_mb`, default 2048).
- Keep an audit log of who downloaded which files, when, from which IP (`adfs_archive_downloads` table, viewable at the archive log page).
- Extract an uploaded ZIP of images so each image becomes a managed file ready for use in media/content.
- Bulk-import a ZIP of PDFs or documents as individual managed files in one step.
- Restrict extraction to only certain content types using a MIME-prefix filter (e.g. `image/`, `application/pdf`).
- Skip files that already exist at the destination during extraction (`skip_existing`).
- Choose whether extracted files land in the `public://` or `private://` scheme, under a configurable subdirectory.
- Enforce a maximum size per extracted file to avoid unpacking oversized entries (`max_extract_file_size_mb`, default 512).
- Trace which managed files came out of which uploaded ZIP via the `adfs_archive_extractions` lineage table.
- Inspect the contents of a ZIP file (folder/file listing with sizes) before deciding to extract it.
- Preview an archive's structure directly from the file listing at `/admin/content/files/{file}/archive/browse`.
- Give a limited role only the "browse" or only the "download" capability without granting extraction rights.
- Automatically de-duplicate in-archive filenames when two selected files share a name during a ZIP download.
- Provide a repeatable, config-exportable set of archive limits across environments.
- Hand off large file sets to external recipients as a single, size-limited archive.
- Turn a delivery ZIP from a supplier into individually tracked Drupal files without shell access to the server.
