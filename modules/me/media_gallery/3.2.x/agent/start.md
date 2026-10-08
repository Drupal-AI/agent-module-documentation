<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Gallery — agent index

Provides a **`media_gallery` content entity** (base table `media_gallery`, data table
`media_gallery_field_data`) that groups core **Media** items and renders them as a **PhotoSwipe**
lightbox. Depends on `text`, `media_library`, `photoswipe` (>=5). Manage galleries at
`/admin/content/media-gallery`; visitors browse them at `/galleries` (shipped View
`media_galleries`). Config UI route = `entity.media_gallery.settings`
(`/admin/structure/media-gallery`, also the `field_ui_base_route`). Nine permissions, one plugin
type, two blocks, a Pathauto alias type. No Drush commands.

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
