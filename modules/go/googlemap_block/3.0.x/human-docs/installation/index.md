# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Google Maps API key** (see [Configuration](../configuration/index.md)).

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/googlemap_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/googlemap_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en googlemap_block -y
```

## Verify it worked

Go to **Structure → Googlemap → Settings**
(`/admin/structure/gmap-location/settings`). If the settings form loads, the module
is installed — next, add your API key and a location as described in
[Configuration](../configuration/index.md).
