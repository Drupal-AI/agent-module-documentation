<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Download route, ZIP build, caching

## Route

`media_download_all.routing.yml`:

```yaml
media_download_all.download_path:
  path: '/media_download_all/{entity_type}/{entity_id}/{field_name}'
  defaults:
    _controller: '\Drupal\media_download_all\Controller\DownloadController::download'
  requirements:
    _custom_access: '\Drupal\media_download_all\Controller\DownloadController::access'
```

All three parameters come from the URL. `DownloadController` (`src/Controller/DownloadController.php`)
injects `entity_field.manager`, `file_system`, `request_stack`.

## Access (`DownloadController::access`)

```php
public function access($entity_type, $entity_id, $field_name) {
  $entity = $this->entityTypeManager()->getStorage($entity_type)->load($entity_id);
  if ($this->currentUser()->hasPermission('view media')) {
    return $entity->access('view', NULL, TRUE);
  }
  return AccessResult::forbidden();
}
```

Grants access only when the current user has the global **`view media`** permission **and** has
`view` access to the **host entity** (`$entity->access('view')`). The check is on the host entity
and the global media permission.

## `download($entity_type, $entity_id, $field_name)`

1. `cid = "media_download_all:$entity_type:$entity_id"`. Reads the permanent cache entry; if
   `$cached_files[$field_name]` is set and that file still exists, streams it (skip to §Streaming).
2. `getFiles()` collects the file ids to bundle (see below).
3. If no files, adds an error message and `RedirectResponse` back to `HTTP_REFERER` (or
   `"$entity_type/$entity_id"`).
4. Target path: `private://media_download_all/{entity_type}-{entity_id}-{field_name}.zip`
   (resolved with `file_system->realpath`). `prepareDirectory(..., CREATE_DIRECTORY)` creates the
   dir if needed.
5. `batch_set(getBatch(...))` + `batch_process($referer)` — one batch operation per file.

If the private directory cannot be prepared, it errors and redirects.

## `getFiles($entity_type, $entity_id, $field_name)`

- Loads the host entity, reads `$entity->{$field_name}->getValue()`, and collects each item's
  `target_id` as a **media id**.
- `loadMultiple()` those media entities. For each media, `getFileFieldsOfBundle($bundle)` returns
  every field on the media bundle whose storage `target_type === 'file'` **except** `thumbnail`.
- For each such field, each item's `target_id` (a **file id**) is added to the result map
  `files[fid] = $media->getName()`.

So the archive contains the files behind every non-thumbnail file field of every referenced media
item.

## ZIP build (batch + `Plugin\Archiver\Zip`)

- `media_download_all_operation($file_path, ..., $fid, $file_name, &$context)` (in
  `media_download_all.module`): `new Zip($file_path, TRUE)` (append mode), `->add($fid)`, `->close()`.
- `Zip::__construct` opens the `\ZipArchive` in `CREATE`, `OVERWRITE` (new), or plain open (append,
  when the file exists) mode.
- `Zip::add($fid)` loads the `file` entity, entry name `"{fid} - {label}"`. If the URI scheme is an
  **Aliyun OSS** flysystem schema (read from `settings.php` `flysystem` config), it fetches the
  file over its absolute URL with `file_get_contents` and `addFromString`; otherwise it
  `addFile(realpath(uri), name)`.
- `media_download_all_operation_finished` writes `cached_files[$field_name] = $file_path` into the
  permanent cache under `cid` with tags `['media_download_all', "{entity_type}:{entity_id}"]`, then
  shows a message linking to the same download route (which now streams the cached file).

## Streaming (`streamZipFile`)

`new BinaryFileResponse($file_path)` with `Content-Disposition: attachment; filename=basename(...)`.
Note this serves the resolved private path directly through this route's access check (not through
core's private-file download pipeline).

## Cache invalidation (`Cache\MdaCacheTagsInvalidator`)

Tagged `cache_tags_invalidator` (priority 100). On `invalidateTags()`, for any tag shaped
`{entity_type}:{id}` (numeric id, known entity type) it loads `media_download_all:{type}:{id}`,
`unlink()`s each cached ZIP path, and deletes the cache entry — so editing the host entity discards
its stale archive. `break`s after the first matching tag.

## Operational notes

- Building the ZIP is a **batch** run in the browser (progress bar), then a message provides the
  download link; the second request streams the finished file.
- Temp ZIP names are deterministic (`{type}-{id}-{field}.zip`) in `private://media_download_all/`.
- Large media sets = proportional time/memory + disk for the archive.
- README stresses the **private** file system; using public would expose the temp ZIPs directly.
