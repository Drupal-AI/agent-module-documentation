# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **User** module (`user`), which every standard Drupal site already has.

There are no third-party PHP libraries to install. To use the `dr` CLI commands you need
Drupal core's new `dr` command-line tool; the same commands are also available through
Drush.

Note: this is an early **alpha** release and the project is **not covered by Drupal's
security advisory policy** — worth weighing before relying on it in production. The checks
themselves are strictly read-only and never modify site config or content.

## Install with Composer

From the project root:

```bash
composer require drupal/site_doctor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/site_doctor -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site_doctor -y
```

## Verify it worked

Visit **`/admin/reports/site-doctor`**. On a fresh install the report may be sparse until
the first scheduled check-up runs on cron; you can trigger a run immediately from the
command line via the module's `dr` or Drush commands, then reload the report to see the
first set of findings and the start of its history.
