# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** (`field`) and **Link** (`link`) modules — both enabled on a
  standard site, and pulled in as dependencies.

No contrib dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/html_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/html_formatter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en html_formatter -y
```

Drupal enables `field` and `link` as dependencies. There is no configuration form —
the formatters become available on any compatible field's **Manage display**
settings, as described on the [overview page](../index.md#how-to-use-it).
