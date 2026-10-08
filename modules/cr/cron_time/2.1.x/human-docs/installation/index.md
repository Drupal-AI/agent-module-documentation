# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).

There are no module or third-party library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/cron_time -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cron_time -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cron_time -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → System → Cron**
(`/admin/config/system/cron`). You should see the custom cron-time control the
module adds there. Set your interval and save — see
[Configuration](../configuration/index.md).
