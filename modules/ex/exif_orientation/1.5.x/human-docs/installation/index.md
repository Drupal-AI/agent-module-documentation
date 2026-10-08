# Installation

## Requirements

EXIF Orientation is very lightweight. It needs:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- **PHP's EXIF extension** — the module reads orientation tags with
  `exif_read_data()`, and it simply does nothing if that extension is not loaded.
  Check with `php -m | grep exif`.

There are no other Drupal module dependencies and no third‑party Composer
libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/exif_orientation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/exif_orientation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en exif_orientation -y
```

That is the whole setup. There is no configuration form, no permission to grant,
and no image effect to add. From now on, every JPEG or PNG uploaded to an image
field is rotated to match its EXIF Orientation tag automatically.

## Verify it worked

Upload a photo taken on a phone that you know displays sideways elsewhere (or one
with a known Orientation tag of 3, 6, or 8) to any image field. After the upload
completes, the stored image — and any thumbnails generated from it — should appear
upright.
