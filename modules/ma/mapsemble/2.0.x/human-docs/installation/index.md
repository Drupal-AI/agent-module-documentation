# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The [**Geofield**](https://www.drupal.org/project/geofield) module (`geofield`),
  which stores the coordinates Mapsemble maps. Composer installs it automatically
  as a dependency when you require Mapsemble.
- A **Mapsemble** connection — the interactive map building happens on the
  Mapsemble side, so you will follow the guided setup at **mapsemble.com/drupal**
  after enabling the module.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mapsemble -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Geofield and any
other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mapsemble -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mapsemble -y
```

Drupal enables Geofield at the same time because Mapsemble depends on it.

## Verify it worked

At **Extend** (`/admin/modules`) confirm that **Mapsemble** and **Geofield** are
both checked. Next, add a Geofield location field to the content you want to map
(if it does not have one yet), then head to **mapsemble.com/drupal** to connect
your site and build your first map.
