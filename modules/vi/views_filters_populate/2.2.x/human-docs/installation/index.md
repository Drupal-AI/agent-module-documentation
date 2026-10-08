# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module enabled (it ships with Drupal core and is on for most
  sites).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_filters_populate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_filters_populate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_filters_populate -y
```

There are no submodules and nothing to configure at the site level. The new filter
becomes available immediately inside the Views UI.

## Verify it worked

Edit any View, open **Filter criteria → Add**, and search the list — you should see
**Views Filters Populate** available to add. See the
[overview](../index.md#how-to-use-it) for how to wire it to your target filters.
