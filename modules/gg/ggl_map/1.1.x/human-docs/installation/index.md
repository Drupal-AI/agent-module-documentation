# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **YAML Editor** module (`yaml_editor`), which Composer installs for you with
  the `-W` flag below.
- A **Google Maps API key** — the one thing you must supply yourself before maps
  will render. See [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/ggl_map -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install YAML Editor and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ggl_map -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ggl_map -y
```

To follow along with the built‑in demo, also enable the examples module:

```bash
drush en ggl_map_examples -y
```

Then visit `/ggl_map_examples/single_map` to see a working map.

## Verify it worked

After adding your API key (see [Configuration](../configuration/index.md)), the
examples demo at `/ggl_map_examples/single_map` should render a Google Map with
markers. If the map area is blank, the API key is usually the cause — check it and
its referrer restrictions.
