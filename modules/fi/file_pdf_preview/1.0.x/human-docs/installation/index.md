# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **File** module (`file`) — enabled automatically as a dependency.
- The PHP **Imagick** extension (`ext-imagick`) installed and enabled on your
  server. This is the engine that renders PDF pages to images; without it the
  module cannot generate previews.
- The **`spatie/pdf-to-image`** PHP library. You do not install this by hand —
  `composer require` pulls it in automatically (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/file_pdf_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed and, importantly here, install the `spatie/pdf-to-image` library the
module relies on.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_pdf_preview -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_pdf_preview -y
```

## Verify it worked

Confirm the Imagick extension is present (for example with `php -m | grep imagick`
inside your web container). Then go to a bundle's **Manage form display**, switch a
file field to the **File PDF Preview** widget, save, and upload a PDF to a piece of
content. If everything is wired up, the first page of the PDF appears as a
generated preview image. If no image is produced, the most common cause is a
missing or disabled Imagick extension on the server.
