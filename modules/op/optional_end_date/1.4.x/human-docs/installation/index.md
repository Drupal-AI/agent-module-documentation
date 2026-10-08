# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Datetime Range** module (`datetime_range`) enabled — this is the only
  dependency, and it provides the `daterange` field type that this module makes
  optional. Drupal will enable it automatically as a dependency when you turn on
  Optional end date.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/optional_end_date -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/optional_end_date -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en optional_end_date -y
```

Enabling it also runs a one‑time update that alters existing Date range fields'
database columns so the end‑value column may be empty. Enabling the module by
itself does not change any field's behaviour — you still have to tick the
**"Optional end date"** checkbox on each field's Storage settings (see the
[overview](../index.md#how-to-use-it)).

## A note on the settings location

There is **no admin settings page** for this module. All configuration lives on
each Date range field's **Storage settings** form as a single checkbox, so there is
no separate configuration guide.
