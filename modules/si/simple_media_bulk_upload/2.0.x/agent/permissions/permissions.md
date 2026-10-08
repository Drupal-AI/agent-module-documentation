# Permissions

| Permission | Defined by | Gates |
|---|---|---|
| `dropzone upload files` | `dropzonejs` (dependency) | Access the bulk upload form (`/admin/content/media/bulk-upload`) |
| `administer simple media bulk upload` | this module | Access the settings form (`max_files`) |

Notes:
- The upload route requires `dropzone upload files`, **not** a module-specific "upload media"
  permission. Grant it to any role that should bulk-upload.
- Beyond that route permission, actual creation is still constrained by **media access**: the
  form only lists media types the user has `create` access to (per the media access control
  handler), so per-type create permissions still apply.
- `administer simple media bulk upload` only controls the `max_files` config form.

```bash
drush role:perm:add editor 'dropzone upload files'
drush role:perm:add administrator 'administer simple media bulk upload'
```
