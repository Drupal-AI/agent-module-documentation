<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: `thumbnails:refresh`

`drush.services.yml` registers one command class,
`\Drupal\media_thumbnails\Commands\MediaThumbnailCommands` (no constructor arguments).

| Command | Aliases | Effect |
|---|---|---|
| `thumbnails:refresh` | `thref`, `thumbnails-refresh` | Re-saves **every** media entity so `hook_media_presave()` regenerates its thumbnail |

```bash
drush thumbnails:refresh
drush thref
```

The command sets the batch from `RefreshBatch::createBatch()`, forces
`$batch['progressive'] = FALSE`, and runs `drush_backend_batch_process()` — so it completes
synchronously in one CLI invocation.

## The batch

`Drupal\media_thumbnails\Batch\RefreshBatch`:

- `createBatch()` — queries **all** media ids (`accessCheck(FALSE)`) and returns a single
  operation over that id array; title *"Refreshing media entity thumbnails"*.
- `process()` — loads and `save()`s one media entity per iteration; storage exceptions are
  logged to the `media` channel and skipped.
- `count()` — aggregate count of media entities, used for the progress ratio and for the
  confirm form's description.
- `finished()` — messenger message *"Processed @processed media entities."*

The same batch is triggered from the UI confirm form at
`/admin/config/media/thumbnails/refresh` ("Refresh the thumbnails for all media entities?",
confirm button **Refresh**, cancel returns to `media_thumbnails.admin`).

## When to run it

- After changing `width` or the background-colour settings.
- After installing, removing or replacing a `@MediaThumbnail` plugin module.
- After migrating media files to a different file system.
- Before uninstalling Media Thumbnails, once the plugin modules are gone — that restores
  core's default thumbnails.

There is no per-entity or per-bundle option: it always processes every media entity. For a
subset, re-save the entities yourself:

```php
foreach (\Drupal::entityTypeManager()->getStorage('media')->loadByProperties(['bundle' => 'document']) as $media) {
  $media->save();
}
```
