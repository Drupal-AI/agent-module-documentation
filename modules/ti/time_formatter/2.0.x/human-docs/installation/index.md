# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No module dependencies. It works with core's Field UI on any `integer`,
  `decimal`, or `float` field.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/time_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/time_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en time_formatter -y
```

There is no configuration form. Once enabled, the **"Time"** format appears as an
option for numeric fields on any bundle's *Manage display* page — see the
[overview](../index.md#how-to-use-it) for applying and tuning it.
