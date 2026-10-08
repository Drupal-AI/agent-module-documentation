# Installation

## Requirements

- **Drupal 10 or newer** (`core_version_requirement: >=10`).

There are no contrib‑module or PHP‑library dependencies. To override the weight of a
QueueWorker you don't maintain, the optional **Queue UI** module is recommended.

## Install with Composer

From the project root:

```bash
composer require drupal/queue_order -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/queue_order -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en queue_order -y
```

## Verify it worked

There is no admin page to check. Confirm the module is enabled at **Extend**
(`/admin/modules`), then add a `weight` to one of your QueueWorker annotations and
run cron (`drush cron`) to see queues processed in the order you set. Remember that
weight controls order during cron, not how much time each queue gets.
