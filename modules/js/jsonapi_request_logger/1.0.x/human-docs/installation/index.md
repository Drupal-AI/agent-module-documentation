# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Drupal core's **JSON:API** module enabled — the whole point of the module is to
  log traffic to that API, so you will already have it on if you are using
  JSON:API.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_request_logger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_request_logger -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_request_logger -y
```

## Verify it worked

The module ships with no admin menu entry of its own, so confirm it is on with a
quick status check:

```bash
drush pm:list --status=enabled | grep jsonapi_request_logger
```

Then head to [Configuration](../configuration/index.md) to switch logging on and
decide which request tokens to record — nothing is logged until you enable it and
set a log format. Review results under **Reports → Recent log messages**.
