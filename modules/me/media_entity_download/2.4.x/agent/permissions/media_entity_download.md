# Permissions

Defined in `media_entity_download.permissions.yml`.

| Permission | Gates |
|---|---|
| `download media` | Access to the `media_entity_download.download` route (`/media/{media}/download`) — i.e. streaming/downloading a media entity's file. |

## Access model

The download route requires **both**:

1. `_permission: 'download media'`, and
2. `_entity_access: media.view` — the user must be able to view the specific media entity.

So a user can only download a file if they hold `download media` **and** have view access to
that media item. Additionally, `DownloadController` invokes `hook_file_download($uri)` for the
served file; any implementation returning `-1` causes an `AccessDeniedHttpException` (403),
letting other modules (e.g. private-file access rules) veto the download.

```
drush role:perm:add anonymous 'download media'
```
