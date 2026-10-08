# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Datetime Range** module (`datetime_range`) — the scheduler field builds
  on it. Enabled automatically as a dependency.
- A working **cron** run — schedules only fire when cron runs, so make sure cron is
  set up (see below).

There are no third‑party Composer or PHP library requirements.

**Optional:** the contrib [Plugin](https://www.drupal.org/project/plugin) module
(`drupal/plugin`) is suggested — it provides the Plugin API UI referenced by the
module's plugin type, but it isn't required for normal use.

## Install with Composer

From the project root:

```bash
composer require drupal/scheduler_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/scheduler_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scheduler_field -y
```

This also enables the `datetime_range` dependency if it isn't already on.

## Make sure cron runs

Scheduled actions are executed on cron. If cron doesn't run, schedules never fire.
Run it manually with `drush cron`, rely on Drupal's built‑in cron, or install a
cron module (Ultimate Cron / Simple Cron) to run it on a tight schedule — the
closer your cron interval, the more precise your scheduled publishing will be.

## Next steps

There's no configuration page — add a **Scheduler field** to a content type via
**Manage fields** and configure it as described in
[the overview](../index.md#how-to-use-it).
