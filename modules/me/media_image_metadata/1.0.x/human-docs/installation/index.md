# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Media** module enabled (Drupal enables it automatically as a
  dependency).
- *(Optional)* **PHP 8.2+ with the EXIF extension** — only needed if you want to
  read **EXIF** metadata specifically. IPTC and XMP reading does not require the
  EXIF extension.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_image_metadata -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_image_metadata -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_image_metadata -y
```

## Verify it worked

Upload an image that you know carries embedded metadata (a caption or a capture
date, for example) and confirm those values become available to populate the
matching fields on your media entity. If you specifically need EXIF values and they
don't appear, check that PHP has the **EXIF extension** enabled.

Before exposing any of this on the front end, revisit the privacy caveat in the
[overview](../index.md) — embedded metadata can include GPS location and personal
data.
