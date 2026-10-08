# Permissions

Defined in `file_delete.permissions.yml`. Both are marked `restrict access: true` (they can
grant destructive capability, so Drupal flags them on the permissions form).

| Permission | Gates |
|---|---|
| `delete files immediately` | Shows the **"Delete immediately"** checkbox on the delete form and lets the `file_delete_immediately` behavior run — the file is deleted at once, skipping the temporary/cron step. |
| `delete files override usage` | Shows the **"Force delete"** checkbox and lets a file be deleted even when it has usage records (the usage rows are removed first). May leave broken links/media — the form warns. |

Notes:

- These two permissions are **the only ones the module defines.** The ability to reach the
  delete form/route and the bulk actions is governed by **core** file permissions
  (`delete own files` / `delete any file`) — the action plugins check the file entity's
  `delete` access. Older `delete file` / `delete files` permissions were migrated to the core
  ones in `file_delete_update_400002()`.
- Without either module permission, deletion still works but always uses the safe path: refuse
  if in use, otherwise mark temporary for cron.

```
drush role:perm:add content_admin 'delete files immediately'
drush role:perm:add content_admin 'delete files override usage'
```
