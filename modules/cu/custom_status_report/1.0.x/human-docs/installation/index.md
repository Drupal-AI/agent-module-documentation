# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other contributed modules, and no third‑party Composer or PHP library
  requirements — it depends only on Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_status_report -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_status_report -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_status_report -y
```

## Verify it worked

After enabling, go to **Configuration → System → Custom Status Report**
(`/admin/config/system/custom-status-report`) — you should see the form listing
the available status cards. Toggle one off, save, then open **Reports → Status
report** (`/admin/reports/status`) and confirm the card no longer appears. See
[Configuration](../configuration/index.md) for details.
