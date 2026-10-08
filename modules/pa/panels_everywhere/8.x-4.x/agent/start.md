<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Panels Everywhere (panels_everywhere) — agent index

Uses the **Panels architecture to lay out the whole page** — header, footer, sidebars and the main
content are all blocks/panes in one Page Manager variant, replacing the theme's `page.html.twig`
region rendering. It does this without any routes, forms, permissions or settings page of its own:
it ships a **Page Manager page** `site_template` (disabled at install) whose variant uses this
module's **DisplayVariant plugin `panels_everywhere_variant`**, then an **event subscriber** hooks
core's `SELECT_PAGE_DISPLAY_VARIANT` render event so that — for every non-admin route — the page is
rendered by that variant instead of the theme's `block_page` variant. A second **route subscriber**
(extending Page Manager's `PageManagerRoutes`) removes the route override Page Manager would normally
add, so the underlying route still runs and produces the "Main Page Content" block. All editing
happens in the **Page Manager UI** at `/admin/structure/page_manager` (enable core `page_manager_ui`
to see it); this module contributes only the variant plugin, the two subscribers, the config schema
and the seed config.

- Depends on: `layout_discovery` (core), `ctools:ctools_block`, `panels:panels`,
  `page_manager:page_manager`. Composer: `drupal/panels >=4.7`, `drupal/page_manager >=4.0.0`.
- Core: `^9.2 || ^10 || ^11`. Package: `Panels`. Version documented: **8.x-4.0-beta4** (beta;
  runtime-verified on Drupal 11.4.5 with panels 8.x-4.10, page_manager 8.x-4.0, ctools 4.1.1).
- **No** settings page / `configure` route, **no** permissions, **no** drush, **no** routing/menu
  links, **no** templates/JS/CSS. Provides **config schema**. Defines **no plugin types** (it
  *implements* one DisplayVariant plugin).
- Layout Builder is core's maintained answer to the same problem; Panels/Page Manager remain in
  long-running beta. This module belongs to sites that already run the Panels stack, not new builds.

## What you'd do → where

- **Turn it on: enable the `site_template` page, add "Main Page Content" + region blocks, pick the
  layout, understand `route_override_enabled`** → [configure/site-template.md](configure/site-template.md)
- **Understand/extend the `panels_everywhere_variant` DisplayVariant plugin, its config keys, schema
  and the create/presave storage hooks** → [api/display-variant.md](api/display-variant.md)
- **Understand the two event subscribers (how the variant is selected per request and how the route
  override is stripped)** → [api/subscribers.md](api/subscribers.md)

## Key facts (real machine names)

- Display variant plugin: **`panels_everywhere_variant`** (admin_label "Panels Everywhere"),
  class `Drupal\panels_everywhere\Plugin\DisplayVariant\PanelsEverywhereDisplayVariant` — extends
  `panels`' `PanelsDisplayVariant`, implements core `\Drupal\Core\Display\PageVariantInterface`.
- Services (both `event_subscriber`):
  - `panels_everywhere.page_display_variant_subscriber` — `EventSubscriber\PanelsEverywherePageDisplayVariantSubscriber`
    (arg `@entity_type.manager`, priority `1000`); subscribes to `RenderEvents::SELECT_PAGE_DISPLAY_VARIANT`.
  - `panels_everywhere.route_subscriber` — `Routing\PanelsEverywhereRouteSubscriber`
    (args `@entity_type.manager`, `@cache_tags.invalidator`, priority `-200`); extends
    `Drupal\page_manager\Routing\PageManagerRoutes`.
- Config schema: `display_variant.plugin.panels_everywhere_variant` (extends
  `display_variant.plugin.panels_variant`), adds one key `route_override_enabled` (boolean).
- Seed config (config/install): page `page_manager.page.site_template` (id `site_template`,
  `status: false`, `path: /site_template`, `use_admin_theme: false`) and variant
  `page_manager.page_variant.panels_everywhere` (variant `panels_everywhere_variant`,
  `layout: layout_onecol`, `builder: standard`, `route_override_enabled: false`).
- Hooks (`.module`): `panels_everywhere_page_variant_create()` and
  `panels_everywhere_page_variant_presave()` (`hook_ENTITY_TYPE_create/presave` for `page_variant`) —
  call `$panels_display->setStorage('page_manager', $variant->id())` so Panels offers IPE storage.
- Update/post-update: `panels_everywhere_update_8400()` (rename layout ids to layout_discovery),
  `panels_everywhere_post_update_route_override()` (migrate the old page-level third-party setting
  `panels_everywhere:disable_route_override` into per-variant `route_override_enabled`).
- Variant config key an agent sets: `variant_settings.route_override_enabled` (boolean; default
  FALSE ⇒ the module *removes* Page Manager's route override for that variant).
