<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Gallery adds a dedicated `media_gallery` content entity that groups core Media items into a gallery and renders them as a PhotoSwipe lightbox, with an "All Galleries" listing page and two placeable gallery blocks.

---

The module defines its own `media_gallery` content entity (base table `media_gallery`) whose base fields include a title, description, an unlimited `images` entity-reference field that points at core `media` items through the Media Library widget, plus `use_pager`, `items_per_page`, `reverse`, author and published flags. Galleries are created and listed at `/admin/content/media-gallery`, viewed at `/media_gallery/{id}`, and a shipped View (`media_galleries`) exposes an "All Galleries" page at `/galleries`. On display the `images` field uses the PhotoSwipe field formatter so clicking a thumbnail opens a lightbox; the module ships an `media_gallery_image` (300x180) image style and a `full_gallery` view mode as defaults. Two blocks — "Media Gallery" (`media_gallery_gallery`, one chosen gallery) and "Latest gallery items from all galleries" (`media_gallery_latest_items_all_galleries`) — render galleries through a pluggable layout system. That layout system is a real attribute-based plugin type (`MediaGalleryLayout`) managed by `media_gallery.layout_manager`, shipping Grid, Featured image grid, Horizontal, Vertical and Swiper layouts. The module has nine permissions, a `field_ui_base_route` so you can add your own fields to galleries, a Pathauto alias type for gallery URLs, and theme hooks/templates that add the `photoswipe-gallery` wrapper and handle non-image media (video/oEmbed) and pagination. Two optional migration submodules import Drupal 7 Media galleries.

---

- Group a set of images into a named gallery and show them as a PhotoSwipe lightbox.
- Build an "All Galleries" index page for site visitors at `/galleries`.
- Add a "Media Gallery" block that displays one specific gallery in a region.
- Add a "Latest gallery items from all galleries" block showing the newest media across every gallery.
- Choose a Grid, Featured image grid, Horizontal, Vertical or Swiper layout per block.
- Set the number of grid columns for a gallery block's Grid layout.
- Paginate large galleries with a configurable items-per-page pager.
- Reverse the display order of photos in a gallery without re-sorting the field.
- Mix images with video or oEmbed (YouTube/Vimeo) media in one gallery and render each correctly.
- Attach custom fields (e.g. a caption or category) to the gallery entity via Manage fields.
- Apply the shipped `media_gallery_image` 300x180 image style to gallery thumbnails.
- Give editors granular create/edit/delete-own vs delete-any control through the nine permissions.
- Restrict who can see unpublished galleries with the view-unpublished permission.
- Generate clean gallery URLs automatically using the bundled Pathauto alias type.
- Register a custom gallery layout plugin by adding a `#[MediaGalleryLayout]` class.
- Alter the available layout plugin definitions with the `media_gallery_layout_info` alter hook.
- Override a gallery's markup with `media-gallery.html.twig` and per-view-mode/per-bundle suggestions.
- Display a gallery inside Layout Builder while keeping the PhotoSwipe pager working.
- Add a "View all" link (top/bottom/left/right/under title) with custom CSS classes to a gallery block.
- Pick separate thumbnail and PhotoSwipe modal image styles per block.
- Swap PhotoSwipe for Colorbox on gallery items by adding a Colorbox view mode/formatter.
- Translate gallery titles and descriptions on a multilingual site (the entity is translatable).
- Import a legacy Drupal 7 Media 7.x-1.x gallery into `media_gallery` entities via the migration submodule.
- Import a legacy Drupal 7 Media 7.x-2.x gallery via the alternate migration submodule.
- Query which media items belong to a gallery for a custom block or report.
- Feature one hero image spanning multiple columns using the Featured image grid layout.
- Present a swipeable carousel of gallery items with the Swiper layout (via swiper_formatter).
- Show only published media in a gallery block, newest first, capped at a chosen item count.
