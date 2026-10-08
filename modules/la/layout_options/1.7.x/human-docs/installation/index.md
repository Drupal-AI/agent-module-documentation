# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Layout Discovery** module (`layout_discovery`), enabled automatically as
  a dependency. You will typically also use **Layout Builder** (core) to place the
  layouts.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_options -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_options -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_options -y
```

## Submodule — layout_options_ui (recommended)

By itself, a layout only shows options if it uses the module's LayoutOptions plugin
class. To retrofit **existing** core or contrib layouts (one column, two column,
etc.) without redefining them, enable the **layout_options_ui** submodule
(`layout_options_ui`), which provides an admin form that swaps those layouts over to
the LayoutOptions plugin:

```bash
drush en layout_options_ui -y
```

## Next steps

Enabling the module does nothing visible until you define an options file and make
your layouts use the plugin. See [Configuration](../configuration/index.md).
