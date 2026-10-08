# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No module dependencies. It works with core's Node module (the node add/edit
  forms it alters).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/vertical_tabs_config -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/vertical_tabs_config -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en vertical_tabs_config -y
```

Enabling the module creates its database table for visibility rules but changes
nothing on the node form until you configure it. Continue to
[Configuration](../configuration/index.md).
