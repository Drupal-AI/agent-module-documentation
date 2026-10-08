# Permissions — Permission Spreadsheet

Defined in `permission_spreadsheet.permissions.yml`. None are marked `restrict access: true`.

| Permission | Gates |
|---|---|
| `administer permission spreadsheet` | The settings form (`permission_spreadsheet.settings`) — export/import text marks, filename/title tokens, auto-preview. |
| `export permission spreadsheet` | The export route/form — download the role/permission matrix as a spreadsheet. |
| `import permission spreadsheet` | The import route/form — upload a spreadsheet and **bulk-apply permission grants/revokes to all non-admin roles**. |

## What `import permission spreadsheet` actually confers
The import form calls core's `user_role_change_permissions($rid, $permissions)` for every
non-admin role in the uploaded sheet, with **no restriction on which permissions may be set** and
**no check that the acting user already holds them**. In effect this permission lets its holder
grant *any* permission (e.g. `administer users`, `administer permissions`, `administer modules`)
to any non-admin role. Treat it as equivalent to `administer permissions` and grant it only to
fully trusted administrators.

- Admin/super-user roles (`$role->isAdmin()`) are always skipped by both export and import, so an
  importer cannot alter the permissions of the admin role itself.
