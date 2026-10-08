<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GLightbox Media Video adds two field formatters that open core Media **Video** (local file) and **Remote Video** (oEmbed) items in a GLightbox popup, launched from a thumbnail or a text link, with optional gallery grouping and captions.

---

The GLightbox module itself handles images; this module extends it to the two core video media types. `glightbox_media_remote_video` formats the `field_media_oembed_video` string field on Remote Video media, extending core's `OEmbedFormatter` so all its settings remain available, and `glightbox_file_video` formats the `field_media_video_file` file field on local Video media (settings include muted, width, height). Both add the same GLightbox layer: a **Display** choice (thumbnail or text link), **Link text** for the link variant, an **image style** for the thumbnail, a **Gallery (video grouping)** selector — post/custom/none, mapping to GLightbox's `rel` behaviour via a `data-gallery` attribute — plus **Caption** and **Caption description** selects with custom-token variants (with a replacement-patterns fieldset when Token is available). The local-video formatter additionally lets you pick a **custom thumbnail source field** on the media entity and an image style for it, which is the practical answer to local videos having no usable auto-thumbnail. Rendering goes through two theme hooks (`glightbox_media_remote_video_formatter`, `glightbox_media_file_video_formatter`) whose preprocessors in `glightbox_media_video.theme.inc` assemble the anchor: classes `glightbox glightbox-media-video`, `href` set to the oEmbed URL (YouTube URLs are rewritten to `https://www.youtube-nocookie.com/embed/{id}`) or to the absolute file URL, `title`/`data-glightbox` from the caption settings, and `data-gallery` when grouping is on. The `glightbox-media-video` library (its own CSS/JS plus `glightbox/glightbox`, `system/drupal.system` and `core/once`) initialises the popups. The module declares no permissions, no config schema and no config form — everything is per-display formatter settings.

---

- Open a YouTube or Vimeo remote video in a lightbox instead of embedding it inline.
- Play an uploaded MP4 in a popup launched from its poster image.
- Build a video gallery where each thumbnail opens in the same lightbox carousel.
- Group all videos on a node into one gallery with the post-based grouping option.
- Create a named gallery shared across several fields with the custom gallery id.
- Show a text link ("Watch the video") instead of a thumbnail.
- Use an image style so all video thumbnails render at the same size.
- Give local videos a proper poster by pointing the formatter at a custom image field.
- Serve YouTube embeds through youtube-nocookie.com for a lighter privacy footprint.
- Add a caption to the lightbox from the media name or a custom token string.
- Add a longer description under the lightbox caption.
- Keep core's oEmbed formatter settings (max width/height) while adding the lightbox.
- Mute local videos that autoplay in the popup.
- Set explicit width/height for the popup player.
- Reuse one media item in several displays with different lightbox settings per view mode.
- Present a product page's videos as a click-to-play grid rather than heavy inline players.
- Avoid loading a third-party video iframe until the visitor actually clicks.
- Theme the popup trigger by overriding either of the two Twig templates.
- Alter the video URL before it reaches the lightbox from a custom module.
- Combine remote and local videos in a single gallery on the same page.
