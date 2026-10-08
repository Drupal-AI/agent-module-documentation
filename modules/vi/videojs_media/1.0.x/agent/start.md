<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VideoJS Media (videojs_media) — agent index

**Reusable `videojs_media` content entity rendering a VideoJS player, with Local/Remote/YouTube video & audio bundles and view-mode display.**

- **Version:** 1.0.x (1.0.0)
- **Core:** ^10.3 | ^11
- **Entity types:** `videojs_media` (content) + `videojs_media_type` (config bundles: local_video, local_audio, remote_video, remote_audio, youtube).
- **Routes:** entity CRUD (`/videojs-media/add`, `/admin/content/videojs-media`) + type management (`/admin/structure/videojs-media/types`) via entity route providers.
- **Block:** `VideoJsMediaBlock`.
- **Depends on:** file, image, options, text, `file_upload_secure_validator` (upload hardening).
- **Permissions:** `administer videojs media` / `administer videojs media types` (restricted); per-bundle `create/edit own/edit any/delete own/delete any/view/view unpublished <bundle> videojs media`.
- **Security:** Access is enforced by `VideoJsMediaAccessControlHandler` — admin bypass on `administer videojs media`, else published-state-aware view perms and any/own+ownership checks for update/delete; type ops gated by `administer videojs media types`. No anonymous mutating routes, no SSRF sink (remote URL is stored/rendered as a player source, not server-fetched), no disabled TLS. See [configure/media.md](configure/media.md).