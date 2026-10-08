# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/emergency_alerts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/emergency_alerts -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en emergency_alerts -y
```

## Verify it worked

Log in as an administrator and go to `/admin/config/emergency_alerts`. If the
settings form loads, the module is installed. Set an alert and choose a display
method as described in [Configuration](../configuration/index.md) — nothing
appears on the site until you do.
