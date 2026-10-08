# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`). The module exists to
  address the jQuery 4 that ships with Drupal 11, so it is not intended for earlier
  cores.
- No module dependencies and no third-party Composer libraries.
- At display time it loads jQuery 3.6.4 from `code.jquery.com`, so browsers need
  access to that CDN on the pages you downgrade.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_downgrade -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/jquery_downgrade -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_downgrade -y
```

Enabling the module has no effect until you tell it which pages to downgrade — by
default nothing is targeted. Head to
[Configuration](../configuration/index.md) to choose the nodes, Views pages, or themes
that should use jQuery 3.
