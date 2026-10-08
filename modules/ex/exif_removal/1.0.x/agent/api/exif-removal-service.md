<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# exif_removal.removal service & file-insert hook

Source: `src/ExifRemoval.php`, `exif_removal.module`, `exif_removal.services.yml`.

## Install / enable

`composer require drupal/exif_removal` then enable (`drush en exif_removal`). No configuration follows —
there is no settings form, route, or permission. It begins stripping EXIF on the next JPEG upload.

## Wiring

`exif_removal.module` implements `hook_file_insert(EntityInterface $entity)` and simply calls:

```
\Drupal::service('exif_removal.removal')->exifRemoval($entity);
```

The hook fires on **insert of any file entity** (all upload paths — node/media image fields, user
pictures, media library, programmatic `File::create()->save()`). It does **not** fire on file update.

`exif_removal.services.yml` registers `exif_removal.removal` → `Drupal\exif_removal\ExifRemoval` with
constructor args: `@file_system`, `@stream_wrapper_manager`, `@image.factory`, `@module_handler`,
`@logger.factory` (the factory yields the `exif_removal` logger channel).

## `ExifRemoval::exifRemoval(FileInterface $file): bool`

Processing flow (guards return early):

1. If `exif_read_data()` does not exist (PHP `exif` extension absent) → return `FALSE`.
2. If `$file->getMimeType()` is not `image/jpeg` → return `FALSE`. (Only JPEG is handled; PNG/GIF/WebP
   pass through untouched.)
3. Resolve a filesystem path from `$file->getFileUri()`:
   - No stream scheme → `fileSystem->realpath($uri)`.
   - Has scheme → `streamWrapperManager->getViaUri($uri)->realpath()`, falling back to the wrapper's
     `getExternalUrl()` when realpath is empty.
   - If path is falsy or `!file_exists($path)` → return `FALSE`.
4. `@exif_read_data($path)`; if the result is not an array (no EXIF) → return `TRUE` (nothing to do).
5. Strip metadata:
   - **ImageMagick branch:** if `moduleHandler->moduleExists('image_effects')` AND
     `imageFactory->get($uri)->getToolkit()->getPluginId() == 'imagemagick'`, apply the toolkit's
     `strip` operation (`$toolkit->apply('strip')`) then `$image->save()`.
   - **GD branch (default):** `@imagecreatefromjpeg($path)`; on failure return `FALSE`. Otherwise
     re-encode in place with `imagejpeg($resource, $path, 80)` and `imagedestroy()`. Quality 80 is a
     deliberate size/quality trade-off. This re-encode is what discards all EXIF.
6. Any thrown `\Exception` is caught and logged via the `exif_removal` channel
   (`'Error removing EXIF data: @message for file @uri'`); returns `FALSE`.

Return value is advisory (the hook ignores it): `TRUE` when stripped or nothing to strip, `FALSE` on
skip/failure.

## Behavioural notes for agents

- **JPEG-only, lossy:** the GD path re-encodes at quality 80, so processed JPEGs are recompressed. Only
  original files are touched; image-style derivatives are generated afterward from the cleaned original.
- **Orientation:** the class docblock states intent to preserve orientation; in practice a full GD
  re-encode drops all EXIF including the Orientation tag, so rely on baked-in pixel orientation.
- **ImageMagick path** requires both `image_effects` enabled and ImageMagick selected at
  `admin/config/media/image-toolkit`; otherwise GD is always used.
- **No-op conditions:** missing PHP `exif` extension, non-JPEG MIME, unresolvable/absent path, or a file
  with no EXIF data.

## Calling it directly

From custom code you can strip EXIF from a JPEG file entity on demand:

```
\Drupal::service('exif_removal.removal')->exifRemoval($file);
```

or inject `exif_removal.removal` and call `->exifRemoval($file)`. `$file` must be a
`\Drupal\file\FileInterface` whose stored URI points to a readable JPEG.
