# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **PHP 8.1 or newer** (`php: ^8.1`).
- The **`phpoffice/phpspreadsheet` ^3** library, which does the spreadsheet parsing.
  It is a Composer dependency and is installed automatically when you require the
  module — keep it up to date, as spreadsheet parsers have a history of security
  advisories.

## Install with Composer

From the project root:

```bash
composer require drupal/excel_importer -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it lets Composer install
the `phpoffice/phpspreadsheet` library and any shared dependencies at the same time.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/excel_importer -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en excel_importer -y
```

## Verify it worked

Log in as an administrator and open **Configuration → Content authoring → Excel
Importer** (`/admin/config/content/excel_importer`). If the settings form loads and
lists your content types, the module and the PhpSpreadsheet library installed
correctly. Continue to [Configuration](../configuration/index.md) to choose the allowed
content types and grant permissions.
