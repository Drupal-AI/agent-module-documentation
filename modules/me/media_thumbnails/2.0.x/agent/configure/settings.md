<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Media Thumbnails

## The config object

```yaml
# media_thumbnails.settings  (config/install default)
bgcolor_active: false
bgcolor_value: '#eeeeee'
width: 500
no_thumbnail_update: false
allow_thumbnail_edit: false
```

| Key | Type | Meaning |
|---|---|---|
| `width` | integer | Target thumbnail width in px; height is derived by the plugin. |
| `bgcolor_active` | boolean | Flatten transparent thumbnails onto `bgcolor_value` instead of keeping transparency (plugins that support it). |
| `bgcolor_value` | string | Hex colour, e.g. `'#eeeeee'` (form element type `color`). |
| `no_thumbnail_update` | boolean | On media **update**, do not overwrite the thumbnail — except when it is still a generic icon under `media.settings:icon_base_uri`. |
| `allow_thumbnail_edit` | boolean | Makes the media `thumbnail` base field display-configurable on forms, so it can be added to a media type's *Manage form display* and uploaded by hand. |

The whole settings array is passed to each plugin as its `$configuration`, so plugins read
`$this->configuration['width']` etc.

## Admin UI

| Purpose | Route | Path | Form |
|---|---|---|---|
| Settings (`configure` route) | `media_thumbnails.admin` | `/admin/config/media/thumbnails` | `MediaThumbnailConfigForm` |
| Refresh all thumbnails | `media_thumbnails.refresh` | `/admin/config/media/thumbnails/refresh` | `MediaThumbnailRefreshForm` (confirm form) |

Both require the permission **`manage media thumbnails settings`**
("Allows to manage media entity thumbnails settings."). Menu entry: *Configuration → Media →
Media Thumbnails*; the two routes appear as **Configure** / **Refresh** local tasks.

## Set it from the command line

```bash
drush cget media_thumbnails.settings
drush cset media_thumbnails.settings width 250 -y
drush cset media_thumbnails.settings bgcolor_active 1 -y
drush cset media_thumbnails.settings bgcolor_value '#123456' -y
```

```php
\Drupal::configFactory()->getEditable('media_thumbnails.settings')
  ->set('width', 250)
  ->set('bgcolor_active', TRUE)
  ->set('bgcolor_value', '#123456')
  ->save();
```

Changing `width` does **not** rebuild existing thumbnails — run the refresh batch
(see [../drush/refresh.md](../drush/refresh.md)).

## Letting editors upload a thumbnail

1. `drush cset media_thumbnails.settings allow_thumbnail_edit 1 -y`
2. `drush cr` (the flag is read by `hook_entity_base_field_info_alter()`).
3. Add the **Thumbnail** field to the media type's *Manage form display*.
4. Usually pair it with `no_thumbnail_update: true` so a save does not overwrite the upload.

## Grant the permission

```bash
drush role:perm:add media_manager 'manage media thumbnails settings'
```
