# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No other module dependencies.
- A **heartbeat.sh account** with a beat created, and **Drupal cron running on a
  reliable schedule** (see Configuration) — without regular cron the module has
  nothing to ping.

> **Not security-advisory covered.** This project is not covered by Drupal's
> security advisory policy. Review it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/heartbeat_sh -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/heartbeat_sh -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en heartbeat_sh -y
```

## Verify it worked

Log in as a user with the **`administer heartbeat_sh`** permission and open
**Configuration → Web services → heartbeat.sh**
(`/admin/config/services/heartbeat_sh/settings_form`). If the settings form
appears, the module is installed. Fill it in as described in
[Configuration](../configuration/index.md), then run cron once
(`drush cron`) and check that heartbeat.sh registers the beat.
