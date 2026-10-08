# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third‑party Composer or PHP library requirements, and no other module
  dependencies. It uses core's Block layout to place the block.

## Install with Composer

From the project root:

```bash
composer require drupal/futurama -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/futurama -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en futurama -y
```

## Verify it worked

Go to **Structure → Block layout**, click **Place block** on any region, and
confirm **Futurama quote of the day** appears in the block list. Place it, save,
and reload a front‑end page — a random Futurama caption should be displayed, with
a different one on each reload.
