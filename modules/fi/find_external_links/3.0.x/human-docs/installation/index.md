# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- No additional contrib modules or third‑party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/find_external_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/find_external_links -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en find_external_links -y
```

## Grant the permission

The module provides a restricted **administer find external links** permission that
controls both the settings page and the report. Assign it under **People →
Permissions** (`/admin/people/permissions`) to the roles that should be able to
configure and run scans.

## Verify it worked

Log in as a user with the permission and visit **Configuration → System → Find
external links** (`/admin/config/system/find-external-links`). You should see the
settings form where you pick fields to scan. Continue to
[Configuration](../configuration/index.md) to set it up and run your first scan.
