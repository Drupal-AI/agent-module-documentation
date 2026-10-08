# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`), including 10 and 11.
- The **`phpoffice/phpspreadsheet`** PHP library — this is why you must install
  the module with Composer rather than a downloaded tarball.

## Install with Composer

From the project root:

```bash
composer require drupal/entities_import -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the
PhpSpreadsheet library and update any shared dependencies. **Composer is
required** here — a manual download will not pull in the spreadsheet library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entities_import -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entities_import -y
```

## Verify it worked

Confirm the module is enabled on the **Extend** page (`/admin/modules`), then
visit **Structure → Entities Import** (`/admin/structure/entities-import`) and
confirm the **Add Entities Import Type** button is available. From there, continue
to [Configuration](../configuration/index.md) to define an import type and run
your first import.
