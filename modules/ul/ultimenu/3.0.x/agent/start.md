<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ultimenu — agent index

Mega-menu module: an **Ultimenu block** is derived from a **menu**; each enabled top-level
**menu item** becomes a dynamic **region** you fill with ordinary blocks. Depends on Blazy 3.x,
core Block + Menu. Configure route `ultimenu.settings` (`/admin/structure/ultimenu`), permission
`administer ultimenu`. No Drush, no plugin types you implement.

Two config surfaces:
- **`ultimenu.settings`** (config object) — which menus are blocks (`blocks`), which item-regions
  are active (`regions`), plus `goodies`, `skins`, `fallback_text`, `ajaxmw`, `icon_class`,
  `offcanvases`.
- **Block instance config** (`block.block.*` using plugin `ultimenu_block:ultimenu-<menu>`) —
  per-menu skin, orientation, caret, submenu, off-canvas/hamburger, sticky, ajaxify.

- **Enable a menu as a mega-menu block, enable its regions, all settings keys** →
  [configure/settings.md](configure/settings.md)
- **The `ultimenu_block` derivative block, its per-instance settings, how to place it** →
  [plugins/block.md](plugins/block.md)

Key facts:
- The block plugin id is `ultimenu_block`; one derivative per enabled menu, id
  `ultimenu_block:ultimenu-<menu_delta>` (e.g. `ultimenu_block:ultimenu-main`).
- A menu only appears as a placeable block after it is checked under **Ultimenu blocks** and
  saved (stored in `ultimenu.settings:blocks.<menu> = <menu>`).
- Regions are injected via `hook_system_info_alter()`; you never have to edit the theme
  `.info.yml`, but you may copy the generated `regions:` in to persist them.
