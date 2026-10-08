# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Database** and **Mail** systems (part of core) — used for query
  monitoring and email alerts respectively.
- To send Slack alerts, a **Slack incoming‑webhook URL** (created in your Slack
  workspace); you'll paste it into the settings form.

There are no third‑party Composer packages or PHP libraries to install.

> **Heads up:** this project is **not covered by Drupal's security advisory
> policy**, and it exposes an intentionally anonymous telemetry endpoint (see the
> [main guide](../index.md)). Review those points before enabling it in
> production.

## Install with Composer

From the project root:

```bash
composer require drupal/real_time_performance_monitor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/real_time_performance_monitor -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The module's machine name is `realtime_performance_monitor` (note: no underscore
between "real" and "time"):

```bash
drush en realtime_performance_monitor -y
```

## Verify it worked

Go to **Configuration → Development → Real-time Performance Monitor**
(`/admin/config/development/real-time-performance-monitor`). You should see the
settings form with the master switch, thresholds, and notification options. Set it
up in [Configuration](../configuration/index.md), then browse the site and check
your logs (**Reports → Recent log messages**) for performance alerts.
