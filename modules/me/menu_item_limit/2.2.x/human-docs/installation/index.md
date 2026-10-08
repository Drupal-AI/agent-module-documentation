# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Core's **Menu UI** module (`menu_ui`) enabled — this is the only dependency, and
  Drupal enables it automatically when you turn this module on. The limit is
  enforced on menu links you add through the UI.

There are no third‑party Composer or PHP library requirements, and the module adds
no permissions of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_item_limit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_item_limit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_item_limit -y
```

No menu is capped until you set a limit on it — every menu stays unlimited by
default. See [Configuration](../configuration/index.md).

This module has no submodules.
