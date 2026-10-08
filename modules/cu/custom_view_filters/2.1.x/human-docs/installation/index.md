# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement: ^8.7.7 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`), which Drupal enables as a dependency.
- No third-party Composer or PHP library requirements.

The filters operate on node-based Views (the `node_field_data` table), so they are
intended for content/node Views.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_view_filters -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_view_filters -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_view_filters -y
```

Once enabled, the three filters become available in the Views UI. Add them to a
View as described in the *How to use it* section on the
[overview page](../index.md). There is nothing else to configure and no submodules.
