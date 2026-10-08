# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drush** (both Drush 8 and Drush 9 are supported) — the module is driven by Drush
  commands.
- Queues to be throttled must have a paired **QueueWorkerInterface**; queues without
  a worker are not supported.

There are no contrib‑module or PHP‑library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/queue_throttle -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/queue_throttle -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en queue_throttle -y
```

## Verify it worked

Confirm the throttle commands are available:

```bash
drush queue-throttle-run some_queue --time-limit=180 --items=10 --unit=minute
```

(Replace `some_queue` with a real queue that has a QueueWorker.) Once a queue is
enabled for throttled processing it no longer runs on the default core cron, so
schedule a cron job to call `drush queue-throttle` on the cadence you need. See the
[overview](../index.md) for the command details.
