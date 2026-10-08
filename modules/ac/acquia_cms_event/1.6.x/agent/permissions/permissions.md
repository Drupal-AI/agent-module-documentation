<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `acquia_cms_event.permissions.yml`. All are the standard per-bundle node permissions
(`provider: node`) for the `event` content type:

| Permission | Title | Notes |
|------------|-------|-------|
| `create event content` | Event: Create new content | |
| `edit own event content` | Event: Edit own Content | Anonymous users with this can edit any anon-authored content |
| `delete own event content` | Event: Delete own content | Anonymous users with this can delete any anon-authored content |
| `edit any event content` | Event: Edit any content | |
| `delete any event content` | Event: Delete any content | |

These are ordinary content permissions — assign them on `admin/people/permissions` or with
`drush role:perm:add <role> '<permission>'`. There is no custom access handler; access follows core
node access.

## Automatic role grants

`acquia_cms_event.install` implements `hook_content_model_role_presave_alter()` (an
`acquia_cms_common` hook). When the family's `content_author` / `content_editor` roles are (re)saved
it grants:

- `content_author` → `create event content`, `edit own event content`, `delete own event content`.
- `content_editor` → `edit any event content`, `delete any event content`.

This only fires on those specific role IDs and only when `acquia_cms_common`'s role-presave alter is
invoked; on a non-Acquia-CMS site you assign the permissions yourself.
