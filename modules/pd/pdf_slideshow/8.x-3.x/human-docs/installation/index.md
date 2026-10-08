# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **`imagick` PHP extension** installed on the server. This is what converts
  the PDF pages into images; the slideshow cannot render without it.

There are no other module dependencies and no third‑party Composer library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/pdf_slideshow -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pdf_slideshow -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix. Confirm the `imagick`
> extension is loaded with `ddev exec 'php -m | grep imagick'`.

## Enable the module

```bash
drush en pdf_slideshow -y
```

## Verify it worked

1. Confirm the `imagick` PHP extension is available (for example,
   `php -m | grep imagick` lists it).
2. On a content type with a PDF file field, go to **Manage display** and set that
   field's **Format** to **PDF Slideshow** (see the
   [overview](../index.md#how-to-use-it)).
3. Create content with a PDF attached and view it — the pages should render as an
   image slideshow. If nothing appears, check that `imagick` is installed and that
   the file is a valid PDF.
