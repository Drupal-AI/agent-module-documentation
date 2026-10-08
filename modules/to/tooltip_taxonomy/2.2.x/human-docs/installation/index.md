# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core's **Filter** (`filter`) and **Field** (`field`) modules, both of
  which are part of a standard Drupal install and enabled automatically as
  dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tooltip_taxonomy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tooltip_taxonomy -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tooltip_taxonomy -y
```

Nothing changes on your site until you create at least one filter condition and
allow the tooltip markup in your text format — see
[Configuration](../configuration/index.md).
