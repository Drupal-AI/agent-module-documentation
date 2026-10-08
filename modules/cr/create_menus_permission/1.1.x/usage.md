<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Create Menus Permission adds a single `create new menu` permission and lets a role reach the "Add menu" form without holding core's all-or-nothing `administer menu`.

---

Core gates the whole menu-management UI behind one permission, `administer menu`: it covers creating menus, deleting menus, and editing every link in every menu including the administration menu. There is no way in core to hand out just the ability to add a menu. This module fills exactly that gap and nothing more. It registers one permission, `create new menu`, through a `permission_callbacks` entry (`CreateMenusPermission::CreateMenusPermission`), and implements one hook, `create_menus_permission_menu_create_access()` — an implementation of `hook_ENTITY_TYPE_create_access()` for the `menu` config entity. That hook returns `AccessResult::allowed()` when the account holds `create new menu` and `AccessResult::forbidden()` otherwise, which is what governs the `entity.menu.add_form` route (`/admin/structure/menu/add`, requirement `_entity_create_access: 'menu'`). The scope is genuinely narrow: the permission grants only the creation of a new (empty) menu. Editing an existing menu, adding or rearranging its links, and deleting menus all still run through the menu edit/delete routes, which require `menu.update`/`menu.delete` access and therefore still demand `administer menu` — a `create new menu` holder cannot touch any menu that already exists, cannot add links, and cannot reach the administration menu. One interaction matters in practice: because the access hook returns *forbidden* (not neutral) when the permission is missing, and a forbidden create-access result short-circuits core's default admin-permission check, enabling this module means `administer menu` on its own no longer allows creating menus. Grant `create new menu` alongside `administer menu` to any role that previously created menus, or it will silently lose that ability. The module was written for use with Workbench Menu Access (and is derived from Simple Menu Permissions, dropping the per-menu permissions), but it depends only on core `menu_ui` and works standalone. Version 1.1.0, core `^10 || ^11`. There is no configuration UI and no config schema — the only artifact is the permission on `admin/people/permissions`.

---

- Let a non-admin role create its own menu without granting `administer menu`.
- Delegate the "Add menu" form to a department or team.
- Apply least privilege to menu management.
- Give an editor the ability to spin up a menu for a microsite.
- Avoid handing out `administer menu` just so someone can add a menu.
- Reduce the number of full menu administrators.
- Pair with Workbench Menu Access to delegate per-menu editing while keeping creation separate.
- Keep the permissions list flat instead of one permission per menu (unlike Simple Menu Permissions).
- Let a site builder create empty menus for a colleague to populate later.
- Restrict editing of the main and administration menus to full admins while allowing menu creation.
- Support a devolved, multi-team intranet where each team seeds its own menu.
- Reduce ticket volume for "please create a menu for us" requests.
- Grant menu creation to a role during a permissions audit / least-privilege cleanup.
- Enable self-service creation of menus in an editorial workflow.
- Combine `create new menu` with `administer menu` so existing menu admins keep both create and edit rights.
- Provision a campaign or event team with the ability to start a new navigation structure.
- Separate the "create" verb from the "administer" verb in a permissions model.
- Let a distribution/install profile grant menu creation to a custom editor role.
- Audit which roles can create menus independently of who can edit them.
- Prototype menu structures without exposing the full menu administration surface.
