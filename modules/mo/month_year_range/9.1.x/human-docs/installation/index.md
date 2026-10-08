# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Datetime Range** module (`datetime_range`) — this is the only
  dependency, and Drupal enables it automatically when you turn on Month Year
  Range. (Datetime Range in turn relies on core's Datetime module.)

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/month_year_range -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/month_year_range -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en month_year_range -y
```

Enabling the module makes its two widgets — **Month Year Range** and **Month Year
Datetime** — available. It changes nothing until you select one of them for a
date field on a bundle's *Manage form display*.

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep month_year_range
```

Then create (or edit) a date or date-range field, go to **Manage form display**,
and confirm the Month Year widgets appear in the widget dropdown for that field.
See the "How to use it" section on the [overview page](../index.md) for the full
walkthrough.
