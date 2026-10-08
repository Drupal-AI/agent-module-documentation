<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor file to media swapper converts embedded `<img>` images and file links in rich-text content into reusable Drupal media entities.
---
The problem it solves: legacy content often references raw files (`public://...`) or `<img src>` directly instead of using Drupal's structured media system, producing duplicate files and unmanaged assets. This module finds or creates a media entity for each such file and rewrites the markup to a `<drupal-media>` embed, both interactively in CKEditor 5 and in bulk across existing content via a batch form.

How it works: a CKEditor 5 "Convert to Media" button calls a set of JSON `media-api/*` endpoints on `SwapperController` (swap by file UUID, by local web path, or by remote URL). Every API call runs `validateSecurityRequirements()`, which enforces a CSRF token (`image_to_media_swapper_api`, compared with `hash_equals`), a per-user UUID context check, an Origin/Referer same-host check, a 30-req/min per-user+IP rate limit, and a JSON content-type check — and the routes additionally require the `create media` + `update media` permissions. Remote-URL swaps go through `SecurityValidationService`, which blocks non-HTTP(S) schemes, blocks private/reserved IPs (resolving hostnames first) as SSRF hardening, enforces size/redirect/timeout limits, and rejects dangerous extensions/MIME types. The bulk `BatchSwapperForm` route uses a custom `_batch_swapper_access` checker that denies anonymous users and requires the restricted `access batch media swapper` permission (and honours a global "disable batch processing" switch). Swap results are tracked in a `media_swap_record` entity.

Setup: enable the module (needs CKEditor 5, Media Library, Serialization; Linkit recommended for link conversion), add the "Convert to Media" button to a CKEditor 5 text format, allow `<drupal-media>` in that format, and tune `/admin/config/media/file-to-media-swapper/settings` (remote downloads, HTTPS requirement, allowed domains/extensions, size limits).
---
- Convert a selected image in CKEditor 5 to a managed media entity.
- Convert a file link (with Linkit) to a media reference.
- Swap a file to media by its file UUID via the JSON API.
- Swap a local web path (e.g. `/sites/default/files/x.jpg`) to media.
- Import and swap a remote image URL into a local media entity.
- Bulk-convert existing content with the batch swapper form.
- Queue records manually via the manual swap queue form.
- Re-check a single swap record from the records list.
- Track every conversion in `media_swap_record` entities.
- Restrict remote downloads to an allow-list of domains.
- Require HTTPS for remote file downloads.
- Cap remote file size, redirect count and download timeout.
- Block dangerous file extensions and MIME types on import.
- Prevent SSRF by blocking private/internal IP targets.
- Disable batch processing site-wide from the settings form.
- Gate the batch tool behind the restricted `access batch media swapper` permission.
- Issue short-lived CSRF tokens to the CKEditor plugin.
- Rate-limit conversion API calls per user and IP.
- Auto-discover media bundles with file fields for the target type.
- Deduplicate by reusing an existing media entity for a known file.
- Migrate legacy inline images to the structured media system.
