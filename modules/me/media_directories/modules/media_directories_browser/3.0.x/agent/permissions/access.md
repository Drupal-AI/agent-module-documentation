<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

`media_directories_browser.permissions.yml` defines exactly one permission:

```yaml
access media directories browser:
  title: 'Access Media Directories browser'
  description: 'Access the Media Directories Vue browser interface'
```

## What it gates

- The browser page `/admin/content/media-browser` (`media_directories_browser.admin`).
- **Every** `/api/media-directories-browser/*` route — listing, uploading, updating,
  deleting and moving media, and all directory CRUD/reorder.
- The three AI routes added by `media_directories_ai`
  (`ai/alt-text`, `ai/alt-text-from-file`, `ai/translate`).

So this single permission is the whole gate on a JSON API that can create, modify and delete
media entities and taxonomy terms. **Treat it as a privileged permission** and grant it only
to editorial roles.

Not gated by it:
- `media_directories_browser.config_form` → `administer site configuration`.
- `media_directories_browser.media_quick_edit` → `_entity_access: media.update`.

Note the API routes check only this permission, not per-entity media access, so a role with
it can act on any media item the browser lists.

## Grant / audit

```bash
drush role:perm:add editor 'access media directories browser'
drush role:perm:remove anonymous 'access media directories browser'

# Who has it?
drush php:eval '
  foreach (\Drupal\user\Entity\Role::loadMultiple() as $role) {
    if ($role->hasPermission("access media directories browser")) { print $role->id() . "\n"; }
  }'
```

The deprecated `media_directories_ui` submodule defines a *different* permission,
`access media directories ui browser`, for its old entity_browser UI — they are not
interchangeable.
