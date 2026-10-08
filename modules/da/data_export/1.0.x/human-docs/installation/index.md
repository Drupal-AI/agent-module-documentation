# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **No other Drupal module dependencies.**
- **PHP libraries per export format** (install only the ones you plan to use):
  - **CSV** — nothing extra; works out of the box.
  - **XLSX** — [PhpSpreadsheet](https://github.com/PHPOffice/PhpSpreadsheet)
    (`phpoffice/phpspreadsheet`).
  - **DOCX** — [PhpWord](https://github.com/PHPOffice/PHPWord)
    (`phpoffice/phpword`).
  - **PDF** — [TCPDF](https://github.com/tecnickcom/TCPDF) (`tecnickcom/tcpdf`).

## Install with Composer

From the project root:

```bash
composer require drupal/data_export -W
```

Then add whichever export‑format libraries you need:

```bash
composer require phpoffice/phpspreadsheet    # XLSX
composer require phpoffice/phpword           # DOCX
composer require tecnickcom/tcpdf            # PDF
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/data_export -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en data_export -y
```

## Set permissions

Go to **People → Permissions** and grant the export permissions only to the roles
you trust to pull raw data out of the site. Set it before anyone uses the export
forms.

## Verify it worked

Log in as an administrator and open **Export Data → Export Using Table Name**.
Enter a small, harmless table name, pick **CSV**, and export — if a file
downloads, the base install works. If you also installed the XLSX/DOCX/PDF
libraries, repeat the test in each of those formats to confirm the library is
found.
