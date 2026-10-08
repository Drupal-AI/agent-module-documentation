# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 ||
  ^11`).

There are no third‑party Composer or PHP library requirements, and no module
dependencies beyond core.

## Install with Composer

From the project root:

```bash
composer require drupal/idealyzer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/idealyzer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en idealyzer -y
```

## Verify it worked

Log in as an administrator and visit **Reports → 21st Century IDEA site status**,
or go directly to `/admin/reports/gov-status`. You should see the compliance
overview with each check and its current status.
