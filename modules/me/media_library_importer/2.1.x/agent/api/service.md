# Service API — `media_library_importer.service`

Class `Drupal\media_library_importer\MediaLibraryImporterService`. Inject the service id
`media_library_importer.service` (or `\Drupal::service('media_library_importer.service')`).

## Public methods

| Method | Purpose |
|---|---|
| `generateImportQueue(array $media_folders = [])` | (Re)builds the `media_library_importer` queue. Deletes any existing queue first (avoids dup items), then for each folder globs matching files, creates the File entity, checks `mediaEntityExists()`, invokes the extra-fields alter, and enqueues `{bundle, file, extra_fields}`. With no argument it scans all folders under `import_folder`. |
| `processImportQueue()` | Runs the queue as a batch via `queue_ui.batch` (`QueueUIBatchInterface::batch(['media_library_importer'])`). |
| `createMediaEntity(string $bundle, FileInterface $file, array $extra_fields)` | Creates + saves a published Media of `$bundle`, name = filename, file set on the mapped field, merged with `$extra_fields`. Called by the queue worker. |
| `getMediaTypes(): array` | `id => "Label (id)"` for all media types. |
| `getMediaFolders($files_path = NULL): array` | Nested folder tree (name/path/uri/media_count/subdir) under a path; honors `exclude_styles`. |
| `getMediaFoldersCheckboxOptions(array $folders, int $level = 0): array` | Flattens the tree into `path => indented label (count)` options. |
| public `$realPath` | Real path of the default-scheme (`public://`) root; used to map filesystem paths to `public://` URIs. |

## Cron / incremental import (README pattern)

```php
function mymodule_cron() {
  /** @var \Drupal\media_library_importer\MediaLibraryImporterService $svc */
  $svc = \Drupal::service('media_library_importer.service');
  $svc->generateImportQueue();
  // Then let cron drain the queue (worker has cron time 10s), or:
  $svc->processImportQueue();
}
```

## Import mechanics

- File matching: `glob("$folder/*.{" . $extensions . "}", GLOB_BRACE)`; `$extensions` = union of selected media
  types' source-field `file_extensions`.
- URI mapping: `str_replace($this->realPath, 'public:/', $file_url)` — files under the public root become
  `public://…` URIs; files OUTSIDE the public root keep their absolute path as the File `uri`.
- Copy-vs-in-place governed by `import_files_to_media_location` (see `createFileEntity()`).
- Dedup: `mediaEntityExists($file, $bundle)` runs an entity query (`accessCheck(FALSE)`) on bundle + name; queue
  item is skipped when a match exists. Queue worker: `Plugin/QueueWorker/MediaLibraryImporterQueue` (`processItem`
  → `createMediaEntity`).
- New File/Media entities are owned by `currentUser` (or uid of the process) and created with `status = 1`.
