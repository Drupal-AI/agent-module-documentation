# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The component is designed for use inside the **Canvas** (Experience Builder)
  page builder, so it is only useful on a site where Canvas is set up. The module
  itself declares no hard module dependencies and no third‑party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/canvas_jumbotron -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/canvas_jumbotron -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en canvas_jumbotron -y
```

Once enabled, the Jumbotron component is available in the Canvas page builder.
There is no configuration step.
