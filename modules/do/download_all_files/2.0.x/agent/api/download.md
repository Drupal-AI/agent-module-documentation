# Download route, controller and archiver (API)

## Route — `download_all_files.download_path`

`download_all_files.routing.yml`:

```yaml
download_all_files.download_path:
  path: '/download_all_files/{entity_type}/{entity}/{field_name}'
  defaults:
    _controller: '\Drupal\download_all_files\Controller\DownloadController::downloadAllFiles'
  requirements:
    _custom_access: '\Drupal\download_all_files\Controller\DownloadController::access'
  options:
    parameters:
      entity:
        type: entity:{entity_type}
```

- `{entity_type}` + `{entity}`: upcast to a loaded entity of that type via the `entity:{entity_type}`
  parameter converter, so `{entity}` is the entity id.
- `{field_name}`: a free string — the machine name of the field on that entity to bundle.
- Build the URL from code with
  `Url::fromRoute('download_all_files.download_path', ['entity_type' => …, 'entity' => …, 'field_name' => …])`.
  The formatter does exactly this (`DownloadAllFormatter::viewElements`).

## Access — `DownloadController::access`

`src/Controller/DownloadController.php:65`:

```php
public function access(AccountInterface $account, EntityInterface $entity): AccessResultInterface {
  return $entity->access('view', $account, TRUE);
}
```

Access is granted when the caller may **view the entity**. The entity is upcast from the route.

## Controller — `DownloadController::downloadAllFiles`

`src/Controller/DownloadController.php:86`. Signature:
`downloadAllFiles(Request $request, FieldableEntityInterface $entity, string $field_name): Response`.
Constructor DI: `file_system`, `event_dispatcher` (see `create()`).

Flow:

1. `if (!$entity->hasField($field_name)) throw new NotFoundHttpException();`
2. Compute the temp archive path:
   `getTempDirectory() . '/daf_zips/' . $entity->getEntityTypeId() . '/' .
   sanitizeFilename("{id}-{langcode}-{field_name}-{uid}.zip")`, and the download filename
   `sanitizeFilename("{entity label} - {field_name}.zip")`.
3. Read `$entity->get($field_name)->getValue()`; for each delta, load the `file` entity by
   `$file['target_id']`, and collect its URI when
   `$file_obj instanceof FileInterface && $file_obj->access('view')`.
4. If no files collected → `messenger()->addError(...)` and `RedirectResponse` back to `HTTP_REFERER`
   (defaulting to `/`).
5. `fileSystem->prepareDirectory($zip_files_directory, CREATE_DIRECTORY | MODIFY_PERMISSIONS)`; on
   failure → error message + redirect.
6. `new Zip($file_path)`; for each URI `add(realpath($uri))`; `close()`.
7. Return `BinaryFileResponse($file_path)` with
   `setContentDisposition(DISPOSITION_ATTACHMENT, $file_name)`.

Returns: a `BinaryFileResponse` (the zip) on success, otherwise a `RedirectResponse`. Throws
`NotFoundHttpException` when the field does not exist on the entity.

### `sanitizeFilename($filename)`

`src/Controller/DownloadController.php:139` — strips `/` from the name, then dispatches a
`FileUploadSanitizeNameEvent($name, 'zip')` and returns `$event->getFilename()`.

## Archiver plugin — `Zip` (`DownloadAllFileZip`)

`src/Plugin/Archiver/Zip.php`, `@Archiver(id = "DownloadAllFileZip", extensions = {"zip"})`, extends
`Drupal\Core\Archiver\Zip`.

- `__construct($file_path)` — opens a `\ZipArchive` with `OVERWRITE` if the file exists, else
  `CREATE`; throws `ArchiverException` on failure.
- `add($file_path)` — `zip->addFile($file_path, basename($file_path))` (archive member is the base
  name only).
- `close()` — closes the archive.
