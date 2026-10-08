# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), which is part of standard Drupal and enabled
  by default.
- **Optional:** the [Select2](https://www.drupal.org/project/select2) module, only
  if you want each dropdown row to be a searchable Select2 control. Without it, the
  widget simply uses plain HTML selects.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/multiple_selects -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/multiple_selects -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multiple_selects -y
```

There is no configuration page and no permissions to grant. To start using it,
switch a multi-value option field to the **Multiple select list(s)** widget on its
*Manage form display* tab — see the [main guide](../index.md#how-to-use-it).
