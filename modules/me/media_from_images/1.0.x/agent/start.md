<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create Media from Image Entities (media_from_images) — agent index

**Bulk-creates image Media entities for managed image files that lack one, deduplicated by SHA-256 hash.**

- **Version:** 1.0.x (1.0.4)
- **Core:** ^10 || ^11
- **Admin:** `/admin/config/media/media-from-images` (route `media_from_images.admin`) — perm `administer media from images` (`restrict access: true`).
- **Service:** `media_from_images.service` (`src/MediaFromImagesService.php`) — batch / immediate / cron-queue modes, per-user rate limit, lock.
- **Drush:** `media-from-images:process` / `mfi:process`.
- **Hooks:** `hook_cron` (queue processing), `hook_entity_delete` (tracking cleanup).
- **Storage:** custom `media_from_images` table (hash tracking).
- **Permissions:** `administer media from images`.
- **Security:** every entry point (form + batch triggers) is gated by the restricted admin permission. Operates only on **existing managed image files** (`filemime LIKE image/%`) — no user-supplied paths, no arbitrary-file ingestion, no traversal; MIME re-validated, filenames sanitised, all SQL parameterised. No security findings.

See [configure/batch.md](configure/batch.md) and [drush/commands.md](drush/commands.md).