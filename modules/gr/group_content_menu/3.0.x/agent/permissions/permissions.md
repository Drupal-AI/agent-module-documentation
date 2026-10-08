# Group Content Menu permissions

The module gates access with one **global** (site) permission and three **group** permissions.

## Global permission (`group_content_menu.permissions.yml`)

| Permission | Gates | Notes |
|---|---|---|
| `administer group content menu types` | Managing menu **types** at `/admin/structure/group_content_menu_types` | `restrict access: true` (trusted admins) |

## Group permissions (`group_content_menu.group.permissions.yml`)

Assigned per group role (via the Group module's permission UI), provided through the relation's
`GroupContentMenuPermissionProvider`:

| Permission | Gates |
|---|---|
| `access group content menu overview` | View the group's menus overview (`/group/{group}/menus`). |
| `manage group_content_menu` | Create, update and delete menus in a group (`restrict access: true`). |
| `manage group_content_menu menu items` | Create, update and delete menu links within group menus. |

## Access checks

- Route access to a group's menu operations is additionally guarded by the
  `_group_menu_owns_content` access check (`GroupOwnsMenuContentAccessChecker`), ensuring the
  menu/link belongs to the group in the route.
- Translation of menu links uses the `TranslationAccess` / `GroupMenuItemTranslateAccessHandler`.

So: give trusted site admins `administer group content menu types` to define types; grant group
roles the three group permissions to let group editors run their own menus.
