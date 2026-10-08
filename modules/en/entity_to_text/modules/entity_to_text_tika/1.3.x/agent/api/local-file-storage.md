<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalFileStorage — on-disk OCR cache

Class `Drupal\entity_to_text_tika\Storage\LocalFileStorage`
(`modules/entity_to_text_tika/src/Storage/LocalFileStorage.php`), implements `StorageInterface`
(`src/Storage/StorageInterface.php`). Service id **`entity_to_text_tika.storage.local_file`**.
Constructor args: `@file_system`, `@logger.factory`, `@stream_wrapper_manager`.

Caches Tika-extracted text so warmup / repeated reads avoid re-hitting Tika.

## Destination

Constant `DESTINATION = 'private://entity-to-text/ocr'`. Cached filename (per file + langcode):
`{fid}-{filename}.{langcode}.ocr.txt` (built in private `getFullPath()`). `getFullPath()` validates the
scheme via the stream wrapper manager and throws `\RuntimeException` if `private://` is not a valid
wrapper or cannot be resolved to a real directory.

## Methods (StorageInterface)

- `load(File $file, string $langcode = 'eng'): ?string` — returns the cached text via
  `file_get_contents()`, or `NULL` if the `.ocr.txt` file does not exist.
- `save(File $file, string $content, string $langcode = 'eng'): string` — writes the text with
  `file_put_contents()` and returns the full path.
- `prepareStorage(): void` — creates the destination directory
  (`file_system->prepareDirectory(DESTINATION, CREATE_DIRECTORY)`).

## Recommended pattern (from README)

```php
\Drupal::service('entity_to_text_tika.storage.local_file')->prepareStorage();

$body = \Drupal::service('entity_to_text_tika.storage.local_file')->load($file, 'eng+fra');
if (!$body) {
  $body = \Drupal::service('entity_to_text_tika.extractor.file_to_text')->fromFileToText($file, 'eng+fra');
  \Drupal::service('entity_to_text_tika.storage.local_file')->save($file, $body, 'eng+fra');
}
```

## Requirements check

`EntityToTextTikaRequirementsHook::runtime()` (`src/Hook/EntityToTextTikaRequirementsHook.php`,
`#[Hook('runtime_requirements')]`) reports on the status page whether `private://` is set and writable
(INFO if the private scheme is missing, ERROR if the resolved private directory is not writable). The
legacy `entity_to_text_tika_requirements()` in `.install` delegates to the same hook class.
