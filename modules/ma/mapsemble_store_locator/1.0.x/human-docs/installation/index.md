# Installation

> **Before you install:** this module is marked *Unsupported / Obsolete* on
> drupal.org and no longer receives updates. It still enables on Drupal 10 and 11,
> but consider building a locator directly with the actively maintained
> [Mapsemble](../../../mapsemble/2.0.x/human-docs/index.md) module for new sites.

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- [**Mapsemble**](../../../mapsemble/2.0.x/human-docs/index.md) (`mapsemble`) — the
  underlying map engine.
- [**Geofield Map**](https://www.drupal.org/project/geofield_map) (`geofield_map`)
  — for entering and displaying store coordinates.

Composer pulls both dependencies in automatically when you require this module.

## Install with Composer

From the project root:

```bash
composer require drupal/mapsemble_store_locator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Mapsemble,
Geofield Map, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mapsemble_store_locator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mapsemble_store_locator -y
```

Drupal enables Mapsemble and Geofield Map at the same time because this module
depends on them.

## Verify it worked

At **Extend** (`/admin/modules`) confirm that **Mapsemble Store Locator**,
**Mapsemble**, and **Geofield Map** are all checked. Then visit
**`/mapsemble-store-locator`** and follow the on‑screen instructions to finish
setting up the locator, and add your stores as **Store** content.
