# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A working **DKAN** site (`dkan`).
- The **JSON Form Widget** module (`json_form_widget`) — in DKAN 2.x this was a
  DKAN submodule; it is now a standalone module. DKAN Geo Widget depends on it.

The Leaflet and Geoman JavaScript libraries are bundled with the module in its
`dist/` directory, so there is no separate library to install and no external CDN
is required.

## Install with Composer

From the project root:

```bash
composer require drupal/dkan_geo_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dkan_geo_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dkan_geo_widget -y
```

Make sure the **json_form_widget** module is enabled as well (Composer and the
dependency resolver handle this for you on DKAN 4).

## Verify it worked

Edit your dataset UI schema (for example `dataset.ui.json`) and set
`dkan_geo_widget` as the widget for a spatial property, then open the dataset
metadata form as an editor. That property should now render as an interactive
Leaflet map with Geoman drawing controls, and shapes you draw should be saved as
GeoJSON into the field.
