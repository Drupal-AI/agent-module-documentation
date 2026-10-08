# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- No other modules are required, and there are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_layers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_layers -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_layers -y
```

## Set the permission

Config Layers provides its own permission for managing layers. Because layer
operations rewrite active configuration, grant it only to trusted site builders at
**People → Permissions** (`/admin/people/permissions`).

## Verify it worked

Go to **Configuration → Development → Configuration layers** and confirm you can add
a layer, or run `drush config-layers:status` to confirm the Drush command set is
available. See [Configuration](../configuration/index.md) for creating layers and
the [overview](../index.md) for the Drush import/export/synchronize workflow.
