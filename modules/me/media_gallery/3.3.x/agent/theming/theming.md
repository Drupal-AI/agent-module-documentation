<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming

## Theme hooks (`media_gallery_theme()`)

| Hook | Kind | Template |
|---|---|---|
| `media_gallery` | render element `elements` | `templates/media-gallery.html.twig` |
| `views_view_unformatted__media_galleries` | base hook `view` | `templates/views-view-unformatted--media-galleries.html.twig` |
| `block__media_gallery_latest_items_all_galleries` | render element `elements`, base hook `block` | `templates/block--media-gallery-latest-items-all-galleries.html.twig` |

## Template suggestions (`media_gallery_theme_suggestions_media_gallery()`)

For a rendered gallery entity, in addition to `media_gallery`:

```
media_gallery__<view_mode>
media_gallery__<bundle>
media_gallery__<bundle>__<view_mode>
media_gallery__<id>
media_gallery__<id>__<view_mode>
```

## Preprocess

`media_gallery_preprocess_media_gallery()` exposes `content` (all child render elements) and the
`media_gallery` entity, then applies the entity's own display options:
- If `use_pager` is on, it paginates the `images` field to `items_per_page` (default 12) via
  `MediaGalleryUtilities::paginateMediaGallery()` and adds a `pager` render element.
- Else if `reverse` is on, it reverses the image order.
- It resolves the images field whether the gallery is rendered normally or inside **Layout
  Builder** (via `MediaGalleryUtilities::getLayoutBuilderImagesField()`, matching derivative
  `media_gallery:media_gallery:images`).

`media_gallery_preprocess_field()`:
- Adds the `photoswipe-gallery` class to the gallery's `images` field wrapper (entity type
  `media_gallery`), and calls `MediaGalleryUtilities::alterNonImageMediaRendering()` so **non-image
  media** (video files, oEmbed/YouTube/Vimeo) render with an appropriate formatter instead of the
  image-only PhotoSwipe output.
- Removes the redundant `photoswipe-gallery` class from each individual `field_media_image` when
  the media is shown in the `photoswipe` view mode.

## Libraries (`media_gallery.libraries.yml`)

| Library | CSS |
|---|---|
| `media_gallery/media_gallery` | `css/media_gallery.css` (component) |
| `media_gallery/media_gallery_block` | `css/gallery_block.css` (theme) — attached by the blocks |
| `media_gallery/admin` | `css/media_gallery.admin.css` (theme) — attached by block config forms |

Layout preview icons are SVGs in the module's `icons/` directory, referenced by each layout
plugin's `preview_icon`.
