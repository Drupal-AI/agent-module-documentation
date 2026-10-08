# Installation

## Requirements

Time Range needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Datetime** (`datetime`) and **Datetime Range** (`datetime_range`)
  modules, since the widget works on core's Date range field type. Drupal enables
  these as dependencies when you turn the module on.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/time_range -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/time_range -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en time_range -y
```

Enabling it also turns on Datetime and Datetime Range if they are not already
active. There is no settings page — the **Time range** widget simply becomes
available for Date range fields on *Manage form display*. See
[How to use it](../index.md#how-to-use-it) in the overview.
