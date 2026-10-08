# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Node** module (`node`) — enabled automatically as a dependency.
- The **mPDF library** (`mpdf/mpdf ^8.0`). This is a PHP library, not a Drupal
  module, and it must be present for PDF generation to work — which is why you should
  install Entity PDF **with Composer** (below), so the library is pulled in
  automatically.

There are no other third-party requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_pdf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the mPDF library and
update any shared dependencies as needed. Installing via Composer is the supported
path precisely because it brings in `mpdf/mpdf` for you — don't just drop the module
in manually, or PDF generation will fail for lack of the library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_pdf -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_pdf -y
```

## Right after enabling

1. **Set permissions carefully.** Grant **Administer entity PDF settings** (a
   restricted permission) to administrators. Then decide who may generate PDFs — see
   [Permissions](../configuration/index.md#permissions).
2. **Check the temp directory.** mPDF needs a writable temp/font-cache directory. The
   default is `sites/default/files/entity_pdf` (relative to the Drupal root); make
   sure it exists and is writable, or adjust it on the settings form.

Then head to [Configuration](../configuration/index.md) to set the filename pattern,
choose inline-vs-download, and (optionally) point at a custom PDF template.

This module has no submodules.
