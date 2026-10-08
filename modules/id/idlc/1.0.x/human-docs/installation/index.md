# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Config Filter** module (`drupal/config_filter`, `^2.0`) — this module is a
  Config Filter plugin, so it is required and Composer pulls it in automatically.
  The module's behavior is undefined without it.

There are no other third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/idlc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it will bring in Config Filter.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/idlc -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en idlc -y
```

Drupal enables Config Filter automatically as a dependency. That's the entire setup
— there is nothing to configure. Your next `drush cex` / `drush cim` will already
ignore the configuration of any languages that aren't installed on this site.
