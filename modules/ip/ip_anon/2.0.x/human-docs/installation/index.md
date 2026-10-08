# Installation

## Requirements

- **Drupal 11.1 or 12** (`core_version_requirement: ^11.1 || ^12`).
- Cron must be running on the site — scrubbing happens on each cron run (you can
  also trigger it manually with Drush; see [Configuration](../configuration/index.md)).

There are no other module dependencies and no third-party Composer or PHP library
requirements. The module *integrates* with several optional modules when they're
present (comment, dblog, Commerce, Login History, Simple Access Log, Tether Stats,
Visitors, Voting API, Webform) — each simply adds its table to the scrub list — but
none of them are required.

## Install with Composer

From the project root:

```bash
composer require drupal/ip_anon -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ip_anon -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ip_anon -y
```

There are no submodules. Importantly, enabling the module does **not** start
scrubbing on its own: the retention policy ships set to **Preserve** (off) by
default, so nothing is anonymized until you switch it on. Head to
[Configuration](../configuration/index.md) to set your policy and per-table
retention periods.
