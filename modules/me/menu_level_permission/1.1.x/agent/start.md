<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Level Permission (menu_level_permission) — agent index

**Restricts editing/moving/deleting menu links at or above a configured depth in selected menus — enforced at the route and entity-access layers, not just hidden in the UI.**

- **Version:** 1.1.x (1.1.0)
- **Core:** ^10.2 || ^11 || ^12 — depends on `menu_link_content`.
- **Configure:** `menu_level_permission.settings` → `/admin/config/user-interface/menu-level-permissions` (perm `administer site configuration`).
- **Permission:** `administer restricted menu levels` (still also needs core `administer menu`) — bypasses the level restriction.
- **Config object:** `menu_level_permission.settings` — `restricted_menus` (sequence/map of menu machine name => enabled) and `restricted_levels` (integer depth, default 1).

Enforcement pieces:
- `src/Routing/RouteSubscriber.php` — sets `_custom_access` → `MenuLevelPermissionAccess::menuItemAccess` on `entity.menu_link_content.canonical`, `.delete_form`, and the four content-translation routes; and swaps `entity.menu.collection` to `MenuLevelPermissionController::menuOverviewPage`. Runs at priority -230 (after menu_admin_per_menu's -220).
- `src/Access/MenuLevelPermissionAccess.php` — `menuItemAccess()` forbids when a link's computed level ≤ `restricted_levels` in a restricted menu; `getMenuLinkLevel()` walks the parent chain; `accessFallback()` defers to menu_admin_per_menu or core `administer menu`.
- `src/Hook/MenuLevelPermissionHooks.php` — OOP `#[Hook]` implementations (`menu_link_content_access` for update/delete; `form_node_form_alter`, `form_menu_link_content_form_alter`, `form_menu_edit_form_alter`). `menu_level_permission.module` keeps `#[LegacyHook]` wrappers plus the `_after_build_*` / `_form_validate` helper callbacks.
- `src/Service/MenuLevelPermissionFormValidator.php` — `validate()` blocks creating/reparenting links above the threshold on node, menu-link-content, and bulk menu-edit forms.
- `src/Controller/MenuLevelPermissionController.php` — strips the "add" child operation from restricted menus on the overview page.

Docs:
- [configure/settings.md](configure/settings.md) — settings form, config keys, permission model, and the full access mechanism with file/method citations.
