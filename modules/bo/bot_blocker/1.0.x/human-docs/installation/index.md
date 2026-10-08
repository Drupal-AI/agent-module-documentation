# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no third-party Composer or PHP library requirements, and no other module
dependencies.

> **Optional, for metrics.** Bot Blocker records simple blocked/allowed request
> counters and a "last blocked request" record **only when a fast cache backend
> (Memcache or Redis) is present**. With the default database cache, no metrics
> are recorded — blocking still works, you just get no counters. Install and
> configure Memcache or Redis separately if you want those numbers.

## Install with Composer

From the project root:

```bash
composer require drupal/bot_blocker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bot_blocker -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bot_blocker -y
```

Once enabled, blocking is active on all main requests using the default banned
substrings. Review and tune the settings before relying on it — see
[Configuration](../configuration/index.md).
