# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No third‑party Composer or PHP library requirements, and no other module
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/announcement_modal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/announcement_modal -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en announcement_modal -y
```

Once enabled, head to [Configuration](../configuration/index.md) to write your
announcement and place the block.
