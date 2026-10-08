<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DDECK Plyr & Advanced Media (ddeck_advanced_media) — agent index

Field-formatter-first media display. Provides Plyr audio/video/remote-video formatters and a PhotoSwipe image-gallery formatter, plus an `image_gallery` media source. No routes, permissions, config forms, or content types are added — everything is configured on entity **Manage display** pages. Version `1.0.0-alpha5`, `core_version_requirement: ^10 || ^11`, package `ddeck`, license GPL-2.0-or-later.

**Dependencies:** `media`, `media_library`, `ckeditor5`, `image` (core). Front-end libs Plyr and PhotoSwipe must be installed under `/libraries/` (see `ddeck_advanced_media.libraries.yml`).

## What it provides
- **Field formatters** (`src/Plugin/Field/FieldFormatter/`):
  - `DdeckPlyrFileAudioFormatter` — id `ddeck_advanced_media_file_audio`, field type `file`, media type `audio`.
  - `DdeckPlyrFileVideoFormatter` — id `ddeck_advanced_media_file_video`, field type `file`, media type `video`.
  - `DdeckPlyrRemoteVideoFormatter` — id `ddeck_advanced_media_remote_video`, field types `link`/`string`/`string_long`; resolves YouTube/Vimeo via the core oEmbed URL resolver.
  - `PhotoswipeMediaGalleryFormatter` — id `photoswipe_media_gallery`, field type `image`.
  - `DdeckPlyrFormatterBase` (abstract) + `DdeckPlyrSharedFormatterTrait` — shared JSON settings decode, defaults, settings form/summary.
- **Media source:** `ImageGallery` (id `image_gallery`, `src/Plugin/media/Source/`) — file/image source for reusable gallery media types.
- **Theme hooks** (`ddeck_advanced_media.module`): `ddeck_advanced_media_file_audio`, `_file_video`, `_file_remote_video`, `photoswipe_media_gallery` (Twig in `templates/`).
- **SDC components** (`components/`): `ddeck_advanced_media:plyr`, `ddeck_advanced_media:media_gallery`.
- **`hook_library_info_alter()`:** injects `css/ckeditor5.css` into CKEditor 5's stylesheet library.
- **Libraries** (`*.libraries.yml`): `plyr-player`, `photoswipe`, `advanced-media-gallery`, `ckeditor5`.

## Solution docs
- [Field formatters & Plyr JSON settings](fields/formatters.md) — the four formatters, the JSON settings schema, image-style options, templates.
- [Media source, components & CKEditor integration](plugins/media-source.md) — `image_gallery` source, SDC components, theme hooks, `hook_library_info_alter()`, library setup.
