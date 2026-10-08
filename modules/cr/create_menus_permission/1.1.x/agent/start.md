<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create Menus Permission (create_menus_permission) — agent index

Adds one permission, **`create new menu`**, so a role can reach the "Add menu" form without
holding core's all-or-nothing **`administer menu`**. Version **1.1.0**, core `^10 || ^11`,
depends only on core **`menu_ui`**. No configuration UI, no config schema, no Drush commands.

- **Install/enable, the permission, the access hook, and the full route→permission map** →
  [permissions/create-new-menu.md](permissions/create-new-menu.md)

## Exactly what it does (whole module)

Two files carry all the behavior:

- **`create_menus_permission.permissions.yml`** — registers the permission via a
  `permission_callbacks` entry pointing at
  `\Drupal\create_menus_permission\CreateMenusPermission::CreateMenusPermission`. That callback
  returns a single permission, `create new menu`, titled "Create new menu". (It is *not* marked
  `restrict access: TRUE`.)
- **`create_menus_permission.module`** — implements `hook_ENTITY_TYPE_create_access()` for the
  `menu` config entity as `create_menus_permission_menu_create_access()`:

  ```php
  if ($account->hasPermission('create new menu')) {
    return AccessResult::allowed();
  }
  return AccessResult::forbidden();
  ```

`src/CreateMenusPermission.php` is just the permission-callback class. The `.module` also has
several unused `use` statements (Html, Element, FormStateInterface, EntityInterface) — dead
imports, no form alter or link handling.

## Mechanism and scope

- The create-access hook governs the **`entity.menu.add_form`** route
  (`/admin/structure/menu/add`, requirement `_entity_create_access: 'menu'`). Holding
  `create new menu` lets a user open that form and create a **new, empty menu**.
- **Scope is create-only.** Editing an existing menu, adding/rearranging its links, and deleting
  menus go through `entity.menu.edit_form` / `entity.menu.delete_form`, whose requirements
  (`_entity_access: 'menu.update'` / `'menu.delete'`) resolve through `MenuAccessControlHandler`
  to the entity's admin permission **`administer menu`**. A `create new menu`-only holder
  **cannot** edit any existing menu, cannot add menu links (so cannot place links on privileged
  routes), and cannot touch the administration/main menus. It does **not** equal `administer menu`
  and does not over-grant edit/delete.

## Behavior caveat agents must know

Because the hook returns **`forbidden`** (not neutral) when the permission is absent, and a
forbidden create-access result short-circuits core's default admin-permission check in
`EntityAccessControlHandler::createAccess()`, **enabling this module makes `administer menu`
alone no longer sufficient to create menus.** Any role that used to create menus via
`administer menu` must also be granted `create new menu`, or it silently loses the ability.
(User 1 / accounts with the superuser bypass are unaffected.)

## When to use

Delegating "can add a menu" to non-admin roles under least privilege; typically paired with
Workbench Menu Access for per-menu editing. Derived from Simple Menu Permissions but drops the
per-menu permissions so the permission list stays flat. See `../usage.md` for use cases.
