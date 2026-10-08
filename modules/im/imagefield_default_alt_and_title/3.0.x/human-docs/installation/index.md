# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer**.

The module has no other Drupal module dependencies and no third‑party Composer
libraries. It works with core's standard image fields.

## Install with Composer

From the project root:

```bash
composer require drupal/imagefield_default_alt_and_title -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/imagefield_default_alt_and_title -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imagefield_default_alt_and_title -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Search and metadata →
Imagefield Default Alt And Title**
(`/admin/config/search/imagefield-default-alt-and-title`). If the settings form
loads, the module is installed and ready. From there you can choose which content
types it applies to and run the batch backfill — see
[Configuration](../configuration/index.md).
