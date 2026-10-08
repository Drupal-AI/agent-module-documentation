<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display templates

Bootstrap-5 Twig templates in `templates/` (frontend) and `templates/media-library/` (admin media
library). Registered in `drowl_media_types_theme()` and selected via
`drowl_media_types_theme_suggestions_media_alter()`, which adds suggestions
`media__drowl_media_types`, `…__{view_mode}`, `…__{bundle}`, `…__{bundle}__{view_mode}`.

## Base template

`media--drowl-media-types.html.twig` — wraps media in an `<article>` with alignment/bundle/view-mode
classes, includes an unpublished-label partial (`inc/__unpublished_label.html.twig`), and renders
`{{ content }}` in a `content` block. Most bundle templates `extend` it and override `content`.

## Bundle templates

- **document** (`…--document.html.twig` + `--card/--tile/--button/--media-object`) — maps the media's
  `field_mime_type` to a micon file-icon class and renders `field_media_document` as a styled
  download button/link (label = file description or filename). Uses `media_link_attributes` set in
  `_drowl_media_types_preprocess_media_document()`.
- **slide** (`…--slide.html.twig`) — the largest template. Builds a media wrapper (image via
  `content.field_media_image`, or video, with a ken-burns `animation-wrapper` when
  `field_image_animation` is set; switches to `*_scale` responsive image styles when
  `field_image_scale_only` is on) and an optional overlay box positioned via Bootstrap flex classes
  derived from `field_overlay_position(_md/_lg)`, colored by `field_overlay_display`, sized by
  `field_overlay_sizing*`, with title/subtitle/caption and a link button
  (`field_overlay_link_button`). The overlay is rendered to a string and printed only when it has
  real content; it shows an admin-only Radix `alert` when a full-size overlay would hide the media.
- **slideshow** (`…--slideshow.html.twig`) — renders `field_media_slides_ref` through Slick;
  `_drowl_media_types_preprocess_media_slideshow()` + `drowl_media_types_preprocess_slick()` merge
  per-media `field_slide_*` values into the `data-slick` JSON (overriding the `media_slideshow`
  optionset), and attach the `drowl_media_types/slideshow` JS library.
- **remote_video** / **video** (`…--remote-video.html.twig`, `…--video.html.twig`) — render
  `content` with `field_media_image` removed (`content|without('field_media_image')`). Remote video
  uses core's oEmbed field (no custom HTTP).
- **vector_image** (`…--vector-image.html.twig`) — overrides `content`. When the media's
  `field_svg_as_markup` boolean is **off** (the default) it renders `{{ content }}` (the SVG via the
  image formatter, `svg_render_as_image: true` from the `svg_image` module → an `<img>`). When
  **on** ("Output as SVG markup (Experts)", per that field's own description) it instead embeds the
  SVG file's contents inline inside a `div.media-vector-image__markup`, using the file's `title` as
  `aria-label`.

## Media-library templates

`templates/media-library/media--drowl-media-types*--media-library.html.twig` restore the Claro/Gin
media-library item markup for each bundle (needed because DROWL's suggestions would otherwise take
precedence over the core media-library templates in the admin UI).
