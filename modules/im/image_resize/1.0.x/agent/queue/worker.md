<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The resize/convert queue worker

## Enqueue trigger

`image_resize_file_insert(FileInterface $file)` (`image_resize.module`) fires on every managed
**file insert**. It enqueues the file id onto queue `image_resize` only when:

- `$file->getMimeType()` is in `image_resize.settings:mimetypes`, **and**
- `min_filesize` is set **and** `$file->getSize()` is greater than it.

Caveat from source: because the `min_filesize` check is inside the same `if`, when `min_filesize`
is empty/`null` **no file is enqueued on insert** — new files are processed only via the settings
form's "Requeue existing images" batch (or another module putting ids on the queue). Existing
files are never auto-processed.

## Worker plugin

`Plugin\QueueWorker\ImageResize` — `@QueueWorker(id = "image_resize", cron = {"time" = 60})`, so
cron drains it up to 60s per run; `drush queue:run image_resize` drains it on demand. Services
injected via `create()`: `file_system`, `config.factory`, `image.factory`,
`image_resize.imagemagick_event_subscriber`, and `file_metadata_manager` **only if present**.

## `processItem($data)` pipeline (per file id)

1. `File::load($data)`; return if gone.
2. **Missing-file recovery** — if the file URI does not exist on disk **and**
   `stage_file_proxy.settings:origin` is configured, build
   `origin . $file->createFileUrl()`, `file_get_contents()` it, and write it back to the file URI
   (creating the directory). If still missing afterwards, log an error and return. (Origin is admin
   config from stage_file_proxy; the file URL derives from the managed file entity — no
   request-supplied input.)
3. **Detect dimensions** — find a referencing `image` field item via
   `file_get_file_references(... 'image')`; use its stored `width`/`height` if set, else load the
   file through `image.factory` and read the actual dimensions. Log + return if neither yields a
   size.
4. **Decide whether to convert** — `$convert = TRUE` if
   `SizeCalculator::resize(resize_type, width, height, cfg_width, cfg_height)` returns a new size,
   **or** `extension` is set and differs from the file's current extension. If neither, return
   (nothing to do).
5. **Scale** — if a new size was computed, `$image->scale($new_width, $new_height)`.
6. **Convert** — if `extension` differs from the current one, `$image->convert(extension)` and
   compute a new URI (old extension replaced), made unique with
   `getDestinationFilename(..., EXISTS_RENAME)`.
7. **Save** — set the subscriber's `isResizing = TRUE` (so the ImageMagick `-quality` argument is
   added), `$image->save($new_uri)`, then `isResizing = FALSE`. On a URI change, delete the old
   file and update the file entity's URI, filename and MIME type (guessed via
   `file.mime_type.guesser`).
8. **Persist** — update the file entity's size and save; reload the image to read final
   dimensions; update `width`/`height` on all referencing image-field items and save each changed
   referencing entity once. Log a notice summarising old/new name, size, resolution, time and how
   many referencing entities were updated.

## `SizeCalculator::resize()` (`src/SizeCalculator.php`)

Pure static, returns `[new_width, new_height]` or `NULL`:

- `max` mode: if the image is larger than the box on either axis
  (`width_ratio > 1 || height_ratio > 1`), scale down by the **larger** ratio so it fits inside.
- `min` mode: only if larger on **both** axes (`width_ratio > 1 && height_ratio > 1`), scale down
  by the **smaller** ratio so both sides stay at least the target.
- Otherwise `NULL` (no resize).

## ImageMagick quality hook

`EventSubscriber\ImagemagickEventSubscriber` subscribes to `imagemagick.convert.preExecute`
(priority 100; event name given as a **string** to avoid a hard dependency on `imagemagick`).
`preConvertExecute()` appends `['-quality', (string) $quality]` to the convert arguments **only
while** the worker has set `isResizing = TRUE` and `image_resize.settings:quality` is set. With a
non-ImageMagick toolkit the quality field is disabled in the form and this hook does not apply.

## Operating notes

- The conversion **overwrites the original managed file** and is irreversible — back up first.
- Only the current default revision of referencing entities gets its stored width/height updated;
  pending/forward and past revisions are not touched.
- Existing image-style derivatives are built from the (now smaller) source going forward; already
  generated derivatives may need flushing.
