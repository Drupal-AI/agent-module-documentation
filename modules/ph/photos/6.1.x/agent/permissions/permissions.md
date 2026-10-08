<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `photos.permissions.yml` (7 permissions). Photo access is enforced by
`Drupal\photos\PhotosAccessControlHandler` (and, when photos_access is on, by node grants).

| Permission | Gates |
|---|---|
| `view photo` | Viewing photos (`photos_image` entities). |
| `create photo` | Creating/uploading photos (also gates `/photos/image/add`). |
| `edit own photo` | Editing photos the user owns. |
| `delete own photo` | Deleting photos the user owns. |
| `edit any photo` | Editing **any** photo in any album (restricted — trusted roles). |
| `delete any photo` | Deleting **any** photo in any album (restricted). |
| `view original` | Viewing/downloading the original full-size image. |

Notes:
- `edit any photo` and `delete any photo` are marked `restrict access: true` (grant only to
  trusted roles).
- Most **admin** routes (settings, structure, import, the photos collection) use the core
  `administer nodes` permission, and the `photos_image` entity's `admin_permission` is
  `administer nodes` — so site builders/admins need `administer nodes`, not a photos-specific
  permission, to manage configuration.
- Album (node) create/edit/delete follows normal node permissions for the `photos` content type
  (e.g. `create photos content`), which are separate from the per-photo permissions above.
- Grant via drush, e.g.: `drush role:perm:add editor 'create photo,edit own photo'`.
