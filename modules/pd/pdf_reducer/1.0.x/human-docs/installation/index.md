# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **Ghostscript** installed and **executable on your server** — this is what
  actually compresses the PDFs. Without it, the module has nothing to run and PDFs
  are left untouched.

There are no other module dependencies. (If you want editor‑uploaded files
compressed too, the core *Editor file* feature must be in use, but PDF Reducer does
not require it.)

## Install with Composer

From the project root:

```bash
composer require drupal/pdf_reducer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pdf_reducer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix. DDEV's web container
> normally includes Ghostscript; confirm with `ddev exec which gs`.

## Enable the module

```bash
drush en pdf_reducer -y
```

That is all — **no configuration is needed**. Every file field immediately gains
automatic PDF compression on upload.

## Verify it worked

1. Confirm Ghostscript is available on the server (for example, `gs --version`
   returns a version number).
2. Upload a reasonably large PDF to any file field on your site.
3. If compression succeeds and produces a smaller file, you'll see a message
   telling you the file was reduced, and the stored file will be the smaller
   version. If the result would have been larger (or compression failed), the
   original is kept unchanged — that is expected, safe behaviour.
