# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Dashboards** module (`dashboards`) — this is a hard dependency, because
  Dashboards Extra adds blocks *to* the dashboard framework it provides. Composer
  pulls it in automatically.
- No third‑party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dashboards_extra -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Dashboards
module and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dashboards_extra -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dashboards_extra -y
```

This also ensures the base **Dashboards** module is enabled (enable it explicitly
with `drush en dashboards -y` if needed).

## Verify it worked

Edit a dashboard in the **Dashboards** module and confirm the new blocks — such as
the **multi‑statistics** block and the content / block / media / user statistics
blocks — are available to add. Place one and save to see the metrics appear. See
the [overview](../index.md#how-to-use-it) for details.
