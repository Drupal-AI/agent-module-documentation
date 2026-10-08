# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement: ^8.7.7 || ^9 ||
  ^10 || ^11`).
- No module dependencies, and no PHP library or Composer requirements. It works
  with core's options/select field widgets.

## Install with Composer

From the project root:

```bash
composer require drupal/betternone -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/betternone -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en betternone -y
```

There is no configuration page and no permission to grant. Once enabled, an
extra empty-label setting appears in the widget settings of options/select
widgets under **Manage form display** — see the [main guide](../index.md) for
how to set it.
