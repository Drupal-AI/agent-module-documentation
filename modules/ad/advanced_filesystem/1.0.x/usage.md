<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced FileSystem is an enterprise file-management framework whose lean core controls where files live on disk, migrates and reorganizes them in batches, and keeps the file table and physical storage in sync.

---

The module's core provides a pluggable path-strategy API with 13 built-in strategies (default, counted, flat, flat-named, date-hash, CDN hash, content-type, MIME-type, entity-bundle, field-name, user-role, locale and year) that decide the on-disk URI of every uploaded file. Around that sits a batch migration tool with dry-run preview, a confirmation step and full rollback; a strategy simulator; a detailed file report with filters and CSV/JSON export; an integrity checker and ghost-file scanner (missing DB rows vs. orphan disk files); embedded-URL rewriting for text/link fields after a migration; and on-upload hooks that sanitize filenames, resolve duplicate names, strip image metadata and flag exact or visually similar duplicates. Background cron services detect orphans, record storage-growth snapshots, run retention rules and send duplicate/orphan alert emails. All routes are grouped under `/admin/config/media/advanced_filesystem` and `/admin/reports/advanced_filesystem` and require the `administer advanced filesystem` permission. Nine Drush commands mirror the UI. The project additionally ships 26 optional submodules (backup, AI, antivirus, CDN, quota, metadata, processors and more) that are documented separately. Supports Drupal 10, 11 and 12.

---

- Choose a path strategy so uploads land in date-based, hash-based, bundle-based or flat directory layouts.
- Preview a migration with a dry-run before moving any files.
- Migrate all existing files to a new path strategy in a batch.
- Roll back a recorded migration to restore original file paths.
- Migrate files automatically on cron with per-field rules and intervals.
- Migrate a file to its correct path immediately on upload.
- Simulate every strategy's output URI for a fictional filename before committing.
- Browse, filter (path, MIME, size, status, field, usage) and paginate all managed files.
- Export the file report as CSV or JSON.
- Run an integrity check comparing every `file_managed` row against the disk.
- Scan for ghost files: DB rows whose file is missing, and disk files with no DB row.
- Review reclaimable disk space and delete selected orphan/missing files with a confirmation step.
- Rewrite hardcoded file URLs embedded in body/text and link fields after a migration.
- Sanitize uploaded filenames (lowercase, separators, length limits, dot handling).
- Automatically rename files that would collide with an existing filename.
- Strip EXIF/metadata from images on upload to reduce size and remove embedded data.
- Detect exact-duplicate uploads via SHA-256 and warn or block them.
- Detect visually similar image uploads via perceptual (dHash) hashing.
- Receive email alerts when orphan-file or duplicate-file counts cross a threshold.
- Apply time-based retention rules to delete or quarantine old files via cron.
- Record daily storage-growth snapshots and chart storage over time.
- Enforce content-aware access to private files based on referencing-entity view access.
- Run the same operations from the CLI with `drush advanced_filesystem:*` commands.
- Extend the path-strategy system with a custom `@PathStrategy` plugin.
- Run a "doctor" health check that reports on stream wrappers, config and required binaries.
- Support Drupal 10, 11 and 12 on PHP 8.1+.
