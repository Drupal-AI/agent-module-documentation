<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Level Permission locks down the top levels of selected menus so that only users with a dedicated permission can edit, move, or delete menu links at or above a configured depth.
---
An administrator picks which menus are "restricted" and a depth threshold (`restricted_menus`, `restricted_levels`) at `/admin/config/user-interface/menu-level-permissions`. Users holding `administer restricted menu levels` (in addition to core `administer menu`) bypass the restriction; everyone else is blocked from touching links at or above the threshold. Enforcement is real, not cosmetic: a `RouteSubscriber` overrides the `menu_link_content` canonical, delete-form, and content-translation routes to use `MenuLevelPermissionAccess::menuItemAccess` (`_custom_access`), and a `hook_menu_link_content_access()` implementation returns `forbidden` for `update`/`delete` operations on restricted links — so the underlying edit/delete targets are denied, not merely hidden. The access checker computes a link's level by walking its `menu_link_content` parent chain and returns `AccessResult::forbidden()` when the level is at/above the restriction; when not restricted it falls back to `menu_admin_per_menu` (if present) or core `administer menu`. In this release the hook implementations live in the OOP class `src/Hook/MenuLevelPermissionHooks.php` (`#[Hook]` attributes), with thin `#[LegacyHook]` wrappers kept in `menu_level_permission.module`.

The module also alters the node form and the menu edit form to disable/remove menu widgets for restricted links (with a read-only notice) and adds validation so restricted links cannot be created or reparented above the threshold. It also removes the "add child" operation under restricted parents and rewrites the menu overview page (`entity.menu.collection`) so non-privileged users cannot add links directly beneath a restricted menu. Typical setup: enable, grant the permission to trusted editors, then choose restricted menus and a level on the settings form.
---
- Protect the top level(s) of the main navigation from junior editors.
- Choose exactly which menus are subject to level restrictions.
- Set the depth threshold at/above which links become protected.
- Grant `administer restricted menu levels` to trusted menu admins only.
- Let restricted editors still manage deeper child links they are allowed to.
- Prevent editors from deleting protected top-level menu links.
- Prevent editors from reparenting a link up into a restricted level.
- Block direct access to a restricted link's edit/delete route (not just the UI).
- Show a read-only "restricted level" notice on the node form's menu settings.
- Disable menu weight/enabled/parent widgets for restricted links on the menu edit form.
- Remove the "add child" operation under restricted parents for non-privileged users.
- Hide the "add link" operation on restricted menus on the menu overview page.
- Fall back to menu_admin_per_menu permissions when that module is present.
- Fall back to core `administer menu` when menu_admin_per_menu is absent.
- Keep the configuration exportable for staging/production parity.
- Combine with core menu UI; no menu data is duplicated.
- Audit which menus/levels are locked via the settings form.
- Stop accidental moves of primary navigation by content editors.
- Enforce governance over site-wide navigation structure.
- Allow deep sub-menus to remain fully editable while top levels are frozen.
- Restrict up to five menu levels (Level 1 only through Levels 1-5).
- Verify enforcement by requesting a protected link's delete-form URL as a non-privileged user (expect 403).
