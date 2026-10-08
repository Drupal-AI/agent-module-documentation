<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VideoJS Media — bundles, fields & permissions

## Bundles (videojs_media_type)
- `local_video` — `field_media_file`, `field_poster_image`, `field_subtitle`.
- `local_audio` — `field_media_file`, `field_poster_image`, `field_subtitle`.
- `remote_video` — `field_remote_url`, `field_poster_image`, `field_subtitle`.
- `remote_audio` — `field_remote_url`, `field_poster_image`, `field_subtitle`.
- `youtube` — `field_youtube_url`, `field_poster_image`, `field_subtitle`.

Each ships `default` + `teaser` view displays and a default form display.

## Using it
1. Enable module; grant per-bundle `create/view/edit/delete` permissions.
2. Create items at `/videojs-media/add` (choose a bundle).
3. To embed in content, add an **entity reference** field targeting `videojs_media` on the host content type.
4. Manage bundles/fields at `/admin/structure/videojs-media/types`.
5. Optionally place the `VideoJsMediaBlock`.

## Access (VideoJsMediaAccessControlHandler)
- `administer videojs media` → full access.
- view: published → `view <bundle> videojs media`; unpublished → `view unpublished <bundle> videojs media`.
- update/delete: `edit|delete any <bundle> videojs media`, or the `own` variant when `account->id() == entity owner`.
- Type CRUD gated by `administer videojs media types`.

## Notes
- Remote/YouTube URLs are stored and emitted as client-side player sources — no server-side fetch, so no SSRF surface.
- `file_upload_secure_validator` dependency hardens uploaded local media.
- Subtitle field supports ADA/508 captions.