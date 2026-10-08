# Installation

## Requirements

Leaflet Layers builds on the contributed Leaflet module:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The contributed **Leaflet** module (`drupal/leaflet` `^2.0 || ^10.0`) — this is a
  hard dependency and Composer will install it for you.

There are no other third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/leaflet_layers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Leaflet package as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/leaflet_layers -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en leaflet_layers -y
```

Drupal will enable the base **Leaflet** module as a dependency automatically. There
are no submodules.

## Verify it worked

Go to **Structure → Leaflet Layers** (`/admin/structure/leaflet_layers`). You should
see the overview with links to the **Map layer** and **Map bundle** collections.
Access is granted to users with the **Administer site configuration** permission
(the overview also needs **Access administration pages**). Next, see
[Configuration](../configuration/index.md) to build your first bundle.
