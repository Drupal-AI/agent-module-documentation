# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Automated Cron** (`automated_cron`) module — this is the only
  dependency, and Drupal enables it automatically as a dependency when you turn on
  this module.

There are no third-party Composer or PHP library requirements.

> **Development use only.** This module is a debugging aid — install it in
> development and testing environments, not on production sites.

## Install with Composer

From the project root:

```bash
composer require drupal/cron_last_run_manipulate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cron_last_run_manipulate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cron_last_run_manipulate -y
```

Drupal will enable core's Automated Cron alongside it if it isn't already on.

## Verify it worked

Log in as an administrator, grant yourself the module's permission at **People →
Permissions**, then open its admin interface. You should be able to view and change
the last-cron-run timestamp. See "How to use it" in the [overview](../index.md).
