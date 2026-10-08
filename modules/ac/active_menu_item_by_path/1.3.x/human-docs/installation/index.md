# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/active_menu_item_by_path -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/active_menu_item_by_path -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en active_menu_item_by_path -y
```

After enabling, grant the **Access active menu settings**
(`access active menu settings`) permission to trusted administrators, then pick
which menus to process on the settings page. See the
[main guide](../index.md#how-to-use-it) for those steps.
