<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions and roles

Lightning Media defines **no permissions of its own** — there is no
`lightning_media.permissions.yml`. Its only route requires core's
`administer site configuration`:

```yaml
lightning_media.settings:
  path: '/admin/config/system/lightning/media'
  requirements:
    _permission: 'administer site configuration'
```

## The two shipped roles

`config/optional/user.role.media_creator.yml` and `user.role.media_manager.yml` — both
declare `dependencies.module: [lightning_roles]`, so **they are only created when the
`lightning_roles` module is installed**. On a site without it, `drush role:list` will not
show them.

| Role | Permissions |
|---|---|
| `media_creator` ("Media creator", weight 5) | `access media overview`, `create media`, `delete media`, `update media` |
| `media_manager` ("Media manager", weight 6) | `access media overview`, `administer media`, `administer media types` |

`help/media_roles.md` spells out the distinction: **Media creator** can create, edit and
delete *its own* media only — it deliberately does not get `update any media` /
`delete any media`. **Media manager** can administer all media created by anybody.

## Permissions granted by hooks

| Hook | Grant |
|---|---|
| `lightning_media_modules_installed()` | when `lightning_roles` is installed, grants `use text format rich_text` to the Lightning `creator` content role via `lightning.content_roles` |
| `lightning_media_image_modules_installed()` / `_install()` | when `lightning_roles` is installed **and** the `image_browser` entity browser exists, grants `access image_browser entity browser pages` to `media_creator`, `media_manager` and the `creator` content role |
| `lightning_media_bulk_upload_install()` | grants `dropzone upload files` to `media_creator` |

Those last two run unconditionally at install time and will fail silently (or warn) if the
roles do not exist because `lightning_roles` is absent.

## Doing it yourself without `lightning_roles`

```bash
drush role:create media_creator 'Media creator'
drush role:perm:add media_creator 'access media overview,create media,update media,delete media'
drush role:create media_manager 'Media manager'
drush role:perm:add media_manager 'access media overview,administer media,administer media types'
# only if lightning_media_bulk_upload is enabled:
drush role:perm:add media_creator 'dropzone upload files'
```

Relevant core permissions when wiring editors up: `access media overview`,
`create media`, `create <type> media`, `update media`, `update any media`, `delete media`,
`delete any media`, `administer media`, `administer media types`, `view media`,
plus `access content` for the media library widget.
