<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GLightbox Media Video (glightbox_media_video) — agent index

Two field formatters that open core Media **Video** / **Remote Video** items in a GLightbox
popup. Requires `media` (core) and the `glightbox` contrib module. No config form, no
permissions, no config schema, no Drush — everything is per-view-display formatter settings.

- **The two formatters, every setting, and how to configure them from Drush** →
  [configure/formatters.md](configure/formatters.md)
- **Theme hooks, markup, library, and the URL alter hook (with its bug)** →
  [theming/markup-and-hooks.md](theming/markup-and-hooks.md)

Key facts:
- **`glightbox_media_remote_video`** — *GLightbox Media Remote Video*. Extends core's
  `OEmbedFormatter`, so `defaultSettings()` = OEmbed's settings **plus** the GLightbox ones.
  Target: `field_media_oembed_video` on the `remote_video` media bundle.
- **`glightbox_file_video`** — *GLightbox Video Popup*. Target: the video file field on the
  `video` media bundle. Extra settings `muted` (FALSE), `width` (640), `height` (480).
- Shared settings: `display` (`thumbnail`|link), `link_text` ('View Video'), `image_style`
  ('thumbnail'), `glightbox_gallery` ('post'), `glightbox_gallery_custom` (''),
  `glightbox_caption` ('auto'), `glightbox_caption_custom` (''), plus
  `glightbox_caption_description` / its custom variant, and — file formatter only —
  `thumbnail_source_field` and `thumbnail_source_image_style`.
- Markup: `<a class="glightbox glightbox-media-video" href="…" data-glightbox="title: …"
  data-gallery="…">` wrapping the thumbnail or link text. Gallery grouping is the
  `data-gallery` attribute.
- **YouTube URLs are rewritten to `https://www.youtube-nocookie.com/embed/{id}`** by
  `_glightbox_media_video_extract_youtube_video_id()` before the alter hook runs. Other providers
  keep their oEmbed URL (there is a `@todo` in the source about handling them).
- Local video `href` is the **absolute** file URL
  (`file_url_generator->generateAbsoluteString()`).
- Library `glightbox_media_video/glightbox-media-video` depends on `glightbox/glightbox`,
  `system/drupal.system`, `core/once`.
- **Hook naming bug:** `glightbox_media_video.api.php` documents
  `hook_glightbox_media_video_url_alter(string &$video_url)`, but the preprocessor calls
  `\Drupal::moduleHandler()->alter('url', $href)` — i.e. it actually invokes **`hook_url_alter()`**.
  See [theming/markup-and-hooks.md](theming/markup-and-hooks.md) before writing an implementation.
