# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no module or third-party library dependencies — the base module is
self-contained.

## Install with Composer

From the project root:

```bash
composer require drupal/cron_service -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cron_service -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cron_service -y
```

The base module has no UI or configuration; it simply activates the service
collector so any service tagged `cron_service` runs on cron. See "How to use it" in
the [overview](../index.md) for the developer workflow.

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Cron Service UI** | `cron_service_ui` | An admin interface for viewing and managing the cron services registered on your site. |

Enable it only if you want that management UI:

```bash
drush en cron_service_ui -y
```

## Verify it worked

After enabling, register a small test cron service (a class implementing
`CronTaskInterface`, tagged `cron_service`) and run cron with
`drush cron`. Your task's `execute()` should be invoked. If you enabled Cron Service
UI, the task should also appear in its management screen.
