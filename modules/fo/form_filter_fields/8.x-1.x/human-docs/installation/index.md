# Installation

## Requirements

- **Drupal 8.7.7, 9, or 10** (`core_version_requirement: ^8.7.7 || ^9 || ^10`).
- The core **Views** module, which you will use to build the filtering View.
  Views ships with Drupal core and is enabled on most sites.

There are no third‑party Composer or PHP library requirements. Note that this
module does **not** have security‑advisory coverage, so review it before using
it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/form_filter_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/form_filter_fields -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en form_filter_fields -y
```

## Verify it worked

Log in as an administrator and go to
`/admin/config/content/form_filter_fields`. If you see the Form Filter Fields
admin form where you can add a dependency, the module is installed and ready.
The next step is to build your filtering View and register the dependency —
see [Configuration](../configuration/index.md).
