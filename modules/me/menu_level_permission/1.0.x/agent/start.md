<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Level Permission (menu_level_permission) — agent index

**Restricts editing/moving/deleting menu links at or above a configured depth in selected menus — enforced, not just hidden.**

- **Version:** 1.0.x (1.0.0-beta6)
- **Core:** ^10.2 || ^11 — depends on menu_link_content.
- **Configure:** `menu_level_permission.settings` → `/admin/config/user-interface/menu-level-permissions` (perm `administer site configuration`).
- **Permission:** `administer restricted menu levels` (also needs core `administer menu`) — bypasses the restriction.
- **Enforcement:**
  - `src/Routing/RouteSubscriber.php` sets `_custom_access` → `MenuLevelPermissionAccess::menuItemAccess` on `entity.menu_link_content.canonical`, `.delete_form`, and content-translation routes.
  - `menu_level_permission_menu_link_content_access()` (`.module:293`) returns **forbidden** for `update`/`delete` on restricted links (covers the edit form too).
  - `MenuLevelPermissionAccess` (`src/Access/...:105`) forbids when a link's computed level ≤ `restricted_levels` in a restricted menu; else falls back to menu_admin_per_menu or core `administer menu`.
- **Security:** answers the access-control lens — it genuinely **denies the routes/entity operations**, pairing form hiding with route `_custom_access` + `hook_ENTITY_TYPE_access`. Restricted targets are not reachable by URL. No security findings.

See [configure/settings.md](configure/settings.md).