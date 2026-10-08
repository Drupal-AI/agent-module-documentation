<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming: the colorbox media remote video formatter

## Theme hook & template

`hook_theme()` (in `src/Hook/ColorboxMediaVideoHooks.php`) registers:

```
colorbox_media_remote_video_formatter
  variables: remote_video, thumb, entity, settings
  template:  colorbox-media-remote-video-formatter.html.twig
  initial preprocess: ColorboxMediaVideoHooks::preprocessColorboxMediaRemoteVideoFormatter
```

Override the template in your theme by copying `colorbox-media-remote-video-formatter.html.twig`
into your theme's `templates/` (clear caches). Twig suggestions follow normal Drupal rules.

## Preprocess: what the template receives

`preprocessColorboxMediaRemoteVideoFormatter(&$variables)` builds:

- `variables['image']` — the launcher render array. It is a `#markup` string of `link_text`
  when `display = text`, the entity label when `display = media_title`, an `image_style`
  themed image when a thumbnail style is set, otherwise a plain `image`.
- `variables['attributes']` — the anchor/launcher attributes, including:
  - `data-colorbox-media-video-modal` — the **rendered** remote video markup Colorbox pops
    into the modal (built by rendering `variables['remote_video']`).
  - `data-colorbox-gallery` — the gallery id from `colorbox.gallery_id_generator` (the
    Colorbox `rel`), present only when a gallery id is produced.
  - `title` — the computed caption (see `colorbox_caption`).
  - `class` — always includes `colorbox-media-video`.
  - `data-cbox-img-attrs` — JSON of the image `title`/`alt` when present.

The caption honours Colorbox's global settings: if the active `colorbox.settings` uses an
example style or `colorbox_caption_trim` is on, long captions are trimmed to
`colorbox_caption_trim_length`.

## Library

The formatter attaches `colorbox_media_video/colorbox-media-video`, which loads
`css/colorbox-media-video.css` and `js/colorbox-media-video.js` and depends on
`colorbox/colorbox`, `system/drupal.system` and `core/once`. Colorbox's own JS/CSS is attached
separately via the `colorbox.attachment` service when it `isApplicable()`.
