# Installation

## Requirements

- **Drupal 11 or newer** (`core_version_requirement: >=11`, `drupal/core: >=11`).
- **PHP 8.3 or newer** (`php: >=8.3`).
- **Recurring Dates Field** (`drupal/date_recur`, `^3.9`) — this module provides
  widgets *for* that field type, so it is a hard dependency. Composer pulls it in
  automatically.
- Core's **System** module (always present).

The **Token** module is *suggested* but only used by the module's tests — you do
not need it for normal use.

## Install with Composer

From the project root:

```bash
composer require drupal/date_recur_modular -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including pulling in `drupal/date_recur`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/date_recur_modular -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en date_recur_modular -y
```

Drupal enables the required `date_recur` module at the same time. Once enabled,
the three widgets become available on any `date_recur` field's **Manage form
display** — see [How to use it](../index.md#how-to-use-it) on the overview page.

There are no submodules.
