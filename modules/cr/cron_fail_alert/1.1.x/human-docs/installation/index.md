# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- **PHP 8.1 or higher**.

There are no module or third-party library dependencies — the module is
self-contained.

## Install with Composer

From the project root:

```bash
composer require drupal/cron_fail_alert -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cron_fail_alert -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cron_fail_alert -y
```

That's all it takes. The module starts monitoring cron immediately using its
default settings (check every 15 minutes, alert after 20 minutes of no successful
cron).

## Verify it worked

Log in as an administrator and go to **Configuration → System → Cron → Cron Fail
Alert settings** (`/admin/config/system/cron-fail-alert`). You should see the
settings form with its monitoring and email-notification sections. Adjust the
tolerance and recipient there — see [Configuration](../configuration/index.md).
