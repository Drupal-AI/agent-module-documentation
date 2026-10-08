<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions and how access actually resolves

## Declared global permissions (`og_menu.permissions.yml`)

- `administer og menu` — `restrict access: true`. Gates the `ogmenu` bundle collection/add/edit/
  delete routes, the overview form, and the settings form (`admin/config/group/og_menu`).
- `add og menu instance entities`
- `edit og menu instance entities`
- `delete og menu instance entities`
- `view og menu instance entities`
- `add new links to og menu instance entities`

## OG group permissions (`OgMenuEventSubscriber`)

Exactly **one** group permission is registered:
`add new links to og menu instance entities` (default role: group ADMINISTRATOR). There is a
`@todo` to make it per-instance. No group-level view/edit/delete permission is registered.

## How the access handler resolves (`OgMenuInstanceAccessControlHandler`)

| Operation | Check performed | OG group scoping? |
|-----------|-----------------|-------------------|
| view      | global `view og menu instance entities`   | No |
| update    | global `edit og menu instance entities`   | No |
| delete    | global `delete og menu instance entities` | No |
| create    | global `add og menu instance entities` (`checkCreateAccess`) | No |
| add-link  | global `add new links...` **OR** the group membership's `add new links...` permission (`OgMenuInstanceController::addLinkAccess`) | **Yes** |

Only **add-link** consults OG membership. For view/update/delete/create the handler calls
`AccessResult::allowedIfHasPermission()` against the acting account's *global* permissions and never
inspects which group the instance belongs to. Consequently a role granted, say,
`edit og menu instance entities` can edit **every** group's menu across the whole site — group
membership is irrelevant. The instance edit form (reorder/enable/disable/delete links) is gated by
the `update` operation, so it inherits this site-wide scope.

The module's kernel test `tests/src/Kernel/OgMenuAccessTest.php` encodes this: a group administrator
and a plain group member both get `FALSE` for view/update/delete on an instance in their own group;
only the global `administer og menu` holder (and uid 1) get TRUE.

## Route-level access (`og_menu.routing.yml`)

- Instance canonical/edit/delete: `_entity_access: ogmenu_instance.{view,update,delete}` → the
  handler above.
- Instance add-link: `_custom_access: OgMenuInstanceController::addLinkAccess`.
- Instance create: `_entity_create_access: ogmenu_instance` — with a `@todo` that it does **not**
  validate the user's access to the `{og_group}` in the URL nor that it is actually a group.
- `ogmenu` bundle routes, overview, and settings: `_permission: 'administer og menu'`.

No route uses `_access: TRUE`.
