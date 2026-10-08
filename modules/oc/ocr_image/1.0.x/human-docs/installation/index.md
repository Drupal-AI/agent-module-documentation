# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Tesseract OCR** installed on the server that runs Drupal, and PHP permitted to
  execute it. On Ubuntu/Debian, for example:

  ```bash
  sudo apt-get install tesseract-ocr
  ```

  Install the language data packages for any languages you need to recognise.
- The PHP libraries used for document parsing are installed **automatically** by
  Composer with the module: Tesseract OCR for PHP, PHP DocumentParser, a PDF
  parser, PhpSpreadsheet, and PHP Presentation.
- **Views Bulk Operations** (`drupal/views_bulk_operations`) — only needed if you
  want to backfill OCR text on existing files in bulk.

## Install Tesseract in DDEV

If you develop in DDEV, Tesseract must be present **inside the web container**. Add
it with a webimage build step so it survives rebuilds — create
`.ddev/web-build/Dockerfile.tesseract` containing:

```dockerfile
RUN apt-get update && apt-get install -y tesseract-ocr && rm -rf /var/lib/apt/lists/*
```

Then `ddev restart`. Confirm it's available with `ddev exec which tesseract`.

## Install the module with Composer

From the project root:

```bash
composer require drupal/ocr_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the OCR/parsing
libraries and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ocr_image -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ocr_image -y
```

## Verify it worked

Confirm Tesseract is reachable from PHP (for example `ddev exec tesseract
--version`), then follow [Configuration](../configuration/index.md) to switch a
field to the OCR widget. The real test is functional: upload an image with legible
text and confirm the extracted text lands in the mapped title/alt/description or
text field.
