<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `acquia_cms_place.permissions.yml`. All are the standard per-bundle node permissions
(`provider: node`) for the `place` content type:

| Permission | Title | Notes |
|------------|-------|-------|
| `create place content` | Place: Create new content | |
| `edit own place content` | Place: Edit own content | Anonymous users with this can edit any anon-authored content |
| `delete own place content` | Place: Delete own content | Anonymous users with this can delete any anon-authored content |
| `edit any place content` | Place: Edit any content | |
| `delete any place content` | Place: Delete any content | |

These are ordinary content permissions — assign them on `admin/people/permissions` or with
`drush role:perm:add <role> '<permission>'`. There is no custom access handler; access follows core
node access.

## Automatic role grants

`acquia_cms_place.install` implements `hook_content_model_role_presave_alter()` (an
`acquia_cms_common` hook). When the family's `content_author` / `content_editor` roles are (re)saved
it grants:

- `content_author` → `create place content`, `edit own place content`, `delete own place content`.
- `content_editor` → `edit any place content`, `delete any place content`.

This only fires on those specific role IDs and only when `acquia_cms_common`'s role-presave alter is
invoked; on a non-Acquia-CMS site you assign the permissions yourself.
