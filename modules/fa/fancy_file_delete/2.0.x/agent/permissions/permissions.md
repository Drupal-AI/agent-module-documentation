<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `fancy_file_delete.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer fancy file delete` | The admin pages: `fancy_file_delete.info` (`/admin/config/content/fancy_file_delete`) and the Manual form `fancy_file_delete.manual`. This is the main "can use the tool" permission. |
| `view unmanaged files entities` | View `unmanaged_files` entities (the UNMANAGED listing). |
| `add unmanaged files entities` | Create `unmanaged_files` entities. |
| `edit unmanaged files entities` | Edit `unmanaged_files` entities. |
| `delete unmanaged files entities` | Delete `unmanaged_files` entities. |
| `administer unmanaged files entities` | Admin form for the `unmanaged_files` entity type (`restrict access: true` — treat as trusted/admin only). |

Notes:
- The LIST / MANUAL / ORPHANED workflows are all behind `administer fancy file delete`
  (route `_permission` requirement) — grant it to give a role the file-deletion tool.
- The unmanaged-files entity permissions are standard entity CRUD and only matter for the
  UNMANAGED view; `administer unmanaged files entities` is access-restricted.
- Deleting other users' files may require a core patch (see the project README /
  issue #3169116); relevant on multi-user sites where files are owned by different accounts.

```bash
# Grant the tool to an editor role
drush role:perm:add editor 'administer fancy file delete'
```
