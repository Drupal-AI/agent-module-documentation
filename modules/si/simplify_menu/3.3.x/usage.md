<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simplify Menu exposes any Drupal menu as a plain, normalized PHP array (title, url, active/active-trail flags, nested submenus) through a Twig function and a callable service, so you can render fully custom menu markup instead of core's opaque menu render element.

---

Simplify Menu ships one small service (`simplify_menu.menu_items`) whose `getMenuTree($menuId)` method loads a menu with core's `menu.link_tree`, runs the standard access-check and sort manipulators, and flattens the result into a simple nested array under a top-level `menu_tree` key. Each item is `{text, url, active, active_trail}` plus a `submenu` array when it has children; inaccessible and disabled links are dropped for you. A bundled Twig extension wraps that service as the `simplify_menu('menu_id')` function, letting theme templates loop the array and emit their own accessible, standards-compliant markup with no preprocessing. The same service can be called from any PHP (a controller, a normalizer) and `json_encode`d to feed a decoupled/headless front end, since the output is already a clean data structure. An alter hook, `hook_simplify_menu_simplified_link_alter()`, lets other modules add or change keys on each link (e.g. attributes, icons, a description). The module has no admin UI, no settings, no permissions, no routes, and no Drush commands — it is purely a developer/theming helper. Version 3.x is Twig/service only; unlike older 1.x/2.x releases it does not register a JSON REST route, so decoupled output is produced by calling the service yourself.

---

- Render a fully custom `<nav>` for the main menu in a Twig template instead of using core's `{{ menu }}` render element.
- Build accessible, ARIA-annotated navigation markup that core's default menu theming doesn't give you.
- Loop menu items directly in a theme with `{% for item in simplify_menu('main').menu_tree %}`.
- Output any menu (footer, account, admin, a custom menu) by passing its machine name.
- Add "active" and "active-trail" CSS classes to menu links using the per-item `active` / `active_trail` flags.
- Render multi-level dropdown / flyout menus by recursing into each item's `submenu` array.
- Get a menu as a plain PHP array inside a controller or service for custom processing.
- Feed a decoupled/headless front end (React, Vue, mobile app) by `json_encode`-ing the service output.
- Expose a menu as JSON from your own REST resource or controller route, backed by the service.
- Build a mega-menu component that needs the raw title/url/children data without core's markup.
- Populate a sitemap or breadcrumb-like listing from a menu's structure.
- Render menus inside a Single Directory Component (SDC) or Twig component library.
- Skip writing a custom preprocess hook just to reshape menu data for a template.
- Drop inaccessible and disabled menu links automatically before rendering (access checks are applied).
- Enrich each link (icon, description, custom attributes) via `hook_simplify_menu_simplified_link_alter()`.
- Reuse one menu's data across several templates without re-querying the menu tree each time.
- Generate menu markup for a design system where the HTML structure differs from Drupal's defaults.
- Provide menu data to a JavaScript widget embedded via a `#theme` template.
- Render a language switcher-style or utility menu with bespoke markup.
- Prototype navigation quickly in a custom theme without touching menu block config.
- Build a footer column layout that reads several menus and lays them out in a grid.
- Highlight the current page in navigation using the `active` flag without JavaScript.
- Expose menu structure to a static-site generator build step that calls Drupal over HTTP.
