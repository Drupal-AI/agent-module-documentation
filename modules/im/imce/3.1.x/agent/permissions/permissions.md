# Permissions

## Module permission (`imce.permissions.yml`)
- **`administer imce`** — access the settings page, manage profiles and role assignments,
  reach the help and admin browser routes. Marked `restrict access: true` (trusted roles
  only).

Note: whether a user can *use* a file browser at all is not a permission — it is governed by
whether any Imce **profile** is assigned to one of their roles for the active stream scheme
(`Imce::access()` / `roles_profiles` in `imce.settings`).

## Folder-level permissions (per profile, per folder)
These are not Drupal permissions but checkboxes stored on each folder in a profile,
contributed by ImcePlugin `permissionInfo()`:
- `browse_files`, `upload_files`, `delete_files` (Core/Upload/Delete plugins)
- `resize_images` (Resize plugin)
- subfolder create/delete (Newfolder plugin)
- plus any keys added by custom plugins.

Configure them in the profile — see [../configure/profiles.md](../configure/profiles.md).
