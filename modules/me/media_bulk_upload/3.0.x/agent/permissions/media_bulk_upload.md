# Permissions

Defined in `media_bulk_upload.permissions.yml` plus a dynamic callback
(`MediaBulkConfigPermissions::mediaBulkConfigPermissions`).

| Permission | Gates |
|---|---|
| `administer media_bulk_upload configuration` | Create/edit/delete `media_bulk_config` entities and reach the collection/add routes. Also the config entity's `admin_permission` and grants access to the `/media/bulk-upload` list. |
| `use {id} bulk upload form` | **Dynamic**, one per `media_bulk_config` (e.g. `use images bulk upload form`). Gates the upload form at `/media/bulk-upload/{id}` (checked by `MediaBulkUploadController::accessForm`). Title: "{label} : Use upload form". |

Access notes:

- `/media/bulk-upload` (`accessList`) is allowed if the user has the admin permission **or** may use at least one
  configured form; with exactly one usable config it redirects straight to that form.
- The config entity uses `permission_granularity = "bundle"`, so each configuration carries its own use permission.
- After adding a new configuration, grant its `use {id} bulk upload form` permission to the intended roles.

```
drush role:perm:add editor 'use images bulk upload form'
```
