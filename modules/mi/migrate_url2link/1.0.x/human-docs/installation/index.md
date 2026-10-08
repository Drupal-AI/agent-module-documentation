# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Link** (`link`) and **Migrate** (`migrate`) modules.
- The [Migrate Plus](https://www.drupal.org/project/migrate_plus) contrib module
  (`migrate_plus`).

Composer and Drupal enable the dependencies for you. There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_url2link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed (including Migrate Plus).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/migrate_url2link -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_url2link -y
```

Enable it **before** you run the Drupal 7 → Drupal 8+ migration. There is no settings form
and no submodules; the field plugin is discovered automatically. See
[How to use it](../index.md#how-to-use-it).
