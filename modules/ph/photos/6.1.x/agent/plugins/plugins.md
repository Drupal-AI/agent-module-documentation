<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins Photos provides

Photos does **not** define new plugin *types*; it provides implementations of core plugin types.

## Field formatters (`src/Plugin/Field/FieldFormatter/`)

- `PhotosAlbumFormatter` — renders an album (its images) from an image/entity-reference field.
- `PhotosAlbumCoverImageFormatter` — renders just the album cover image.
- `PhotosImageMediaFieldFormatter` — formatter for photos exposed through Media.

## Block (`src/Plugin/Block/`)

- `PhotosInformation` ("Photos information") — a block with photo/album stats/links.

## Text-format filter (`src/Plugin/Filter/`)

- `PhotosFilter` — a filter you enable on a text format to embed a photo or album inside rich
  text (see the format's filter settings once enabled).

## Media source (`src/Plugin/media/Source/`)

- `Photos` — a Media source so photos can be used as media entities / in the media library.
  `hook_media_source_info_alter()` also adjusts media sources.

## Search (`src/Plugin/Search/`)

- `PhotosImageSearch` — a Search plugin indexing/searching `photos_image` entities (core Search).

## Views (`src/Plugin/views/`)

- `field/PhotosImageCover` — a Views field for the album cover.
- `field/PhotosImageSetCover` — a Views field/link to set a photo as the album cover.
- `PhotosViewsData` (entity views_data handler) + `hook_views_data_alter()` add photo/album data
  to Views.

## Migrate (`src/Plugin/migrate/`) — Drupal 7 → 10/11

- Sources: `source/Photos`, `source/PhotosImage`, `source/PhotosComment`, `source/PhotosCount`.
- Destinations: `destination/Photos`, `destination/PhotosImage`, `destination/PhotosComment`,
  `destination/PhotosCount`.

Use these with the standard Migrate/Migrate Drupal workflow to bring legacy albums, images,
comments and counters forward.

## Theme

`hook_theme()` registers templates (album view, image html/block, album links, default, etc.)
plus `hook_theme_suggestions_photos_image()` and several `hook_preprocess_*` — override the
`photos_*` templates in your theme to restyle albums/photos.
