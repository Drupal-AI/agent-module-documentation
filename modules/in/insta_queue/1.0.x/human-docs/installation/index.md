# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- **Drush v12 or newer** — the module relies on Drush for worker and scheduler
  operations.
- The **Insta Queue Scheduler** program, installed and running alongside your
  Drupal site. This is a separate daemon, not a Drupal module, and it is what
  makes realtime processing happen. Whether you can run it depends on your hosting
  environment (you need to be able to run a persistent process and open a TCP or
  Unix socket).

## Install with Composer

From the project root:

```bash
composer require drupal/insta_queue -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/insta_queue -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en insta_queue -y
```

## Configure the scheduler connection

There is no admin form for this. Add the scheduler connection address to your
**`settings.php`** under `insta_queue.scheduler_connection` — either a TCP address
or a Unix socket path, matching how you run the Insta Queue Scheduler program.
Because this value comes from trusted server configuration rather than from web
requests, it is not exposed to site visitors.

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`). Then, with the
scheduler program running and the connection configured, add an item to a queue
and confirm it is processed almost immediately rather than waiting for cron. The
provided Drush commands can be used to check worker and scheduler operations.
