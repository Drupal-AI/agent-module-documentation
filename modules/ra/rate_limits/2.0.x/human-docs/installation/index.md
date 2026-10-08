# Installation

## Requirements

Rate Limits leans entirely on Drupal core:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Flood** service (part of core, always available) does the counting.
- No other module dependencies, and no third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/rate_limits -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/rate_limits -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rate_limits -y
```

Enabling the module does **not** start limiting anything on its own. No limits
apply until you both tag the routes you want to protect and create a Rate Limit
Config entity — see [Configuration](../configuration/index.md).

There are no submodules.
