# Hook wiring — `hook_file_insert()`

The module's only entry point. `svg_upload_sanitizer.module` implements `hook_file_insert()`:

```php
function svg_upload_sanitizer_file_insert(FileInterface $file) {
  return \Drupal::service('class_resolver')
    ->getInstanceFromDefinition(FileInsertHookHandler::class)
    ->process($file);
}
```

## When it fires

`hook_file_insert()` runs from the `File` entity storage whenever a **managed file is INSERTed**
(saved for the first time). This is the file-entity layer, not a per-field or per-form hook, so it
covers every path that creates a managed `File`:

- file / image field widgets (managed_file),
- the Media library and media source upload,
- Webform / Contact / custom `#type = managed_file` elements,
- the REST + JSON:API file-upload resource (`POST …/file/upload`),
- programmatic `File::create([...])->save()`.

It fires on the **temporary** file created during upload (status 0). Later, when the referencing
entity is submitted and the file is made permanent, the entity is `save()`d again → that is an UPDATE
(`hook_file_update`), which this module does **not** implement. The sanitisation therefore happens once,
at first insert, and any subsequent move of the (already-cleaned) bytes carries the sanitised content.

It does **not** run for files that never become a managed `File` entity — e.g. assets placed on disk by
rsync, a migration writing directly to the stream wrapper, or `file_put_contents()` without a `File`
save.

## What `process()` does

`Drupal\svg_upload_sanitizer\HookHandler\FileInsertHookHandler::process()`
(`src/HookHandler/FileInsertHookHandler.php:68`):

1. `$this->sanitizerHelper->sanitize($file)` — clean the file. If it returns `FALSE`, `process()`
   returns `FALSE` and stops.
2. `$this->fileHelper->updateSize($file)` — refresh the entity's stored size and `save()` it (the
   sanitised file is usually smaller/different).

## `SanitizerHelper::sanitize()` (`src/Helper/SanitizerHelper.php`)

1. **MIME gate** (`:60`): returns `FALSE` (skips) unless `$file->getMimeType() === 'image/svg+xml'`.
   In the normal upload flow the File entity's `filemime` is set from the extension-based MIME guesser
   before save, so a `.svg` upload arrives here as `image/svg+xml`.
2. Resolves the real path with `file_system->realpath($file->getFileUri())`; logs a notice and returns
   `FALSE` if it can't be resolved or the file is missing/empty.
3. Reads the bytes with `file_get_contents()`.
4. `$clean = $this->sanitizer->sanitize($content)` — delegates to the `enshrined\svgSanitize\Sanitizer`
   service (see [../api/services.md](../api/services.md)).
5. Writes the cleaned bytes back **in place** with `file_put_contents($filePath, $clean)`; throws
   `\Exception` if the write fails.

The clean happens on the stored file itself (in place), so the sanitised bytes are what is served
afterwards. Sanitising on upload rather than on output is deliberate — output filtering can be bypassed
by linking the raw file directly.
