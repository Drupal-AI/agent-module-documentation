# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Cron** must be running if you plan to use a delayed export (delays are applied
  on the next feasible cron run).

There are no module dependencies and no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_auto_export -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_auto_export -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_auto_export -y
```

## Verify it worked

Go to **Configuration → Development → Config Auto Export**
(`/admin/config/development/config_auto_export`). You should see the settings form.
Configure it (see [Configuration](../configuration/index.md)), then make a small
configuration change and confirm it is written to your chosen export directory.
