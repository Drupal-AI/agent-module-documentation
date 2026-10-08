# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Feeds** module (`feeds:feeds`) enabled — the XLS parser plugs into it.

On Drupal 10/11 the spreadsheet-reading library is pulled in through Composer, so
there is no manual library download to do. (The old manual "PHPExcel" install
instructions apply only to the legacy Drupal 7 release.)

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_xls -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including the spreadsheet library — as needed. Composer will bring
in Feeds if it isn't present yet.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_xls -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_xls -y
```

This also enables Feeds if it isn't on yet.

## Verify it worked

Go to **Structure → Feed types** (`/admin/structure/feeds`) and add or edit a Feed
type. The XLS parser should now appear in the **Parser** list, with an option to
choose which sheet to process.
