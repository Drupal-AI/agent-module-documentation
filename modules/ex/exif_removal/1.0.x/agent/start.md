<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EXIF Removal (exif_removal) — agent index

Strips embedded EXIF metadata (GPS, camera make/model, timestamps) from uploaded **JPEG** images.
Zero-configuration: runs automatically on every file-entity insert.

- **Version dir:** 1.0.x (installed 1.0.0, stable). Core `^10.3 || ^11`. License GPL-2.0-or-later. Package: Media.
- **Composer:** `drupal/exif_removal`. Requires only `drupal/core`; no contrib module dependencies.
- **Optional integration:** if `image_effects` is enabled AND the active image toolkit is `imagemagick`,
  metadata is stripped via ImageMagick's `strip`; otherwise GD is used. `image_effects` is a soft/runtime
  check only — not declared as a dependency or a `suggests`.
- **PHP runtime:** relies on the PHP `exif` extension (`exif_read_data`) and GD (`imagecreatefromjpeg`,
  `imagejpeg`); silently no-ops if `exif_read_data()` is unavailable.

## What it provides

- **Service** `exif_removal.removal` → `Drupal\exif_removal\ExifRemoval` (`src/ExifRemoval.php`).
  Injects `file_system`, `stream_wrapper_manager`, `image.factory`, `module_handler`, `logger.factory`.
- **Hook** `hook_file_insert()` in `exif_removal.module` → calls `ExifRemoval::exifRemoval($file)`.
- **Logger channel** `exif_removal` (errors only).
- **No** routes, permissions, config objects/schema, plugins, entities, forms, or Drush commands.

## How stripping works

Only `image/jpeg` MIME is processed. See `agent/api/exif-removal-service.md` for the full path/toolkit logic,
the GD re-encode (quality 80), the ImageMagick branch, and the operate/extend notes.

## Solution docs

- [agent/api/exif-removal-service.md](api/exif-removal-service.md) — the service, the hook, processing
  flow, toolkit selection, edge cases, and how to invoke it from custom code.
