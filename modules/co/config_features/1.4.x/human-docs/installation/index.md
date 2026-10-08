# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- No other modules are required, and there are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_features -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_features -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_features -y
```

## Set the permission

Config Features provides its own permission for defining and exporting features.
Grant it only to trusted site builders at **People → Permissions**
(`/admin/people/permissions`), since features move configuration between sites.

## Verify it worked

With the module enabled and the permission granted, confirm you can reach its
feature-management screens and define a feature. Then export it and import it on a
second site to confirm the UUID reconciliation updates the matching config rather
than duplicating it.
