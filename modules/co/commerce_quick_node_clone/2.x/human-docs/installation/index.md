# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core **Node** (`node`).
- **Commerce** (`commerce`) and Commerce **Product** (`commerce_product`) from the
  [Drupal Commerce](https://www.drupal.org/project/commerce) suite.

The parent [Quick Node Clone](https://www.drupal.org/project/quick_node_clone)
module is pulled in as part of this module's requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_quick_node_clone -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_quick_node_clone -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_quick_node_clone -y
```

## Verify it worked

Open an existing Commerce product. A **Clone** option should now be available for
it. Before using it in earnest, grant the clone permission only to the roles that
should create products, at **People → Permissions**. See the
[overview](../index.md) for usage notes.
