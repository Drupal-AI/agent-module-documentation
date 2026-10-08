# Installation

## Requirements

- **Drupal 9.5, 10, 11, or 12** (`core_version_requirement:
  ^9.5 || ^10 || ^11 || ^12`).
- No modules outside Drupal core.

There are no third‑party Composer or PHP library requirements. In most cases this
module is installed automatically because another Convivial module requires it.

## Install with Composer

From the project root:

```bash
composer require drupal/convivial_core -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/convivial_core -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en convivial_core -y
```

## Verify it worked

Go to **Configuration → Convivial** (`/admin/config/convivial`). The Convivial
configuration page should be available, confirming the module is active. On its own
Convivial Core adds no visible front‑end feature — its purpose is to support the
other Convivial modules.
