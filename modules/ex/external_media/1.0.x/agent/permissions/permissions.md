# Permissions

External Media declares **no static permissions**. `external_media.permissions.yml`
contains only:

```yaml
permission_callbacks:
  - \Drupal\external_media\Controller\ExternalMediaController::permissions
```

## Dynamically generated permissions

`ExternalMediaController::permissions()` iterates every `ExternalMedia` plugin and, for
each plugin whose `classExists()` returns TRUE, emits one permission:

| Permission machine name | Title | Grants |
|---|---|---|
| `upload from <plugin_id>` | *Use `<Service name>`* | Upload files from that service. |

With the four bundled providers this yields:

| Permission | Service |
|---|---|
| `upload from dropbox_chooser` | Dropbox |
| `upload from box_picker` | Box |
| `upload from google_drive` | Google Drive |
| `upload from onedrive_picker` | OneDrive |

A provider whose required SDK/class is missing (`classExists()` FALSE) yields **no
permission at all** and disappears from the permissions page.

## Where the permission is checked

- Rendering the widget buttons — `ExternalMediaFile::processManagedFile()` shows a
  service button only if the current user `hasPermission('upload from ' . $plugin_id)`,
  the plugin is `enabled`, and `classExists()`.
- `getPluginList()` (used by the widget settings form) filters services the same way.

## Other permission

- `administer site configuration` — required to reach the settings form route
  `external_media.settings` (see [../configure/settings.md](../configure/settings.md)).

Grant example: `drush role:perm:add editor 'upload from dropbox_chooser'`.
