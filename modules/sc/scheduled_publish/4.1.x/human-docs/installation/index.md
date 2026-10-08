# Installation

## Requirements

- **Drupal 9.5, 10.2, or 11** (`core_version_requirement: ^9.5 || ^10.2 || ^11`).
- **PHP 7.4 or newer** (`php: >=7.4`).
- These core modules, all declared as dependencies and enabled automatically:
  **Content Moderation** (`content_moderation`), **Workflows** (`workflows`), and
  **Datetime** (`datetime`).

Beyond installing the module, you must have a **Content Moderation workflow**
covering the entity type and bundle you want to schedule — the scheduled entries
transition an entity between that workflow's states, so the states have to exist
first. A working cron is also needed for transitions to fire on their own.

There are no third-party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/scheduled_publish -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scheduled_publish -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scheduled_publish -y
```

This also enables Content Moderation, Workflows, and Datetime if they are not
already on. Next, set up a moderation workflow (if you don't have one) and add a
**Scheduled publish** field to a bundle — see
[Configuration](../configuration/index.md).

There are no submodules. The module does ship optional config for an **Ultimate
Cron** job (`ultimate_cron.job.scheduled_publish_cron`); install the Ultimate Cron
contrib module if you want finer control over when scheduled transitions run.
