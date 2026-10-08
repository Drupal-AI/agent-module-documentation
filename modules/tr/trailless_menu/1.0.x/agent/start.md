<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trailless Menu - agent index

Per-menu **active-trail disable**: selected menus emit no active/parent classes and no auto-expansion. Version **1.0.1**, core `^8 || ^9 || ^10 || ^11`.

- Decorates `menu.active_trail` via `trailless_menu.active_trail` (`TraillessMenuActiveTrail`).
- Settings form route `trailless_menu.settings`, permission `administer trailless menu`.
- Config `trailless_menu.settings`, key `trailless_menus` (map menu-id => TRUE).