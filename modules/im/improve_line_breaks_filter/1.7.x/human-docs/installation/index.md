# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Filter** module (`filter`) enabled — it is part of a standard Drupal
  install, and Drupal enables it automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/improve_line_breaks_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/improve_line_breaks_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en improve_line_breaks_filter -y
```

There are no submodules. Enabling the module only makes the filter *available* — it
does nothing until you switch it on for a text format. See
[the overview](../index.md#how-to-use-it) for how to enable and configure it on a
format.
