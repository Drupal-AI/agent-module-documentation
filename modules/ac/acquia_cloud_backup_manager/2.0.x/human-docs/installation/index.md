# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- A site hosted on **Acquia Cloud** — this module is only useful there, because it
  prunes backups through the Acquia Cloud API. (On Acquia Cloud Site Factory, use
  `acsf_backup_manager` instead.)
- **Acquia Cloud API credentials** (an API token and secret). Generate an API key
  per Acquia's documentation, and plan to supply it as environment variables — see
  [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_cloud_backup_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/acquia_cloud_backup_manager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_cloud_backup_manager -y
```

Enabling the module does **not** start deleting anything — cron deletion is opt-in.
Next, configure credentials (as environment variables), pick a retention rule, and
turn on cron in [Configuration](../configuration/index.md).
