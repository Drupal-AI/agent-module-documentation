# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core modules **Field**, **File**, **Filter**, and **Image** — all part of Drupal
  core; Drupal enables them as dependencies.
- The bundled **Handsontable** JavaScript library, which the module provides as its
  own asset library (`blizz_table_field/handsontable`) — no separate download is
  required.

## Install with Composer

From the project root:

```bash
composer require drupal/blizz_table_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/blizz_table_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en blizz_table_field -y
```

Once enabled, add a Blizz Table field to a content type and set its widget and
display — continue to [Configuration](../configuration/index.md).
