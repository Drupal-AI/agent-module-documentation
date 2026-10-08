# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Options** module (`options`) — Drupal enables it as a dependency.
- **[Better Exposed Filters](https://www.drupal.org/project/better_exposed_filters)
  6.x or 7.x** (`drupal/better_exposed_filters:^6.0 || ^7.0`). This is required
  even if you only intend to use the field widget, because it is a hard dependency;
  Composer installs it for you.

## Install with Composer

From the project root:

```bash
composer require drupal/pcr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pcr -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pcr -y
```

Drupal enables `options` and `better_exposed_filters` as dependencies. There is no
settings form — continue to [Configuration](../configuration/index.md) to apply the
pretty widgets to a field or an exposed filter.
