# Installation

## Requirements

- **PHP 8.3 or newer** — a hard requirement for this release.
- **Drupal 10.3 or newer recommended** (`core_version_requirement: ^10.3 || ^11`).
- Core's **File** module (`file`) — enabled on standard installs.
- A server‑side PDF rasteriser — typically **Ghostscript** and **ImageMagick**
  (via PHP) — to convert PDF pages into images.

> **Handling uploaded files safely:** rasterising untrusted PDFs is a known risk
> area (ImageMagick/Ghostscript "delegate" vulnerabilities). Keep that tooling
> patched and restrict who may upload PDFs.

## Install with Composer

From the project root:

```bash
composer require drupal/pdf_to_imagefield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pdf_to_imagefield -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix. DDEV's web
> container includes Ghostscript/ImageMagick; confirm the PHP version meets the
> 8.3 minimum with `ddev exec php -v`.

## Enable the module

```bash
drush en pdf_to_imagefield -y
```

## Verify it worked

1. Confirm PHP is 8.3+ and that Ghostscript/ImageMagick are available on the host.
2. On a content type, set up the fields as described in the
   [overview](../index.md#how-to-use-it): add an image field, add a file field with
   the **PDF to Image** widget, and link the two.
3. Create a piece of content and upload a PDF. After saving (and, for large files,
   once the batch completes), the linked image field should contain the generated
   page image(s). If it stays empty, check the PHP version and the
   Ghostscript/ImageMagick installation.

> **Tip:** the module provides **Drush commands** for running conversions from the
> command line — useful for regenerating images across existing content in bulk.
