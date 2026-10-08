# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The [Media Thumbnails](https://www.drupal.org/project/media_thumbnails) module
  (`media_thumbnails`) — the framework this plugin registers with. Composer pulls it
  in with the command below.
- The **ImageMagick PHP extension** (Imagick), and an ImageMagick build that
  includes **JP2 (JPEG 2000) delegate support** — without the JP2 delegate,
  ImageMagick cannot read the source files and no thumbnail is produced. Consult the
  project page for notes on enabling JP2 support in ImageMagick.

## Install with Composer

From the project root:

```bash
composer require drupal/media_thumbnails_jp2 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including Media Thumbnails — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_thumbnails_jp2 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_thumbnails_jp2 -y
```

Drupal will enable **Media Thumbnails** at the same time if it is not already on.

## Verify it worked

Upload a `.jp2` file as a media entity and confirm it receives a JPEG preview
thumbnail instead of the generic media icon. If no thumbnail appears, check that the
**Imagick PHP extension** is loaded and that your ImageMagick build has **JP2
delegate support**.
