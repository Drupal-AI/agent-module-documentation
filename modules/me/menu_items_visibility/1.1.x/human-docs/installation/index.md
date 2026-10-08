# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`), including Drupal 10 and
  11.
- Core's **Menu UI** module (`menu_ui`) — this is the only dependency, and Drupal
  enables it automatically when you turn on Menu Item Visibility.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_items_visibility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_items_visibility -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_items_visibility -y
```

Once enabled, a **Visibility settings** section appears on every custom menu link's
add/edit form. See [Configuration](../configuration/index.md) for how to use it.
