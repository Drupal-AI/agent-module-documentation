# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Token** (`token`), **User** (`user`), and **System** (`system`)
  modules. Token is pulled in by Composer; User and System are always part of
  core.
- A working **cron** — the module checks maintenance-mode duration on each cron
  run, so alerts are only as timely as your cron schedule.

## Install with Composer

From the project root:

```bash
composer require drupal/maintenance_notifier -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Token module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/maintenance_notifier -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en maintenance_notifier -y
```

## Verify it worked

Open the Maintenance Notifier settings form and set a recipient and a short
threshold (see [Configuration](../configuration/index.md)). You can then trigger
the check on demand rather than waiting for cron:

```bash
drush maintenance-notifier:check
# or the short alias:
drush mnc
```

Put the site into maintenance mode, wait past your threshold, run the command,
and confirm the alert email arrives.
