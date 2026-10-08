# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 8.1** or newer.
- Core's **Datetime** module (`datetime`) enabled — Drupal enables it automatically
  as a dependency. The formatter only applies to fields of type *Date* (`datetime`).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/age_field_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/age_field_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en age_field_formatter -y
```

There is no configuration page. Once enabled, **Age formatter** becomes available as
a display format for any datetime field — see
[How to use it](../index.md#how-to-use-it).
