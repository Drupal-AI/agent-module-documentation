# Permissions

Defined in `media_file_delete.permissions.yml`.

| Permission | Gates |
|---|---|
| `delete any file` | Lets the holder delete a source file even when they are **not** its owner. `restrict access: true` (security-sensitive). Enforced by `MediaFileDeleteFileAccessControlHandler`, a custom `file` access handler installed via `hook_entity_type_alter`: on the `delete` operation, if core would forbid access, it is allowed when the account has this permission. |
| `administer media file delete` | Access to the settings form (`/admin/config/media/media_file_delete/settings`, route `media_file_delete.settings`) — i.e. changing `delete_file_default` and `disable_delete_control`. |

Notes:

- Whether the "Also delete the associated file?" checkbox appears also depends on the actor
  having core `delete` access to the file. Without `delete any file`, files owned by other
  users are retained and the form shows a message instead of the checkbox.
- The module defines no permission for the checkbox itself; that on/off control is governed by
  the `disable_delete_control` setting, not a permission.

```
drush role:perm:add editor 'delete any file'
```
