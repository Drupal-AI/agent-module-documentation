# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Geofield** module (`drupal/geofield`, `8.*`) — this is the field type
  that stores the coordinates the map plots. Composer pulls it in as a
  dependency.
- A **Google Maps JavaScript API key** (or a Maps‑for‑Work Client ID). This is
  not a Composer dependency but the map will not render without it — see
  [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/styled_google_map -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Geofield.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/styled_google_map -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en styled_google_map -y
```

## Optional submodules — demos

Two optional submodules exist purely to demonstrate the module. You do **not**
need them on a production site.

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Styled Google Map Demo** | `styled_google_map_demo` | A Real Estate demo entity type showing pins, popups, and taxonomy‑icon maps. |
| **Styled Google Map Data** | `styled_google_map_data` | Ready‑made example content and views — enable it to explore working maps at paths like `/heatmap` and `/cluster-map`. |

Enable them only for exploration:

```bash
drush en styled_google_map_data -y
```

## Next step

Before any map will render, set your Google Maps API key — see
[Configuration](../configuration/index.md).
