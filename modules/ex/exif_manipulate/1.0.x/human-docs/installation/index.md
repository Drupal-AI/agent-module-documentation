# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **`fileeye/pel`** PHP library, which reads and writes EXIF data. When you
  install with Composer (recommended), this is pulled in automatically — you don't
  install it separately.

**Recommended companion:** the
[EXIF orientation](https://www.drupal.org/project/exif_orientation) module, which
rotates uploaded files according to their orientation metadata. Exif Manipulate
deliberately leaves orientation data intact so this pairing works cleanly.

## Install with Composer

From the project root:

```bash
composer require drupal/exif_manipulate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the `fileeye/pel`
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/exif_manipulate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en exif_manipulate -y
```

From this point on, EXIF metadata is stripped from images as they're uploaded —
no further setup is required for new uploads.

## Verify it worked

Upload an image that you know contains EXIF data (a photo straight from a phone,
including GPS location, works well). After the upload completes, download the
stored file and inspect its metadata — the GPS and camera fields should be gone,
while the image itself looks unchanged and correctly oriented. To clean images
that were uploaded *before* you enabled the module, use the conversion form
described in [Configuration](../configuration/index.md).
