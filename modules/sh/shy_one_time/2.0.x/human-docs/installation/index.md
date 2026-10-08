# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The **CrawlerDetect** PHP library, which does the bot detection. When you install
  the module with Composer, this library is pulled in for you — so there are no
  Drupal modules required beyond core.

## Install with Composer

Installing via Composer is recommended, because it brings in the CrawlerDetect library
automatically. From the project root:

```bash
composer require drupal/shy_one_time -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/shy_one_time -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en shy_one_time -y
```

## Verify it worked

The module works immediately with no configuration — CrawlerDetect starts protecting
the reset and one-time login routes as soon as it is enabled. If you want to block
additional User-Agents (for example a specific mail-security appliance), continue to
[Configuration](../configuration/index.md). Note that from now on, requests to the
reset route are logged, so you can check `/admin/reports/dblog` to see which
User-Agents are hitting it.
