# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **Block** (`block`) and **System** (`system`) modules — Block is the one
  you actually need to enable if it is not already on; System is always present.
- No third‑party Composer or PHP library requirements.

## Install with Composer

The Composer package name differs from the module's machine name. The package is
**`drupal/sdb`** (the drupal.org project short name is `sdb`), while the module you
enable is `simple_date_block`:

```bash
composer require drupal/sdb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sdb -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its machine name (not the package name):

```bash
drush en simple_date_block -y
```

If core's Block module is not already enabled, Drupal enables it automatically as a
dependency.

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block** in any region. The **Simple Date Block** should be available to place. Once
placed and configured with a format and timezone, the date/time appears in that
region on the front end.
