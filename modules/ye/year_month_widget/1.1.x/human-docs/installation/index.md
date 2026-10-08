# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Datetime** module (`datetime`) enabled — this is what provides the
  Date/time fields the widget works on. It's part of core; enable it if you haven't
  already.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/year_month_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/year_month_widget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en year_month_widget -y
```

If core's Datetime module isn't on yet, enable it too:

```bash
drush en datetime -y
```

There are no submodules and no settings page. Once enabled, the **Year/month** widget
is available to pick on any Date/time field's **Manage form display** tab — see the
[overview](../index.md#how-to-use-it).
