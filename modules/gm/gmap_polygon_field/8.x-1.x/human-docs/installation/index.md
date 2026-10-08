# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8.0 || ^9 || ^10`).
- Core's **Field** module (`field`) — enabled by default on a standard Drupal
  install.
- A **Google Maps API key** with the **Maps JavaScript API** and the **Drawing**
  library enabled. The maps are loaded directly from Google's JavaScript API, so
  without a working key no map will render. You add the key after installing (see
  [Configuration](../configuration/index.md)).

There are no other module or third-party library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/gmap_polygon_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gmap_polygon_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gmap_polygon_field -y
```

## Verify it worked

1. Go to **Configuration → Content authoring → GMap Polygon Field**
   (`/admin/config/content/gmap_polygon_field`) and confirm the settings form
   loads.
2. Add your Google Maps API key there (see [Configuration](../configuration/index.md)).
3. Visit the bundled example page at `/examples/gmap_polygon_field` — a Google Map
   with drawing tools should appear, which confirms the key and libraries are
   working.
