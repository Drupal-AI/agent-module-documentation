<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions — Menu Perms per Menu

Permissions are generated dynamically (a `permission_callbacks` entry in
`menu_perms_per_menu.permissions.yml` → `MenuPermsPerMenuPermissions::permissions()`), producing one
set **per menu** on the site. The menu's **machine id** (`$menu->id()`) is embedded in each permission
name, so the strings are the machine ids you use in `user_role_grant_permissions()` /
`->grantPermission()`, not the human labels shown at `admin/people/permissions`.

## The six permissions (per menu `<menu_id>`)

| Permission machine name | Gates |
|---|---|
| `add new links to <menu_id> menu from menu interface` | Adding a new link / "Add child" to the menu; the "Add link" button on the menu overview and the `entity.menu.add_link_form` route. |
| `delete links in <menu_id> menu from menu interface` | Deleting a link: the Delete operation in the per-menu list, the Delete action on the link edit form, and the `entity.menu_link_content.delete_form` route. |
| `enable/disable links in <menu_id> menu` | The Enabled checkbox on the link edit form and the Enabled checkbox column in the per-menu overview. |
| `expand links in <menu_id> menu` | The "Show as expanded" checkbox on the link edit form. |
| `edit link of menu links in <menu_id> menu` | The Link (URL) field on the link edit form. |
| `translate links in <menu_id> menu from menu interface` | The Translate operation and the `entity.menu_link_content.content_translation_overview` / `_add` routes. |

Example: for the built-in Main menu (`main`) the add permission is
`add new links to main menu from menu interface`.

## How each is enforced

- **Route access** (`MenuPermsPerMenuRouteSubscriber`, event priority -225, i.e. after
  menu_admin_per_menu's -220): attaches `_custom_access` to
  - `entity.menu.add_link_form` → `MenuPermsPerMenuPermissions::addItemAccess`
  - `entity.menu_link_content.delete_form` → `deleteItemAccess`
  - `entity.menu_link_content.content_translation_overview` / `_add` → `translateItemAccess`
  and re-points `entity.menu.collection` to the module's controller.
- **Form alter** (`menu_perms_per_menu.module`):
  - `menu_link_content_menu_link_content_form`: disables `link`, `enabled`, `expanded` and hides the
    Delete action when the matching permission is absent.
  - `menu_edit_form` (per-menu overview): removes the "Add link" empty-text link, disables the Enabled
    checkbox, and unsets the Delete / Translate / Add-child operations per row.
- **Controller** (`MenuPermsPerMenuController::menuOverviewPage`): removes the per-menu "Add" operation
  on the menus overview (`admin/structure/menu`).

## Granting via Drush / code

```php
// grant "add + enable, but not delete" on the Main menu to the 'editor' role
use Drupal\user\Entity\Role;
$r = Role::load('editor');
$r->grantPermission('add new links to main menu from menu interface');
$r->grantPermission('enable/disable links in main menu');
$r->save();
```

Because the strings are computed from live menus, a permission only exists while its menu exists;
creating a new menu makes its six permissions appear automatically.

## Note

The `link`, `enabled` and `expanded` restrictions are applied as form `#disabled`. The delete / add /
translate paths use `_custom_access` route checks.
