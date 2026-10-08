# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 8.1** or later.
- **Drush** — this module is a Drush command, so Drush must be installed.

There are no other module dependencies and no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/drush_queue_run_all -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drush_queue_run_all -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drush_queue_run_all -y
```

## Verify it worked

Confirm Drush can see the command:

```bash
drush help queue:run-all
```

If the help text appears (listing `--daemon`, `--memory-limit` and the other
options), the module is installed and ready. Running `drush queue:run-all` will
then process any items waiting in your site's queues.
