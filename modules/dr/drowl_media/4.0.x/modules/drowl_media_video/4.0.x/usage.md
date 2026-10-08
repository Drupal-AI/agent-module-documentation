<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DROWL Media Video is a tiny helper submodule that attaches an admin JavaScript library to the core video media add/edit form.

---

DROWL Media Video (`drowl_media_video`) is the smallest submodule of the DROWL Media project. Its only job is `drowl_media_video_form_media_video_form_alter()`, which attaches the `drowl_media_video/admin` JS library to the `field_media_video_file` widget on the video media form — a client-side helper that (per the source comments) copies an uploaded video's URL into the video embed input, working around core issue #3031542. It has no configuration, routes, permissions, services or config schema, and depends only on the base `drowl_media` module.

---

- Improve the admin experience of the core `video` media add/edit form.
- Attach the `drowl_media_video/admin` JS to the `field_media_video_file` widget.
- Copy an uploaded video file's URL into the embed input (client-side workaround for core #3031542).
- Ship a single minified admin JS asset (`dist/js/drowl_media.admin.video.js`).
- Depend only on the base DROWL Media module.
- Add no configuration, routes, permissions or services.
- Enable alongside DROWL Media when you use the video media type.
- Keep video media handling consistent with the rest of the DROWL media setup.
