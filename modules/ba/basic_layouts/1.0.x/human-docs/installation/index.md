# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Layout Discovery** module (`layout_discovery`), which Drupal enables
  automatically as a dependency. To actually place the layouts on pages you will
  normally also use core's **Layout Builder**.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/basic_layouts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/basic_layouts -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en basic_layouts -y
```

That is all — the new layouts are immediately available in the layout picker.
See [Configuration](../configuration/index.md) for where they appear.
