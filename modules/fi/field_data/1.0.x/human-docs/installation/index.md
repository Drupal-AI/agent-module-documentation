# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- Core's **Field UI** module (`field_ui`) — provides the Field list report this
  module extends.
- Core's **Options** module (`options`).

Both dependencies are part of core and are enabled automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/field_data -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_data -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_data -y
```

This also enables Field UI and Options if they are not already on.

## Verify it worked

Go to **Reports → Field list** (`/admin/reports/fields`). You should now see a
**Data** tab added by the module. See the [overview](../index.md#how-to-use-it) for
viewing and downloading the data.
