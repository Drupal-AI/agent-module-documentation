# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** (`field`) and **Views** (`views`) modules. Both ship with
  Drupal core; Views is enabled on most sites, and Drupal will pull in whatever is
  missing as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_views_search -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_reference_views_search -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_views_search -y
```

## Verify it worked

Visit **Configuration → Entity Reference Views Search**
(`/admin/config/entity-reference-views-search`) — if the settings form loads, the
module is installed. From there, continue to [Configuration](../configuration/index.md)
to set the allowed field types and attach the widget to a field.
