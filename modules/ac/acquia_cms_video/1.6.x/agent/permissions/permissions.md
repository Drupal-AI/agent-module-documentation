# Permissions

`acquia_cms_video.permissions.yml` statically declares the five standard per-bundle Media permissions for
the `video` bundle. Each sets `provider: media`, so they appear under the **Media** module on the
permissions UI even though this module is what declares them.

| Permission | Title | Grants |
|-----------|-------|--------|
| `create video media` | Video: Create new media | Create Video media items |
| `edit own video media` | Video: Edit own media | Edit own Video items |
| `delete own video media` | Video: Delete own media | Delete own Video items |
| `edit any video media` | Video: Edit any media | Edit any Video item |
| `delete any video media` | Video: Delete any media | Delete any Video item |

These are the same permission strings core Media generates dynamically per bundle; the module declares
them explicitly so they exist independent of that.

## Who gets them by default

They are auto-granted to the Acquia CMS content roles by
`acquia_cms_video_content_model_role_presave_alter()` (see [../hooks/hooks.md](../hooks/hooks.md)), which
fires when `acquia_cms_common` presaves its content roles:

- **`content_author`** → `create video media`, `edit own video media`, `delete own video media`
- **`content_editor`** → `edit any video media`, `delete any video media`

Grant to any other role via drush:

```
drush role:perm:add editor 'edit any video media'
```

Viewing Video media itself is governed by core Media entity access (e.g. `view media`), not by a
permission defined here.
