<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media types & fields

Installed from `config/install` (new/independent config), `config/optional` (installed only when
deps allow) and `config/override` (config that already exists in core and is overwritten — the
list of overridden IDs is applied in `drowl_media_types_install()`). Enable with:

```bash
composer require drupal/drowl_media --with-all-dependencies
drush en drowl_media_types -y
```

## New media types (`config/install/media.type.*`)

- **slide** (`media.type.slide.yml`) — source `image` (source field `field_media_image`); can also
  hold a video (`field_media_video`). Carries the rich overlay field set (see below).
- **slideshow** (`media.type.slideshow.yml`) — source `slideshow` (the base module's custom source),
  source field `field_media_slides_ref` (entity_reference to slide media). Slick display options via
  `field_slide_arrows/autoplay/dots/infinite/height`.
- **vector_image** (`media.type.vector_image.yml`) — source `image`, source field
  `field_media_image` restricted to **`.svg`** uploads; `field_map` maps `filesize → field_size`.
  Label "Image (Vector)". Has a boolean `field_svg_as_markup` ("Output as SVG markup (Experts)",
  default OFF) that switches the display template between image-formatter output and inline SVG.

## Reconfigured core types (`config/override/media.type.*`)

`image`, `document`, `video` (`field_media_video_file`), `remote_video`
(`field_media_oembed_video`, core oEmbed — no custom HTTP), and `audio` all get DROWL's shared field
set and view/form displays. `drowl_media_types_install()` explicitly overwrites the listed core
form/view displays, field storages (`field_media_document/image/video_file`) and the `video` /
`remote_video` media type config.

## Shared media fields

Storages/fields in `config/install/field.*`. Common across bundles: `field_caption`,
`field_copyright` (link; URL optional via the base module), `field_media_folder` (→ `media_folder`
vocab), `field_media_tags` (→ `media_tags` vocab), `field_mime_type`, `field_size`,
`field_note_internal`, `field_image_caption`, `field_media_image`. Document adds
`field_media_access_by_role` (via `entity_access_by_role_field`) and `field_document_size`.

Slide-specific: `field_image_animation` (ken-burns), `field_image_page_width`,
`field_image_scale_only`, `field_title`, `field_subtitle`, `field_overlay_display`,
`field_overlay_position(_md/_lg)`, `field_overlay_sizing(_md/_lg)`, `field_overlay_button_color`,
`field_overlay_button_style`, `field_overlay_link_button`. Slideshow-specific: `field_media_slides_ref`,
`field_slide_arrows`, `field_slide_autoplay`, `field_slide_dots`, `field_slide_infinite`,
`field_slide_height`, `field_notes`. The list/select allowed values and defaults for the slide/
slideshow fields are supplied dynamically by `DrowlMediaTypesFieldValuesProvider` (see
config/settings.md), not hard-coded in the field storage.

## Other configuration installed

- Vocabularies `taxonomy.vocabulary.media_folder`, `media_tags`.
- Many `image.style.*` (page_width_*, viewport_width_* in sm/md/lg/xl/xxl with crop/scale/2x
  variants, `media_crop`, `thumbnail_micro`, `ratio_16_9`, `zoomed_image_lg`, `blocked_media_teaser`).
- Six `responsive_image.styles.*` (`page_width`, `page_width_crop/scale`, `viewport_width`,
  `viewport_width_crop/scale`) built on the base module's breakpoints.
- Slick optionsets (`media_slideshow`, `columns_2/4/6/8`).
- Crop types `media_crop` and (optional) `focal_point`; extra media view modes; `media_library`
  form/view mode; and (optional) `media_library.settings`, `rabbit_hole` behaviors for the vocabs.

`drowl_media_types.features.yml` marks the module Features-`required` and excludes a few site-specific
configs from export.
