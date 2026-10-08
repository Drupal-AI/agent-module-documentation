# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The [Media Thumbnails](https://www.drupal.org/project/media_thumbnails) module
  (`media_thumbnails`) — the framework this plugin registers with. Composer pulls it
  in with the command below.
- The **ImageMagick PHP extension** (Imagick) — the module logs a warning and stops
  if it is absent.
- The **PhpOffice/PhpWord** and **mPDF** PHP libraries, used to load the document and
  convert it to PDF. These come in as Composer dependencies.

Supported file types: **`.doc`** and **`.docx`**.

## Install with Composer

From the project root:

```bash
composer require drupal/media_thumbnails_word -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including Media Thumbnails, PhpWord, and mPDF — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_thumbnails_word -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_thumbnails_word -y
```

Drupal will enable **Media Thumbnails** at the same time if it is not already on.

## Configure the mPDF path

Before thumbnails will generate, you must tell the module where the mPDF library
lives — see [Configuration](../configuration/index.md).

## Verify it worked

After setting the mPDF path, upload a `.doc` or `.docx` file as a media entity and
confirm it receives a JPG preview generated from the first page. If nothing appears,
check the logs: the module warns when the **Imagick** extension is missing or when
the **mPDF path** has not been set.
