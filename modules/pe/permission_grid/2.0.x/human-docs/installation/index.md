# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- To get value from it you will want at least one of the supported permission
  providers in play — **Node**, **Taxonomy**, or **Media** (all core).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/permission_grid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/permission_grid -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en permission_grid -y
```

## Verify it worked

Log in as an administrator and open the permission grid for one of the supported
entity types (Node, Taxonomy or Media). You should see permissions laid out as a
grid of verbs across the top and objects down the side, rather than the flat
core list. Keep access to these pages restricted to trusted administrators, since
they lay bare your site's access model.
