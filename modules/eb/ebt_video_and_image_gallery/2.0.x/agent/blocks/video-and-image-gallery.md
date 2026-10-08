<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Video and Image Gallery block type

All structure ships as default config in `config/install/`; there is no admin settings form and no
custom code path for rendering — everything uses core entity/field display plus contrib formatters.

## Install / enable

```bash
composer require drupal/ebt_video_and_image_gallery -W
drush en ebt_video_and_image_gallery -y
```

`hook_requirements()` (`ebt_video_and_image_gallery.install`) blocks install (RequirementSeverity::Error)
unless the core Media `image` AND `remote_video` media types both exist. Dependencies `ebt_core`, `media`,
`glightbox`, `glightbox_media_video`, `paragraphs` must be installable (the `field_ebt_settings` field and
`ebt_settings` field type come from `ebt_core`).

## Data model

- **Block content type** `ebt_video_and_image_gallery`
  (`block_content.type.ebt_video_and_image_gallery.yml`). Fields on it:
  - `body` — `text_with_summary`, `text_default` formatter.
  - `field_ebt_settings` — `ebt_settings` (from EBT Core); default value seeds EBT design options
    (margins/border/padding/background/container). Widget: `ebt_settings_video_and_image_gallery`
    (see plugins/settings-widget.md). Not rendered in the block markup (`content|without('field_ebt_settings')`).
  - `field_ebt_videos_and_images` — `entity_reference_revisions` → Paragraph, cardinality `-1`
    (`field.storage.block_content.field_ebt_videos_and_images.yml`); target bundle
    `ebt_video_and_image_gallery_item`. Display formatter `entity_reference_revisions_entity_view`
    (view mode `default`).

- **Paragraph type** `ebt_video_and_image_gallery_item`
  (`paragraphs.paragraphs_type.ebt_video_and_image_gallery_item.yml`). Fields:
  - `field_video_gallery_item` — `entity_reference` → Media, cardinality 1
    (`field.storage.paragraph.field_video_gallery_item.yml`). `handler_settings.target_bundles`:
    `image`, `remote_video` (`auto_create: false`). Rendered via `entity_reference_entity_view`
    in the `video_and_image_gallery_item` media view mode.
  - `field_gallery_item_description` — `text_long` caption, `text_default` formatter, label hidden.

## Media rendering (view mode `video_and_image_gallery_item`)

- **image** (`core.entity_view_display.media.image.video_and_image_gallery_item.yml`):
  `field_media_image` uses the **`glightbox`** formatter (glightbox module), node image style
  `ebt_video_and_image_gallery`, `glightbox_gallery: paragraph`, `glightbox_caption: auto`.
- **remote_video** (`core.entity_view_display.media.remote_video.video_and_image_gallery_item.yml`):
  `field_media_oembed_video` uses the **`glightbox_media_remote_video`** formatter
  (glightbox_media_video module), thumbnail image style `ebt_video_and_image_gallery`,
  `glightbox_gallery: paragraph`, eager loading. This is a core oEmbed video field — the URL is a
  provider-validated oEmbed resource, not free text.
- **Image style** `ebt_video_and_image_gallery.yml`: single `image_scale_and_crop` effect,
  480x360, anchor center-center — used for both image and video thumbnails.

## Rendering / theming

- Block templates: `block--block-content--ebt-video-and-image-gallery.html.twig` and
  `block--inline-block--ebt-video-and-image-gallery.html.twig`. Both build `classes` including
  `ebt-block-video-and-image-gallery` and, when set, the per-block `styles` value
  (`content.field_ebt_settings['#object'].field_ebt_settings.ebt_settings.styles`) so grid CSS can
  target it; then attach library `ebt_video_and_image_gallery/ebt_video_and_image_gallery` and print
  `content|without('field_ebt_settings')`. The trailing `{{ styles|raw }}` is the EBT Core
  per-block generated CSS variable block (produced/escaped by ebt_core, not this module).
- Field template `field--block-content--field-ebt-video-and-image-gallery--ebt-video-gallery-item.html.twig`
  is a standard field wrapper adding class `ebt-image-gallery-wrapper`; each item prints core-rendered
  `{{ item.content }}`.
- CSS (`css/ebt_video_and_image_gallery.css`) implements the grid layouts keyed off the `styles`
  class: `one_column`…`five_columns`, `fixed_size_image`, `fluid_grid`, `featured_images_grid`.

## Notes

- The description says "PhotoSwipe support" and `libraries.yml` also declares an `ebt_photo_swipe`
  library pointing at `/libraries/photo-swipe/…`, but that library is **not attached** by any template
  or code here; the shipped display uses GLightbox formatters. Treat PhotoSwipe as optional/legacy.
- Provides no routes, permissions, services, hooks (beyond `hook_requirements`), or Drush commands.
- No `config/schema/` — the `ebt_settings` schema is owned by `ebt_core`.
