<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Pager (menu_pager) — agent index

A block that renders **previous/next links from a menu's own order and structure**. One block is
**derived per menu**; it appears only on pages whose active menu link belongs to that menu.
Version **3.0.4**. Core `^8 || ^9 || ^10 || ^11`. No dependencies, no permissions, no routes, no
Drush, no configuration required.

## What it does (verified from source)
`src/Plugin/Block/MenuBlock.php` (`@Block id="menu_pager_block"`, deriver
`src/Plugin/Derivative/MenuBlock.php` → one derivative per menu entity):
1. `build()` gets the active link via `menu.active_trail->getActiveLink(NULL)` and renders only if
   that link's menu name equals the block's derivative (menu) id **and** a previous or next link
   exists.
2. `menuPagerGetNavigation()` loads the menu tree, applies core manipulators
   `checkAccess` + `generateIndexAndSort`, then `menuPagerFlattenTree()` walks it **depth-first**
   into a flat list, keeping only links that are **access-allowed**, **enabled**, and not in the
   ignore list.
3. It finds the active link in the flat list by **plugin id** and takes the immediately preceding /
   following entries as previous / next.
4. Links are rendered with `Link::fromTextAndUrl()`; default markers `<<` / `>>`, wrapped by the
   `menu_pager` theme hook (`templates/menu-pager.html.twig`) with the `menu_pager/menu_pager` CSS
   library (previous floats left, next floats right).

## Key behaviours
- **Whole tree vs. siblings.** Default: flatten the entire tree, so "next" from a section's last
  child jumps into the following section. Per-block **Restrict to parent** sets the tree root to the
  active link's parent with `maxDepth 1`, so paging is confined to same-parent siblings and stops at
  the ends of that group.
- **Access-aware.** `checkAccess` manipulator + an `isAllowed()` filter mean the pager never links to
  a route the current user cannot access; **disabled** links and ignored routes/paths are skipped.
- **Ignore list.** `<nolink>` and `<separator>` (Special Menu Items placeholders) are ignored out of
  the box via the module's own `hook_menu_pager_ignore_paths()`. Extend with
  `hook_menu_pager_ignore_paths($menu_name)` and `hook_menu_pager_ignore_paths_alter(&$paths, $menu_name)`.
- **Uncacheable by design.** `getCacheMaxAge()` returns `0` and `getCacheContexts()` adds `url.path`
  (core `@todo` to make it cacheable). It recomputes every request — so it never serves a stale
  pager, at the cost of no render-cache benefit. There is **no** menu-cache-tag staleness bug here.

## Per-block settings (`blockForm`)
`menu_pager_restrict_to_parent`, `menu_pager_hide_menu_title` (show only the label, not the link
title), `menu_pager_custom_label` (enable custom text), `menu_pager_previous_label`,
`menu_pager_next_label`. Config schema: `config/schema/menu_pager.schema.yml`.

## Files
- `agent/blocks/menu-pager-block.md` — the block plugin, deriver, navigation algorithm, settings.
- `agent/theming/templates.md` — theme hook, template, CSS library, label markup.

## No public procedural API
Unlike older releases, 3.0.x has no `menu_pager_get_navigation()` function; the logic lives on the
block plugin (`menuPagerGetNavigation()`). The `.module` file provides only the theme, help, and
ignore-paths hooks.

Compare `pager` (a sibling module) which derives prev/next from **node creation order**, not a menu.
