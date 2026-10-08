# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).

There are no module or third-party library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/cron_timing -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cron_timing -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cron_timing -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → System → Cron Timing**
(`/admin/config/system/cron_timing`). You should see the form with a field for your
custom intervals (pre-filled with the `300,900` defaults). Add an interval, save,
then check that it appears on **Configuration → System → Cron** — see
[Configuration](../configuration/index.md).
