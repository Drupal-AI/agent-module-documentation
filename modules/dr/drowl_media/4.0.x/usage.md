<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DROWL Media is the base module of the DROWL Media project: it ships default Media-entity configuration plus a custom Slideshow media source and Media Library / media-preview styling enhancements.

---

DROWL Media (from the DROWL / webks agencies) gives a Drupal 10.3/11 site an opinionated media baseline. The base module itself provides the `slideshow` media **source** plugin (multiple slides referenced from one media entity), an `ItemsCount` validation constraint enforcing at least one slide, a `slideshow` **MediaDuplicatesChecksum** plugin (for the optional `media_duplicates` module), a set of responsive-image **breakpoints**, an enhanced core `media_library` **view** (folder/tag exposed filters, table + grid widget displays), and CSS/JS libraries that restyle the Media Library and Views Bulk Operations bar for the Gin (preferred) or Claro admin theme. It copies generic media icons on install and depends on core `media`, `media_library`, `breakpoint`, `taxonomy`, `user` plus contrib `views_bulk_operations`. The heavy lifting (media types, fields, view modes, image styles, templates) lives in the `drowl_media_types` submodule; `drowl_media_video` adds a small admin-JS helper for video. Media access is entirely core's — this module adds no access control of its own.

---

- Add a "Slideshow" media type backed by the custom `slideshow` media source (one media entity references many slides).
- Enforce that every slideshow has at least one slide via the `ItemsCount` validation constraint.
- Derive a slideshow's default name and thumbnail from its referenced slides.
- Detect duplicate slideshows by their ordered list of referenced slide UUIDs (with the `media_duplicates` module).
- Restyle the core Media Library grid and item previews for the Gin or Claro admin theme.
- Replace the core `media_library` view with one exposing media-folder and media-tag filters.
- Provide a table widget display for the Media Library in addition to the grid.
- Show a media "type" badge and a "#ID" column in the Media Library.
- Restrict the entity-embed image-style options to a small preferred set (25% / 50% page width).
- Add a "Create new Slideshow" button next to the slideshow media-library reference widget.
- Make the media `field_copyright` link accept a license text with no URL.
- Provide responsive-image breakpoints (small / medium / large / x-large / xx-large).
- Attach per-bundle frontend CSS (documents, video, slideshow) automatically on media render.
- Copy generic file-type media icons into the public files directory on install.
- Extend the Views Bulk Operations action bar styling inside the Media Library.
- Bootstrap a consistent media setup across DROWL sites without hand-building each type.
- Serve as the foundation for the DROWL Media Types and DROWL Media Video submodules.
- Ship default config schema for the slideshow media source.
- Keep media/file access delegated to Drupal core (no custom access layer).
- Provide a reusable base for higher-level DROWL feature modules (e.g. header slides).
