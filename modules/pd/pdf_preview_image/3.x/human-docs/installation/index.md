# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** module (`image`) — enabled on standard installs; Drupal enables
  it as a dependency if needed.
- The **`spatie/pdf-to-image`** PHP library (the "Convert a pdf to an image"
  package), installed via Composer.
- **ImageMagick (Imagick PHP extension)** and **Ghostscript** installed on the
  server. These do the actual PDF‑to‑image rendering, so the module cannot generate
  previews without them.

> **Handling uploaded files safely:** the toolkit rasterises PDFs that users
> upload, and PDF/image parsers have had vulnerabilities in the past. Keep
> ImageMagick and Ghostscript current, and make sure preview generation for very
> large or malformed PDFs is bounded on your host.

## Install with Composer

From the project root, require the module. Because the module depends on the
`spatie/pdf-to-image` library, install that too:

```bash
composer require drupal/pdf_preview_image -W
composer require spatie/pdf-to-image
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pdf_preview_image -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix. DDEV's web
> container ships with ImageMagick/Ghostscript, but confirm the Imagick PHP
> extension is available.

## Enable the module

```bash
drush en pdf_preview_image -y
```

## Verify it worked

1. Confirm the toolkit is present — for example, ImageMagick's `convert` and
   Ghostscript's `gs` should be available on the host, and the Imagick PHP
   extension should be loaded.
2. On a content type, follow the steps in the [overview](../index.md#how-to-use-it):
   add an image field, add a PDF‑accepting File field, tick **Pdf preview
   autogeneration**, and point it at the image field.
3. Create a piece of content and upload a PDF. After saving, the image field should
   contain a preview image of the PDF's first page. If it stays empty, check that
   ImageMagick/Ghostscript and the `spatie/pdf-to-image` library are correctly
   installed.
