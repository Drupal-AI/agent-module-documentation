# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).
- Core's **Menu Link Content** module (`menu_link_content`) — this is the only
  dependency, and Drupal enables it automatically when you turn on Menu Entity
  Index. (The index tracks `menu_link_content` links.)

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_entity_index -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_entity_index -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_entity_index -y
```

Out of the box the module tracks nothing — you must choose the menus and entity
types on the settings form before the index is populated. Continue with
[Configuration](../configuration/index.md).
