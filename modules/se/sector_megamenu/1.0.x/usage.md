<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sector Mega Menu renders a menu as a mega menu via root/body blocks.

---

Sector Mega Menu provides two blocks — a Mega Menu Root and a Mega Menu Body — that render a chosen Drupal menu as a mega menu. It depends on core `block` and the contrib `menu_block` module, ships Twig templates (`menu--sector-megamenu-root`, `menu--sector-megamenu-body`), and a `hook_preprocess_menu` that recursively copies each link's `menu_link_attributes` options onto the render item and flags the current path. It is a pure theming/site-structure module: no routes, no permissions, no data storage, no external calls.

---

- Render a site menu as a mega menu.
- Place a Mega Menu Root block for the top-level bar.
- Place a Mega Menu Body block for the drop-down panel.
- Reuse an existing Drupal menu (via menu_block).
- Theme the menu with the provided Twig templates.
- Expose per-link menu_link_attributes to templates.
- Highlight the current menu item as active.
- Build multi-column navigation panels.
- Support nested/recursive child menu items.
- Add heading link text to a menu body region.
- Keep menu markup overridable per theme.
- Combine with menu_block display settings.
- Serve navigation on Drupal 10.1+.
- Avoid custom PHP for mega-menu markup.
- Provide accessible, structured navigation.
- Drive navigation from menu configuration only.
