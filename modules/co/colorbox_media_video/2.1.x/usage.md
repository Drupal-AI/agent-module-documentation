<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Colorbox Media Video adds a field formatter that renders a core Media Remote Video (oEmbed) as a clickable thumbnail (or text link) which opens the video inside a Colorbox modal, with optional galleries and captions.

---

The module ships a single field formatter plugin, `colorbox_media_remote_video`, that applies to `link`, `string` and `string_long` fields — in practice the oEmbed source field (`field_media_oembed_video`) of the core **Remote Video** media type. It extends core's OEmbed formatter: for each item it builds the normal remote-video render array, then wraps it in a launcher (a thumbnail image, a text link, or the media title) whose `data-colorbox-media-video-modal` attribute holds the rendered video so Colorbox can pop it in a modal. It reuses Colorbox's own services — `colorbox.gallery_id_generator` to compute the `rel`/gallery id and `colorbox.attachment` to attach Colorbox's JS/CSS — and adds its own library `colorbox_media_video/colorbox-media-video`. Formatter settings let you choose the launcher (`display`: thumbnail / text / media_title), the thumbnail `image_style`, a `link_text` for text mode, a gallery grouping strategy (`colorbox_gallery`: post / page / field_post / field_page / custom / none, with `colorbox_gallery_custom` tokens), and a caption source (`colorbox_caption`: auto / title / alt / entity_title / custom / none, with `colorbox_caption_custom` tokens). Custom gallery ids and captions support token replacement when the `token` module is installed. Rendering goes through the `colorbox_media_remote_video_formatter` theme hook and its preprocess in `ColorboxMediaVideoHooks`, which also honours Colorbox's global caption-trimming settings. There is no settings page or configure route; you enable it per view display on the Remote Video media type's *Manage display*.

---

- Open a YouTube or Vimeo Remote Video in a Colorbox lightbox instead of an inline iframe.
- Show a grid of video thumbnails that each pop the clip in a modal overlay.
- Use a text link ("View Video" / custom label) to launch a remote video modal.
- Launch the video modal from the media entity's title instead of a thumbnail.
- Apply an image style to the video thumbnail (e.g. a cropped 16:9 teaser).
- Group several videos on a node into one Colorbox gallery so users can page next/previous.
- Create a per-page gallery of every remote video shown on a listing page.
- Group videos per field instance rather than per whole post or page.
- Build a custom gallery id from tokens (e.g. one gallery per taxonomy term) with the token module.
- Add captions to the lightbox pulled automatically from title, alt text, or the media title.
- Force the caption to the media entity's content title for consistent labelling.
- Write a custom token-based caption (e.g. "[media:name] — [media:field_credit]").
- Respect Colorbox's global caption-trim length for long video titles.
- Present a video teaser view mode where the thumbnail opens the trailer in a modal.
- Replace the default inline oEmbed player on Remote Video with a lightbox launcher.
- Reuse Colorbox styling/skin already configured site-wide for image lightboxes on videos too.
- Show video galleries in a Views listing by selecting the formatter on the Remote Video field.
- Combine remote videos and Colorbox image galleries under the same modal experience.
- Give editors a no-code way to make video fields open in a modal via Manage display.
- Export the view-display formatter config for repeatable deployment across environments.
- Provide accessible alt/title-driven captions on video modals for screen-reader context.
- Configure different launchers (thumbnail vs text) per view mode of the same media type.
