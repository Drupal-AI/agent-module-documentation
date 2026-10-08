# Installation

## Requirements

- **Drupal 9, 10.1, or 11** (`core_version_requirement: ^9 || ^10.1 || ^11`).
- Core's **Field** (`field`) and **Node** (`node`) modules — both ship with
  Drupal and are enabled automatically as dependencies. You will also want
  **Field UI** enabled to add the grid field through the admin interface.
- The **ag-Grid JavaScript library**, which is *not* bundled with the module — you
  download it after enabling the module. See
  [Configuration](../configuration/index.md).

There are no third-party PHP libraries to install via Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/aggrid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/aggrid -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en aggrid -y
```

### Optional: the demo submodule

A submodule called **aggrid_demo** ships a ready-made example so you can see the
field in action quickly:

```bash
drush en aggrid_demo -y
```

## Next step

The ag-Grid library still needs to be downloaded before grids will render, and you
need to define at least one grid structure. Continue to
[Configuration](../configuration/index.md).
