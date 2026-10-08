<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Running media creation

Admin form: `/admin/config/media/media-from-images` (perm `administer media from images`).

Prerequisites: a Media type with machine bundle `image` and an image source field `field_media_image` (Drupal's standard media install provides this).

Processing modes (all on `media_from_images.service`):
- `startBatchProcess()` — standard Batch API, 50 files/batch, 30-min lock.
- `startImmediateBatchProcess()` — sequential, no delays, 2-hour lock.
- `startCronBatchProcess()` — stores batches in state; `media_from_images_cron()` processes up to 3 batches per cron run.
- Attach variants (`startAttach*Process()`) back-fill hash rows for media that already existed.

Guards:
- Per-user rate limit: one operation per 5 minutes (state key `media_from_images_rate_limit_<uid>`).
- Named lock `media_from_images_create_batch` / `..._attach_batch` prevents concurrent runs.

Dedup: `mediaEntityExistsForFile()` checks the `media_from_images` table (SHA-256 of the file) and the `image` media storage before creating. `createMediaFromFile()` re-checks MIME (`image/`) and sanitises the filename with `preg_replace('/[^a-zA-Z0-9._-]/','_', ...)`.

Reporting helpers: `countFilesWithoutMediaEntities()`, `countMediaHashEntries()`, `getFailedProcessingEntries()`, `countFailedProcessingEntries()`.