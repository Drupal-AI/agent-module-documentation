<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Block Types (EBT): Video (ebt_video) — agent index

Installs an `ebt_video` custom **block content type** that embeds a single Media video — a remote
video (oEmbed: YouTube/Vimeo) or a locally uploaded video file — with EBT Core design options.
Remote videos render as a thumbnail + play-button that opens a GLightbox popup. Package
*Extra Block Types*. Core `^10.1 || ^11 || ^12`. License GPL-2.0-or-later. Version 2.0.x.

- **Depends on:** `media`, `ebt_core`, `glightbox`, `glightbox_media_video`, `paragraphs`
  (Composer: `drupal/ebt_core:^2.0`, `drupal/glightbox:^1.0`, `drupal/glightbox_media_video:^1.0`,
  `drupal/paragraphs:^1.0`).
- **The block type, fields, form/view displays, media view mode, install requirement** →
  [config/block-type.md](config/block-type.md)
- **The `ebt_settings_video` field widget** → [fields/widget.md](fields/widget.md)
- **How the video is rendered (formatters, templates, CSS, GLightbox)** →
  [display/rendering.md](display/rendering.md)

## What it actually is

- **Config-driven block type.** All of the block type, fields, storage, form display, view
  display, media view mode and per-bundle media view displays are shipped as `config/install/*`
  YAML — no entity/plugin code creates them.
- **One PHP class:** `EbtSettingsVideoWidget` (id `ebt_settings_video`), a thin subclass of
  `ebt_core`'s `EbtSettingsDefaultWidget` — see `src/Plugin/Field/FieldWidget/`.
- **One hook:** `ebt_video_requirements()` in `ebt_video.install` — blocks install unless a
  `remote_video` media type exists.
- **No routes, no permissions, no services, no Drush, no config schema of its own** (the
  `ebt_settings` field type/schema belong to `ebt_core`).

## Block type `ebt_video`

- Fields: `field_ebt_video` (entity_reference → `media`, bundles `video` + `remote_video`,
  cardinality 1), `body` (text_with_summary), `field_ebt_settings` (`ebt_settings`, from
  `ebt_core`).
- Edit form: two `field_group` tabs — **Content** (info, body, `field_ebt_video` via
  `media_library_widget`) and **Settings** (`field_ebt_settings` via `ebt_settings_video`).
- Assets: `css/ebt-video.css` (attached as library `ebt_video/ebt_video`) + `img/play.svg`.
