# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- A working **cron** — the size check and the purge only run on cron, so the trimming
  is only as regular as your cron schedule.
- No other modules, third-party Composer packages, or PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/cache_purge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cache_purge -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cache_purge -y
```

After enabling, set the size limit on the settings form — see
[Configuration](../configuration/index.md).
