<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST resource: mega-menu HTML for decoupled front-ends

`src/Plugin/rest/resource/MegaMenuResource.php` — `@RestResource(id="advanced_mega_menu_resource")`,
canonical URI **`/api/advanced-mega-menu/{menu_id}/{plugin_id}`** (GET only). Requires core
**REST + Serialization**.

## Enable

Like any core REST resource, it must be turned on and configured (methods/formats/auth) — e.g. via
the REST UI module or a `rest.resource.advanced_mega_menu_resource` config entity — and callers need
the auto-generated permission **`restful get advanced_mega_menu_resource`** plus whatever
authentication you configure. It is not exposed until you do this.

## Behaviour — `MegaMenuResource::get($menu_id, $plugin_id)`

1. Calls `MegaMenuRowBuilder::buildMenuItemMegaRows($menu_id, $plugin_id)` (same service the theme
   layer uses; see [../menu/builder.md](../menu/builder.md)). `plugin_id` may be the bare UUID or the
   `menu_link_content:<uuid>` form — the builder strips the prefix.
2. If the builder returns empty (no `megamenu_content` entity for that menu+link, or its
   `status = FALSE`), throws `NotFoundHttpException('Mega menu not found or disabled.')`.
3. Renders the render array to HTML with `renderer->renderRoot($rows)` and returns a
   `ResourceResponse` with body `{"megamenu": "<rendered html string>"}`.

## Caching

Attaches `CacheableMetadata`:
- cache context `url.path`;
- cache tags `mega_menu_content:<uuid>` (invalidate when the entity changes) and
  `config:system.menu.<menu_id>` (invalidate when the menu config changes).

The embedded Views/blocks are rendered server-side through their normal view builders, so their own
access and cacheability apply to the produced markup.
