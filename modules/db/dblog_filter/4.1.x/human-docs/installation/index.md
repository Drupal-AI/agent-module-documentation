# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- To filter the **database log**, core's **Database Logging** (`dblog`) module.
- To filter **syslog**, core's **Syslog** (`syslog`) module — DB Log Filter only
  takes over the syslog logger when that module is enabled.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dblog_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dblog_filter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dblog_filter -y
```

DB Log Filter swaps the logger services at container build time, so after enabling
(or later disabling) the module you should rebuild caches with `drush cr`. Enabling
it changes nothing about what gets logged until you configure filtering — by
default everything still logs. See [Configuration](../configuration/index.md).

## Verify it worked

Visit `/admin/reports/dblog-filter` as a user with the **Access site reports**
permission. You should see the **DB Log Filter** settings form, with separate
sections for the database log and (if Syslog is enabled) syslog.
