# Installation

## Requirements

Log Stdout is self-contained:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No third-party Composer or PHP library requirements, and no other contrib
  modules. It registers a logger service using core's Logging API.

It is most useful in a containerised environment (Docker, Kubernetes, or similar)
where the platform collects logs from the process's stdout/stderr, but it will run
anywhere.

## Install with Composer

From the project root:

```bash
composer require drupal/log_stdout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/log_stdout -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en log_stdout -y
```

Logging to stdout begins immediately with the default format and severity. See the
[overview](../index.md#how-to-use-it) to tune the format, the stderr behaviour, and
the minimum severity.

## Verify it worked

Trigger a log event (for example run cron, or lower the severity to Debug and load
a page) and watch the container's output — for example `docker logs -f
<container>` or `ddev logs -f`. You should see Drupal log lines appear on the
stream. You can also confirm the settings form loads at **Configuration →
Development → Log Stdout** (`/admin/config/development/log_stdout`).
