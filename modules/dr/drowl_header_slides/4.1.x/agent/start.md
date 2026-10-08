<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Header Slides (drowl_header_slides) — agent index

Per-page header/hero slideshow. It resolves a **slideshow media entity** from the active menu
trail (or a node/menu-item entity-reference field) and renders it in a chosen view mode, with a
site-wide fallback. The module only **resolves + renders** media; the carousel markup itself
(Slick/Blazy, per-slide fields, links) is defined by the **`drowl_media` slideshow media type**.
Package `DROWL.de`. Core `^9 || ^10 || ^11`. Version 4.1.14. License GPL-2.0-or-later.

## Requires the DROWL media stack (cannot enable standalone)

Install pulls the whole DROWL media stack and helpers. `dependencies` (info.yml):
`block_content`, `fences`, `field`, `language`, `slick`, `views`, `media`, `media_library`,
`taxonomy`, `drowl_media` (>=3,>=4), `drowl_media_types`, `menu_item_extras`, `views_linkarea`.
The shipped fields/views reference `media.type.slideshow` and `media.type.slide` (the **"Slide"**
media type is a media bundle, provided by `drowl_media`/`drowl_media_types`) — without that media
stack configured the module's config install will not import and the module will not enable.
Composer `require`: `drupal/fences ^3`, `drupal/slick ^2||^3`, `drupal/drowl_media ^3||^4`,
`drupal/menu_item_extras ^3`, `drupal/views_linkarea ^2`.

## What it provides

- **Two Block plugins** (`src/Plugin/Block/`), category "DROWL Header Slides":
  `drowl_header_menu_slideshow_ref_block` (Page Width, view mode `full`) and
  `drowl_header_menu_slideshow_ref_vw_block` (Viewport Width, view mode `viewport_width`). Both
  walk the active menu trail and render the resolved slideshow media. →
  [blocks/menu-slideshow-blocks.md](blocks/menu-slideshow-blocks.md)
- **Settings form + config** `drowl_header_slides.settings` (key `menus`), route
  `drowl_header_slides_settings` at `/admin/config/system/drowl-header-slides`, permission
  `access drowl_header_slides settings`. → [config/settings.md](config/settings.md)
- **Three fields** (config/install): `node.page.field_slideshow_ref`,
  `menu_link_content.main.field_slideshow_ref`, `menu_link_content.main.field_slideshow_inherit`,
  plus their storages. → [fields/slideshow-fields.md](fields/slideshow-fields.md)
- **Three Views** (config/install): `drowl_header_slideshow_fallback`,
  `drowl_headerslides_slideshow_ref`, `drowl_header_slides_admin_media_slideshow` (page at
  `/admin/content/header-slides`). → [views/views.md](views/views.md)
- **Two hooks** (`.module`): `hook_views_pre_render` (attach `drowl_media/admin_media_library` to
  the admin overview), `hook_block_build_alter` (set `#create_placeholder = FALSE` on the four
  fallback/ref views blocks so empty-detection works). **No** `.services.yml`, `.libraries.yml`,
  theme hook, or Drush commands. One template: `block--drowl-header-menu-slideshow-ref-block.html.twig`
  (outputs `{{ content }}`).

## Access model (no security role)

Content-display / site-building only. The settings route is gated by the dedicated admin
permission `access drowl_header_slides settings` (restricted). Blocks render a media entity only
after `$media->access('view')`. Slide content is authored via normal media/block workflows and
follows normal media access; the module adds no access-control behavior of its own.
