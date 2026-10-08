<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu-driven slideshow Block plugins

Two `@Block` plugins in `src/Plugin/Block/`, both category `@Translation("DROWL Header Slides")`.

| Plugin id | Class | View mode | admin_label |
|---|---|---|---|
| `drowl_header_menu_slideshow_ref_block` | `MenuSlideshowRefSlidesBlock` | `full` (`$view_mode = 'full'`) | "…Menu Slideshow Slide Block (Page Width)" |
| `drowl_header_menu_slideshow_ref_vw_block` | `MenuSlideshowRefSlidesVwBlock` | `viewport_width` | "…Menu Slideshow Slide Block (Viewport Width)" |

`MenuSlideshowRefSlidesVwBlock` is a one-property subclass of `MenuSlideshowRefSlidesBlock` that
only overrides `$view_mode = 'viewport_width'`.

## Dependencies (constructor injection)

`entity_type.manager`, `plugin.manager.menu.link`, `entity.repository`, `menu.active_trail`,
`config.factory` (via `ContainerFactoryPluginInterface::create`).

## What `build()` renders

1. `determineActiveTrailMediaHeaderSlideEntity()` resolves a `\Drupal\media\Entity\Media` for the
   current request (or `null`).
2. If found **and** `$mediaSlideshowEntity->access('view')` passes, it returns
   `entityTypeManager->getViewBuilder('media')->view($media, $this->view_mode)` — i.e. the media
   entity rendered in `full` / `viewport_width`. Otherwise returns `null` (empty block; the
   fallback view block then shows instead — see [../views/views.md](../views/views.md)).
3. `getCacheContexts()` adds the `route` context so the block rebuilds per route.

The block does **not** override `blockAccess()`; it relies on default block visibility plus the
per-media `access('view')` check above. Output is the standard media render array (auto-escaped);
the actual carousel/slide markup comes from the `drowl_media` slideshow media type's display.

## Active-trail resolution (the core logic)

`determineActiveTrailMediaHeaderSlideEntity()` (result cached per request via `drupal_static`):

- `determineActiveTrailsMenuLinkIds()` reads `drowl_header_slides.settings:menus` and, for the
  first configured menu that yields a non-empty trail, returns
  `menu.active_trail->getActiveTrailIds($menu_id)` (current item first, front page last). If the
  current page has **no** menu link of its own (`getActiveLink()` empty), it prepends the sentinel
  `'ONLY-PARENT-ITEMS-FOUND-PLACEHOLDER'` so callers know every real entry is a parent.
- It then iterates the trail. For each id it loads the `menu_link_content` entity
  (`getMenuLinkContentEntityFromUuidString()` parses `plugin:uuid`, validates the UUID with
  `Uuid::isValid()`, loads via `entity.repository->loadEntityByUuid('menu_link_content', $uuid)`).
- If the entity has `field_slideshow_ref` with a referenced media entity:
  - **index 0** (the item for the current page itself) → return that media immediately.
  - a **parent** item → return its media only if its `field_slideshow_inherit` value is truthy
    (inheritance to sub-pages). Otherwise keep walking up.

So a page shows: its own menu item's slideshow if set, else the nearest ancestor menu item whose
slideshow has "inherit" enabled, else nothing (→ fallback). A per-node override is handled by a
separate view, not by these blocks — see [../fields/slideshow-fields.md](../fields/slideshow-fields.md).

## Template

`templates/block--drowl-header-menu-slideshow-ref-block.html.twig` — a block theme suggestion
(matched by plugin id `drowl_header_menu_slideshow_ref_block`) that renders `{{ content }}` (Twig
auto-escaped). No custom variables added.

## Caveat (from source)

With multiple menus selected in settings, only the first menu returning a non-empty trail is used
(`break;`), so a page reachable from several menus may resolve the "wrong" slideshow — a documented
`@todo`.
