# Installation

## Requirements

File Metadata PDF needs:

- **Drupal 11.2** (`core_version_requirement: ^11.2`).
- The **File Metadata Manager** module (`file_mdm`).
- The `smalot/pdfparser` PHP library, which Composer installs for you.

> **Install with Composer, not by hand.** The module must be installed via
> Composer so that the `smalot/pdfparser` library is pulled in. Downloading the
> module archive on its own will not give you a working PDF parser.

## Install with Composer

From the project root:

```bash
composer require drupal/file_mdm_pdf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the File Metadata
Manager dependency and the PDF parser library, and update any shared packages as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_mdm_pdf -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_mdm_pdf -y
```

Drupal enables the File Metadata Manager dependency at the same time.

## Verify it worked

Once enabled, File Metadata Manager can extract metadata from PDF files. There is
no settings page to check — if `file_mdm` is on and this module is enabled, the PDF
plugin is registered and PDF metadata (page count, dimensions, title, author, and
so on) becomes available to modules that use File Metadata Manager.
