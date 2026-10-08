<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Menu Level Permission

Route: `menu_level_permission.settings` → `/admin/config/user-interface/menu-level-permissions` (perm `administer site configuration`).
Config: `menu_level_permission.settings` — `restricted_menus` (map of menu machine name => enabled) and `restricted_levels` (numeric depth threshold).

Permission model:
- `administer restricted menu levels` + core `administer menu` = full access (bypasses restriction).
- Without it, a user is **forbidden** from update/delete on any `menu_link_content` link whose level is ≤ `restricted_levels` in a restricted menu.

Level computation (`MenuLevelPermissionAccess::getMenuLinkLevel()`): starts at 1 and walks the `menu_link_content` parent chain (`findMenuParent()` via `getParentId()`), incrementing per ancestor. Level 1 = top-level link.

Enforcement points to verify:
- Route access: `RouteSubscriber::alterRoutes()` attaches `_custom_access` to canonical/delete-form/content-translation routes (priority -230, after menu_admin_per_menu).
- Entity access: `hook_menu_link_content_access()` handles `update`/`delete` (edit form uses `update`).
- Form UX: `menu_level_permission_form_node_form_alter()` and `_..._form_menu_edit_form_alter()` disable/remove menu widgets and add `_menu_level_permission_form_validate` so restricted links cannot be created/reparented above the threshold.

To confirm hardening: as a user with only `administer menu` (no restricted permission), request `/admin/structure/menu/item/<id>/delete` for a top-level link in a restricted menu — it must return 403.