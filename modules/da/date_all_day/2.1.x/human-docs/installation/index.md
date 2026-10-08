# Installation

## Requirements

Date All Day needs:

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement: ^8.7.7 || ^9 || ^10 | ^11`).
- Core's **Datetime Range** module (`datetime_range`) enabled — this is the only dependency,
  and Drupal enables it automatically when you turn on Date All Day. It is what provides the
  `daterange` field type the module extends.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/date_all_day -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/date_all_day -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en date_all_day -y
```

Enabling the module also installs a locked `date_all_day` date format (pattern `Y-m-d`),
which is offered as the default date-only format on the formatters. There is no settings page
to visit — the widget and formatters are now available on your Date range fields. See the
[overview](../index.md#how-to-use-it) for how to apply them.
