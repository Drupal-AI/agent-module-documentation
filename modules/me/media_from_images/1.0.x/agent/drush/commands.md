<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: media_from_images

`drush media-from-images:process` (alias `drush mfi:process`)

Creates media entities for all image files that do not yet have one, printing progress every 50 files and a final `Processed / Created / Skipped` summary. It iterates `MediaFromImagesService::getImageFileIds()` and calls `createMediaFromFile()` for each file where `mediaEntityExistsForFile()` is FALSE.

Notes:
- Unlike the UI triggers, the CLI command runs synchronously in one process (no Batch API, no 5-minute rate limit) — suitable for deploy hooks.
- Requires the `image` media bundle with `field_media_image`.
- Safe to re-run; existing media are detected via the hash table + media storage and skipped.