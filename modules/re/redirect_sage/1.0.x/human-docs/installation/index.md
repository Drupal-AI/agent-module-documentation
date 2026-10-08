# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`). Check the
  [project page](https://www.drupal.org/project/redirect_sage) for Drupal 11
  support before installing on an 11 site.
- The **[Redirect](https://www.drupal.org/project/redirect)** module
  (`redirect`) — the only dependency, and the module deliberately does **not**
  require the Migration modules. Composer pulls Redirect in for you.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/redirect_sage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including the Redirect module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/redirect_sage -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redirect_sage -y
```

## Verify it worked

Log in as a user with the **Administer redirects** permission and open the import
form at `/admin/config/search/redirect/sage_import` (and the export form at
`/admin/config/search/redirect/sage_export`). Both screens should load. See the
[overview](../index.md) for the CSV format and how import and export work.
