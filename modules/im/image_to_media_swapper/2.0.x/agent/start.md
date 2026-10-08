<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor file to media swapper (image_to_media_swapper) — agent index

**Converts CKEditor `<img>`/file links into reusable media entities, in-editor or in bulk.**

- **Version:** 2.0.x
- **Core:** `^10 || ^11`  •  **Depends:** ckeditor5, media_library, serialization (Linkit recommended)
- **Config route:** `image_to_media_swapper.security_settings` → `/admin/config/media/file-to-media-swapper/settings` (`administer site configuration`)
- **API routes (POST/GET, permission `create media`+`update media`):** `/media-api/swap-file-to-media/{file-uuid,local-path,remote-uri}`, `/media-api/security-tokens`
- **Batch/queue:** `/admin/content/media/batch-file-to-media-swapper` (`_batch_swapper_access`), `/admin/content/media/manual-file-to-media-swapper` (`access batch media swapper`)
- **Entity:** `media_swap_record` (with access-control handler).

**Security:** Sound. API endpoints require `create media`+`update media` AND pass a per-request check (CSRF `hash_equals`, per-user UUID context, Origin/Referer same-host, 30/min rate limit, JSON content-type). Remote-URL import is SSRF-hardened via `SecurityValidationService` (blocks private/reserved IPs after hostname resolution, HTTP(S)-only, size/redirect/timeout caps, dangerous-extension/MIME denylist). The `_batch_swapper_access:'TRUE'` route is NOT open — the checker denies anonymous users and requires the restricted `access batch media swapper` permission plus a global enable switch.

See [api/image_to_media_swapper.md](api/image_to_media_swapper.md).
