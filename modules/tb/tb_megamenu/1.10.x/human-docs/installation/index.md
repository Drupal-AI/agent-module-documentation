# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no required contrib modules and no third-party Composer libraries. The
[Chosen](https://www.drupal.org/project/chosen) module is an optional nicety that
improves the look of select dropdowns in the admin builder, but it is not required.

## Install with Composer

From the project root:

```bash
composer require drupal/tb_megamenu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tb_megamenu -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tb_megamenu -y
```

The module has no submodules. Nothing exists until you create your first mega menu —
there is no default configuration installed. After enabling, grant the **Administer
tb_megamenu** permission to the roles that should build menus, then head to
[Configuration](../configuration/index.md) to create one.
