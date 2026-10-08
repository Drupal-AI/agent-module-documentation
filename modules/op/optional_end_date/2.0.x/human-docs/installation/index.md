# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`). If
  you run Drupal 8, 9, or 10.0–10.2, install the 1.x branch of this module instead.
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
dependencies as needed. To pin the new major explicitly, use
`composer require 'drupal/optional_end_date:^2.0' -W`.

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

## Updating from 1.x

Updating in place is safe on Drupal 10.3+: no config keys, setting names, or plugin
IDs changed in 2.0.x, so your existing "Optional end date" checkboxes and data keep
working. Run `drush updatedb -y` after the Composer update as usual. The only hard
requirement is core — 2.0.x will not install on Drupal 10.2 or earlier.

## A note on the settings location

There is **no admin settings page** for this module. All configuration lives on
each Date range field's **Storage settings** form as a single checkbox, so there is
no separate configuration guide.
