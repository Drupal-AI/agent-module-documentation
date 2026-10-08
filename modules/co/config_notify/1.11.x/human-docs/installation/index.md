# Installation

## Requirements

Config Notify is light on dependencies. It needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Configuration Manager** (`config`) module — Drupal enables it automatically as
  a dependency when you turn on Config Notify.

There are no third‑party Composer or PHP library requirements. To actually deliver
notifications you will of course need a working mail setup (for email) and/or a Slack
incoming webhook (for Slack) — see [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/config_notify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_notify -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_notify -y
```

## Verify it worked

Log in as a user with the **Synchronize configuration** permission and visit
`/admin/config/development/configuration/notify`. If the Config Notify settings form
loads, the module is installed. From here, head to
[Configuration](../configuration/index.md) to choose a notification channel and decide how
the drift check is triggered.
