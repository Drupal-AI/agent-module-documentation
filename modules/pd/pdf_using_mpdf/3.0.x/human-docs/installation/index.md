# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **File** module (`file`) — a dependency, enabled automatically (needed for
  the "save to a file scheme" output mode and image watermarks).
- The **`mpdf/mpdf` library** (`^8.2`) — the PHP library that actually renders the
  PDFs. Composer installs it for you as a declared requirement.

## Install with Composer

From the project root:

```bash
composer require drupal/pdf_using_mpdf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also pulls in `mpdf/mpdf`, so you don't have to
install the library separately.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/pdf_using_mpdf -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pdf_using_mpdf -y
```

## Next steps

Two things make the feature usable:

1. **Set your defaults** at **Configuration → User interface → mPDF** — filename,
   output mode, page size, header/footer, and so on.
2. **Grant permissions.** The module creates a `generate <type> pdf` permission for
   each content type; grant it (at **People → Permissions**) to the roles that
   should be able to produce PDFs of that type. Grant **Administer mPDF settings**
   only to trusted admins.

The [Configuration](../configuration/index.md) guide covers both. There are no
submodules.
