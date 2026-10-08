# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Two core modules, enabled automatically as dependencies:
  - **Datetime Range** (`datetime_range`) — for the optional start/end schedule.
  - **Options** (`options`) — for the severity selector.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/site_alert -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/site_alert -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site_alert -y
```

Or enable **Site Alert** from **Extend** (`/admin/modules`). Datetime Range and
Options are enabled at the same time if they are not already on.

There are no submodules. After enabling, continue to
[Configuration](../configuration/index.md) to create an alert and place the
block — nothing shows to visitors until you do both.
