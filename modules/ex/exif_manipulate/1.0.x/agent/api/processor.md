<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EXIF processor service, upload hook & QueueWorker

How the module reads and rewrites image metadata. All EXIF work is done in pure PHP through the
`fileeye/pel` (`lsolesen\pel`) library — there is **no external binary and no shell command**.

## Install / enable

`composer require drupal/exif_manipulate` (pulls in `fileeye/pel:^0.10.0`), then
`drush en exif_manipulate`. New uploads are cleaned immediately; nothing else is required.
Uses core `file`; declares no other Drupal module dependency.

## Service: `FileExifProcessor::manipulate()`

File: `src/Services/FileExifProcessor.php` (service id `exif_manipulate.file_exif_processor`,
interface `FileExifProcessorInterface` with the single method `manipulate(FileInterface $file): void`).

Flow of `manipulate()`:
1. Read `$file->getMimeType()` and `$file->uri->value`.
2. `getFile($mimeType, $uri)` — a `match`: `image/jpeg` → `new PelJpeg($uri)`, `image/tiff` →
   `new PelTiff($uri)`, **any other MIME → NULL** (so only JPEG/TIFF are ever touched).
3. If a PEL object came back, `$exif = $pelFile->getExif()`; when EXIF exists:
   - `getOrientation($exif)` walks `PelExif → getTiff() → getIfd() → getEntry(PelTag::ORIENTATION)`
     and returns a fresh `PelEntryShort` copy (or NULL).
   - `$pelFile->clearExif()` removes **all** EXIF.
   - if an orientation was captured, `setOrientation()` rebuilds a minimal `PelExif`/`PelTiff`/`PelIfd(IFD0)`
     and re-adds only that orientation entry.
   - `$pelFile->saveFile($uri)` writes the stripped image back to the same URI (in place).

So the net effect is: strip everything except the ORIENTATION tag. The processor operates only on the
managed file's own stored URI — it takes no request- or config-supplied path.

## Upload hook: `Hooks\FileEntity::fileInsert()`

`exif_manipulate.module`'s `exif_manipulate_file_insert(File $file)` resolves
`Hooks\FileEntity` via `\Drupal::classResolver()` and calls `fileInsert()`. `FileEntity` is a
`final` `ContainerInjectionInterface` service injecting the processor, `messenger`, and the
`logger.channel.exif_manipulate` channel. `fileInsert()` calls `manipulate()` inside try/catch:
on `PelException` it logs via `Error::logException()` and adds a warning message
("There was a problem removing the metadata from your file."). This fires for **every** created
`file` entity regardless of source (field upload, media, programmatic).

## QueueWorker: `exif_manipulate_clean_exif_data`

`src/Plugin/QueueWorker/CleanExifDataQueueWorker.php` (annotation `id = "exif_manipulate_clean_exif_data"`,
`cron = {"time" = 60}`). `processItem($data)` loads file entities by
`->loadByProperties(['uri' => $data['uri']])`, takes the first, and calls
`$this->fileExifProcessor->manipulate($file)`. Load failures and per-file exceptions are caught and
logged to the module channel; the item is otherwise consumed. Items are enqueued only by the confirm
form (see [config/clean-images-form.md](../config/clean-images-form.md)).

## Uninstall

`exif_manipulate.install` `hook_uninstall()` deletes the `exif_manipulate_clean_exif_data` queue and
the `exif_manipulate_clean_exif_data_total` state value.

## Notes

- Only `image/jpeg` and `image/tiff` are processed; PNG/WebP/GIF pass through unchanged.
- The ORIENTATION tag is intentionally kept so `exif_orientation` and correct display are unaffected.
- README states the module is designed with extension points to later **insert** metadata, not only strip it;
  as of 1.0.1 `manipulate()` only strips (plus orientation preservation).
