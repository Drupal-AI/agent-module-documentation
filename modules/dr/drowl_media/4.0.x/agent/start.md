<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Media (drowl_media) — agent index

Base module of the DROWL Media project: default Media-entity configuration + enhancements, a custom
**Slideshow** media source, and Media Library / preview styling. Version **4.0.18**, dir `4.0.x`.
Core `^10.3 || ^11`. License GPL-2.0-or-later. Package: none declared.

## Dependencies (from `drowl_media.info.yml`)

Core `media`, `media_library`, `breakpoint`, `taxonomy`, `user`; contrib
`views_bulk_operations`. Runtime `hook_requirements` also expects the external asset library
**`npm-asset/drowl-admin-iconset`** at `/libraries/drowl-admin-iconset/style.css` (installed via
asset-packagist) or the status report shows an error.

## What it provides

- **Media source plugin** `slideshow` (`src/Plugin/media/Source/Slideshow.php`) — a multi-item media
  source over an `entity_reference` field. Not a new plugin *type*, an instance of core's media
  source plugin type. Config schema `media.source.slideshow` (`config/schema/drowl_media.schema.yml`).
- **Validation constraint** `ItemsCount` (`src/Plugin/Validation/Constraint/ItemsCountConstraint.php`
  + `...Validator.php`) — requires the slideshow source field to be non-empty.
- **MediaDuplicatesChecksum plugin** `slideshow` (`src/Plugin/MediaDuplicatesChecksum/Slideshow.php`)
  — checksum = pipe-joined UUIDs of referenced slides (for the contrib `media_duplicates` module).
- **Breakpoints** `drowl_media.small|medium|large|xlarge|xxlarge` (`drowl_media.breakpoints.yml`).
- **Optional view** `media_library` (`config/optional/views.view.media_library.yml`) — replaces core's
  with folder/tag exposed filters + grid/table widget displays.
- **Libraries + hooks** (`drowl_media.libraries.yml`, `drowl_media.module`) — per-bundle frontend CSS,
  admin Media Library / VBO restyle, entity-embed image-style narrowing, copyright-link tweak,
  "Create new Slideshow" button. Install copies generic icons; `.install` holds legacy update hooks.
- No routes, no permissions, no Drush, no services of its own.

## Solution docs

- The Slideshow source, ItemsCount constraint and duplicates checksum →
  [plugins/slideshow.md](plugins/slideshow.md)
- Breakpoints, the media_library view, libraries, hooks and install behavior →
  [config/site-integration.md](config/site-integration.md)

## Submodules (own nested doc trees)

- **drowl_media_types** → `modules/drowl_media_types/4.0.x/agent/start.md` — all media types, fields,
  view modes, image styles, templates (incl. the SVG vector-image type) and the settings form.
- **drowl_media_video** → `modules/drowl_media_video/4.0.x/agent/start.md` — admin-JS video helper.
