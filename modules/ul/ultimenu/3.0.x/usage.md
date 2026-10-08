<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ultimenu turns a Drupal menu into a mega-menu block whose flyout panels are real Drupal regions generated automatically from the menu's items, so you can drop any block into any menu item's panel.

---

Ultimenu inverts the usual "a region contains blocks" model: an Ultimenu **block** is derived from a menu (e.g. Main navigation), and each enabled top-level menu item of that menu becomes a dynamic **region** you can fill with ordinary blocks at `/admin/structure/block`. You enable which menus become blocks and which item-regions are active on the settings form at `/admin/structure/ultimenu` (route `ultimenu.settings`, permission `administer ultimenu`); those choices are stored in the `ultimenu.settings` config object under `blocks` and `regions`. The block plugin `ultimenu_block` is a derivative — one derivative per enabled menu (`ultimenu_block:ultimenu-<menu>`) — and its per-instance settings (skin, flyout orientation, caret, submenu rendering, off-canvas/hamburger, sticky header, AJAX) live in the block config. Regions are exposed via `hook_system_info_alter()` so they appear as theme regions without editing the theme's `.info.yml`, though you can copy the generated region definitions into the theme to make them permanent. Skins are CSS files discovered from the module, the default theme's `css/ultimenu` folder, or a custom library path; Ultimenu builds them into asset libraries via `hook_library_info_build()`. Panels can be AJAX-loaded on demand, and any menu can be turned into a single off-canvas / hamburger menu. The module depends on Blazy 3.x (shared vanilla-JS base) and core's Block and Menu modules.

---

- Build a header mega-menu from the Main navigation menu with a rich dropdown panel per top-level item.
- Place a promotional block, view, or image inside a specific menu item's flyout panel.
- Create a footer mega-menu from a separate menu with columns of blocks.
- Turn any menu into an off-canvas / hamburger drawer for mobile navigation.
- Add a sidebar mega-menu that reveals regions on hover or click.
- Give each Ultimenu block a distinct skin (dark, light, or a custom CSS skin).
- Choose flyout orientation (horizontal-to-bottom, vertical, etc.) per Ultimenu block.
- AJAX-load heavy menu panels only when the user opens them, to keep initial page weight low.
- Auto-load AJAX panels below a configured mobile max-width instead of on click.
- Render the submenu (second-level menu items) inside each Ultimenu region automatically.
- Add carets/arrows to menu items that have flyout content.
- Make the Ultimenu header sticky as the user scrolls.
- Expose menu regions to all front-end themes so switching themes doesn't require re-placing blocks.
- Add a menu-description line under (or above) each menu title in the flyout.
- Add CSS helper classes to menu items (title class, hash class, counter class) for styling.
- Use shortened HASH region keys so renaming a menu item doesn't destroy its region and blocks.
- Provide a graceful "Loading… click here" fallback link when an AJAX panel fails.
- Copy the generated `regions:` YAML into a theme's `.info.yml` to store Ultimenu regions permanently.
- Force-remove stale Ultimenu regions that were previously saved into a theme's info file.
- Mark certain menu items as non-click-through (unlinked) so they only toggle their panel.
- Build several independent mega-menus (header, sidebar, footer) on one site from different menus.
- Point Ultimenu at a custom skins directory (`libraries/skins/ultimenu`) to offer branded skin options.
- Add extra Font Awesome / icon classes globally to menu-item icons.
- Disable the module's `extras.css` overrides when a theme wants full styling control.
- Collapse and position submenus (collapsible, positioned) inside flyout panels.
