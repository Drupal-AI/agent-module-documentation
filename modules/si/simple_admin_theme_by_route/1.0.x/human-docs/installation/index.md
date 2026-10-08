# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No other modules are required, and there are no third-party Composer or PHP
  library requirements.

Note that this project is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_admin_theme_by_route -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_admin_theme_by_route -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_admin_theme_by_route -y
```

Enabling the module changes nothing until you tell it which routes should use the
admin theme — see [Configuration](../configuration/index.md).
