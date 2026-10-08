<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Gallery — agent index

Provides a **`media_gallery` content entity** (base table `media_gallery`, data table
`media_gallery_field_data`) that groups core **Media** items and renders them as a **PhotoSwipe**
lightbox. Depends on `text`, `media_library`, `photoswipe` (>=5). Manage galleries at
`/admin/content/media-gallery`; visitors browse them at `/galleries` (shipped View
`media_galleries`). Config UI route = `entity.media_gallery.settings`
(`/admin/structure/media-gallery`, also the `field_ui_base_route`). Nine permissions, one plugin
type, two blocks, a Pathauto alias type. No Drush commands. Runs on **Drupal 10, 11 and 12**.

- **Create/manage galleries, entity fields, shipped config (image style, view mode, `/galleries` view)** →
  [configure/galleries.md](configure/galleries.md)
- **The two gallery blocks and their settings (layout, image styles, "View all" link)** →
  [configure/blocks.md](configure/blocks.md)
- **The `MediaGalleryLayout` plugin type — built-in layouts and how to add one** →
  [plugins/layouts.md](plugins/layouts.md)
- **The nine permissions and what they gate** →
  [permissions/permissions.md](permissions/permissions.md)
- **Theme hooks, templates, suggestions, libraries, the `photoswipe-gallery` wrapper** →
  [theming/theming.md](theming/theming.md)
- **Services, utilities, the `media_gallery_layout_info` alter hook, Pathauto alias type** →
  [api/services.md](api/services.md)

Key facts: entity id `media_gallery`, single bundle `media_gallery`. Base fields include
`title` (required), `description`, `images` (unlimited entity_reference → `media`, Media Library
widget, PhotoSwipe formatter), `use_pager` (default 1), `items_per_page` (default 12), `reverse`
(default 0), `uid`, `created`, `changed`, `status`. Two migration submodules
(`media_gallery_migration`, `media_gallery_migration2`) are documented separately under
`modules/`.

## Diff 3.2.x → 3.3.x

- **Drupal 12 compatibility.** `media_gallery.info.yml` `core_version_requirement` is now
  `^10 || ^11 || ^12` (3.2.x was `^10 || ^11`). The composer/API surface, entity, permissions,
  blocks, layout plugin type, services, templates and shipped config are unchanged between these
  minors — the block image-style option list already routes through
  `DeprecationHelper::backwardsCompatibleCall()` (`ImageDerivativeUtilities::styleOptions()` on
  ≥11.4, `image_style_options()` below) for forward compatibility.
