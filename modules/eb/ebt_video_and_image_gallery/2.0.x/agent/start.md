<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Block Types (EBT): Video and Image Gallery (ebt_video_and_image_gallery) — agent index

Extra Block Types (EBT) block type that renders a responsive grid mixing core `image` media and
`remote_video` (oEmbed) media, each opening in a GLightbox lightbox. Presentation only — no routes,
permissions, services, or Drush commands; adds no config page.

- **Version:** 2.0.0 (dir `2.0.x`). **Core:** `^10.1 || ^11 || ^12`. **License:** GPL-2.0-or-later.
- **Dependencies (info.yml):** `ebt_core:ebt_core`, `drupal:media`, `glightbox:glightbox`,
  `glightbox_media_video:glightbox_media_video`, `paragraphs:paragraphs`.
- **Composer require:** `drupal/ebt_core ^2.0`, `drupal/glightbox ^1.0`,
  `drupal/glightbox_media_video ^1.0`, `drupal/paragraphs ^1.0`.

## What it provides (all via `config/install/`, no schema of its own)

- **Block content type** `ebt_video_and_image_gallery` with fields `body`, `field_ebt_settings`
  (from EBT Core), and `field_ebt_videos_and_images`.
- **`field_ebt_videos_and_images`** — `entity_reference_revisions` → Paragraph, cardinality `-1`,
  targets the `ebt_video_and_image_gallery_item` bundle.
- **Paragraph type** `ebt_video_and_image_gallery_item` with:
  - `field_video_gallery_item` — `entity_reference` → Media, cardinality 1, target bundles
    `image` + `remote_video`.
  - `field_gallery_item_description` — `text_long` (caption), `text_default` formatter.
- **Media view mode** `video_and_image_gallery_item` with per-bundle displays: `image` →
  `glightbox` formatter; `remote_video` → `glightbox_media_remote_video` formatter (both group
  `glightbox_gallery: paragraph`).
- **Image style** `ebt_video_and_image_gallery` (scale-and-crop 480x360).
- **Field widget plugin** `ebt_settings_video_and_image_gallery`
  (`src/Plugin/Field/FieldWidget/EbtSettingsVideoAndImageGalleryWidget.php`) extending EBT Core's
  `EbtSettingsDefaultWidget`; adds the `styles` layout selector.
- **Templates** (`templates/`): two block templates (block-content + inline-block) and one field
  template; library `ebt_video_and_image_gallery/ebt_video_and_image_gallery` (grid CSS).
- **`hook_requirements()`** (`.install`) — install-time check that `image` and `remote_video`
  media types exist.

## Solution docs

- [blocks/video-and-image-gallery.md](blocks/video-and-image-gallery.md) — block type, fields,
  Paragraph item, media view displays, image style, templates, install/enable.
- [plugins/settings-widget.md](plugins/settings-widget.md) — the `ebt_settings_video_and_image_gallery`
  field widget and its `styles` options.
