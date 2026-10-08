# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** module (`image`).
- The **ImageMagick** module (`imagemagick`, version `>= 8.x-3.7`) and the
  ImageMagick binaries installed on the server. Composer installs the module; the
  binaries are a server prerequisite. ImageMagick does **not** need to be your
  site's default image toolkit.

## Install with Composer

From the project root:

```bash
composer require drupal/pdfpreview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed, and it brings in the ImageMagick module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pdfpreview -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pdfpreview imagemagick -y
```

## Allow ImageMagick to read PDFs (important)

Recent versions of ImageMagick ship with a policy that **blocks reading PDF files**
by default, which stops previews from generating. You need to give ImageMagick
"read" permission for the PDF pattern in its `policy.xml` (the path varies by
system — for example `/etc/ImageMagick-7/policy.xml` or `/etc/ImageMagick-6/`).
Find the line that denies the `PDF` coder and change it to allow **read**, for
example:

```xml
<policy domain="coder" rights="read" pattern="PDF" />
```

After editing the policy, no Drupal cache clear is required for ImageMagick itself,
but re‑test preview generation. Consult the ImageMagick and module project pages
for the exact policy syntax on your platform.

## Verify it worked

1. Confirm ImageMagick is installed and can read PDFs (with the policy change
   above).
2. On a content type with a PDF file field, go to **Manage display** and set that
   field's **Format** to **PDFPreview** (see the
   [overview](../index.md#how-to-use-it)).
3. View a node with a PDF attached — a thumbnail of the first page should appear. If
   it does not, revisit the ImageMagick PDF policy, which is the usual culprit.
