<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exif Manipulate (exif_manipulate) — agent index

Strips EXIF metadata from uploaded **JPEG/TIFF** images using the pure-PHP **`fileeye/pel`** library
(no exiftool/ImageMagick, no shell-out), while **preserving the orientation tag**. Package: none
declared. Composer requires `fileeye/pel:^0.10.0`; no Drupal module dependencies (uses core `file`).
Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.1.

- **Service, upload hook, QueueWorker and the mechanism (how EXIF is read/cleared/saved)** →
  [api/processor.md](api/processor.md)
- **The retroactive confirm form, route, permission and the state/queue it drives** →
  [config/clean-images-form.md](config/clean-images-form.md)

## What it provides (from source)

- **Service** `exif_manipulate.file_exif_processor` → `Services\FileExifProcessor`
  (`implements FileExifProcessorInterface`), method `manipulate(FileInterface $file)`.
- **Service** `logger.channel.exif_manipulate` (logger channel).
- **Hook** `exif_manipulate_file_insert()` in `exif_manipulate.module` delegates to
  `Hooks\FileEntity::fileInsert()` (a `ContainerInjectionInterface` class resolved via classResolver).
- **QueueWorker plugin** `exif_manipulate_clean_exif_data` (`Plugin\QueueWorker\CleanExifDataQueueWorker`,
  `cron = {"time" = 60}`) — cleans queued files loaded by URI.
- **Route** `exif_manipulate.clean_images_form` → `/admin/config/media/exif_manipulate`
  (`_form: Form\ExifManipulateForm`, `_permission: administer exif manipulate`); menu link under
  Configuration → Media (`system.admin_config_media`).
- **Permission** `administer exif manipulate` (`restrict access: true`).
- **Install/uninstall**: `hook_uninstall()` deletes the `exif_manipulate_clean_exif_data` queue and the
  `exif_manipulate_clean_exif_data_total` state key. No `config/install`, no `config/schema`,
  no `*.libraries.yml`, no Drush commands, no fields/formatters/entities.

## Mechanism in one line

On file insert (and on queued items), `FileExifProcessor::manipulate()` opens the image by MIME type
(`PelJpeg`/`PelTiff`), reads the current EXIF, captures the ORIENTATION entry, `clearExif()`, re-applies
only the orientation, and `saveFile($uri)` back to the same URI. Non-JPEG/TIFF MIME types are skipped
(the `match` returns NULL). PEL errors are caught and logged; upload shows a warning message.
