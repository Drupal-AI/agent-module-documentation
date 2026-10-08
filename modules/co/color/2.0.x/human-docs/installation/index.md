# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: >=9.4 || ^10 || ^11`).
- The **PHP GD library with PNG support**. Color uses GD to render recolored
  images and logos for themes that ship a base image. Drupal's status report
  (**Reports → Status report**) flags it if GD or PNG support is missing.
- A **color‑compatible theme**. Color only shows its picker for themes that opt
  in by shipping a `color/color.inc` file. If a theme has no color picker, it is
  either not compatible or GD is unavailable.

There are no other module dependencies and no third‑party Composer library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/color -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/color -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en color -y
```

There are no submodules. Once enabled, open a compatible theme's settings page to
start recoloring — see [Configuration](../configuration/index.md).
