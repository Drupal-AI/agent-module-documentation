# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **ImageMagick PHP extension** installed and enabled on the server — the module
  uses it to render the preview image.
- The **PhpSpreadsheet** and **mPDF** PHP libraries, used to convert the spreadsheet
  to a PDF. These are declared as Composer dependencies and are pulled in when you
  require the module.
- Core's **Media** module and the
  [Media Thumbnails](https://www.drupal.org/project/media_thumbnails) framework, so
  the generated thumbnails have somewhere to live.

Supported file types: **`.xls`** and **`.xlsx`**.

## Install with Composer

From the project root:

```bash
composer require drupal/media_thumbnails_excel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including PhpSpreadsheet and mPDF — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_thumbnails_excel -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_thumbnails_excel -y
```

## Verify it worked

Upload an `.xls` or `.xlsx` file as a media entity and check that it receives a
preview image generated from the first sheet rather than a generic icon. If
thumbnails do not appear, confirm the **ImageMagick PHP extension** is installed and
that the PhpSpreadsheet/mPDF libraries were installed by Composer.
