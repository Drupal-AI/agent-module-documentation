# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The [Media Thumbnails](https://www.drupal.org/project/media_thumbnails) module
  (`media_thumbnails`) — the framework this plugin registers with. Composer pulls it
  in with the command below.
- The **ImageMagick PHP extension** (Imagick). The module's `hook_requirements()`
  reports an error at install/runtime if the extension is missing.
- The **ImageMagick** and **Ghostscript** binaries on the host, for TIFF (and
  underlying PDF) support.

## Install with Composer

From the project root:

```bash
composer require drupal/media_thumbnails_tiff -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including Media Thumbnails — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_thumbnails_tiff -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_thumbnails_tiff -y
```

Drupal will enable **Media Thumbnails** at the same time if it is not already on.

## Verify it worked

Upload a TIFF file as a media entity and confirm it receives a JPG preview thumbnail
instead of the generic media icon. If no thumbnail appears, check the site's status
report for the **Imagick extension** requirement and confirm the **ImageMagick** and
**Ghostscript** binaries are installed on the host.
