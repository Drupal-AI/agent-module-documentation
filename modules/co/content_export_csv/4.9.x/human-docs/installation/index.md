# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).

There are no module dependencies, no PHP version requirement, and no third-party
Composer libraries. The module works with node content out of the box.

## Install with Composer

From the project root:

```bash
composer require drupal/content_export_csv -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_export_csv -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_export_csv -y
```

Once enabled, grant the **Access content export** permission to the roles that
should be able to run exports (see [Configuration](../configuration/index.md)),
then use the form at **Content → Content export**
(`/admin/content/content-export`).

There are no submodules.

> Note: ignore the broken "Configure" link some tooling shows for this module — it
> references a route that doesn't exist. The real page is the export form at
> `/admin/content/content-export`.
