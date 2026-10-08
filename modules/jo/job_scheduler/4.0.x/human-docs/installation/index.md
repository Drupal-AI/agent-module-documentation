# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).

There are no module dependencies and no third‑party PHP or Composer library
requirements. Job Scheduler relies on Drupal's core **cron** system to run
scheduled jobs, so make sure cron runs regularly on your site.

## Install with Composer

From the project root:

```bash
composer require drupal/job_scheduler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/job_scheduler -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en job_scheduler -y
```

Often Job Scheduler is enabled automatically as a dependency of another module (such
as Feeds) that builds on its scheduling API.

## Submodule

Job Scheduler ships one optional submodule, **Job Scheduler Waiting**
(`job_scheduler_waiting`), which provides a long‑running worker for jobs that need
to wait indefinitely. Enable it only if a module you use calls for it:

```bash
drush en job_scheduler_waiting -y
```

## After enabling

Make sure cron runs regularly, and optionally tune how many jobs each cron run
processes on the settings form — see the [main page](../index.md).
