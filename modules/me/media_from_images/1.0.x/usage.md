<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Create Media from Image Entities scans managed image files and generates a Media (image) entity for every file that does not already have one, tracking each with a content hash to avoid duplicates.
---
The service `media_from_images.service` queries `file_managed` for files whose `filemime` starts with `image/`, and for each one that has no existing `image` media (checked against both a custom `media_from_images` tracking table keyed by SHA-256 file hash and the media storage) it creates a media entity, sanitising the filename for the media name/alt. Work is done in three interchangeable modes — standard Batch API, an immediate sequential batch, and a cron-queued mode processed by `media_from_images_cron()` (a few batches per run) — all guarded by a per-user 5-minute rate limit and a named lock to prevent concurrent runs. A companion "attach unattached media" workflow back-fills hash entries for pre-existing media. `hook_entity_delete()` cleans up tracking rows when a media or image file is deleted.

The admin UI at `/admin/config/media/media-from-images` and every batch trigger require the `administer media from images` permission (`restrict access: true`), and a Drush command `media-from-images:process` (alias `mfi:process`) runs the creation from CLI. Security-wise the module only ever operates on **existing, already-uploaded managed image files** — there is no user-supplied path, no file ingestion from arbitrary locations, and no path traversal; MIME is re-checked before creation, filenames are sanitised, and all database access uses parameterised queries. Typical setup: enable the module, ensure an `image` media type with a `field_media_image` field exists, then run the batch (UI or Drush).
---
- Backfill media entities for a site that has many image files but few media.
- Run the creation as a standard progress-bar batch from the admin form.
- Run an immediate (no-delay) batch for smaller sites.
- Queue creation for cron so it runs gradually in the background.
- Trigger creation from CLI with `drush mfi:process`.
- Deduplicate by SHA-256 file hash so the same image is not re-created.
- Attach hash-table entries to media that already existed before install.
- View counts of files still lacking media entities.
- Review failed/skipped processing entries and their error messages.
- Rely on the per-user 5-minute rate limit to avoid runaway operations.
- Rely on the lock so two admins cannot start overlapping runs.
- Auto-clean tracking rows when media or image files are deleted.
- Restrict the whole feature to admins via `administer media from images`.
- Process large libraries in chunks of 50 files per batch.
- Confirm the `image` media bundle and `field_media_image` exist before running.
- Clear the cached "files without media" count after bulk changes.
- Inspect the `media_from_images` table to audit what was generated.
- Use the stats theme hook to surface progress on the admin page.
- Re-run safely; existing media are detected and skipped.
- Schedule ongoing creation purely through cron for continuously uploaded images.