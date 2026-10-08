# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[Scheduler](https://www.drupal.org/project/scheduler)** module
  (`scheduler`) — this module runs Scheduler's cron, so Scheduler must be present
  and enabled.

There are no third-party PHP libraries to install.

> **Heads up on security coverage:** this module is *not* covered by Drupal's
> security advisory policy. That is fine for most sites, but worth knowing if your
> organisation requires security-team coverage for every contrib module.

## Install with Composer

From the project root:

```bash
composer require drupal/scheduler_request_cron -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scheduler_request_cron -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scheduler_request_cron -y
```

Once enabled the module works immediately with its defaults (a 5-minute minimum
interval and logging off). To adjust those, see
[Configuration](../configuration/index.md).
