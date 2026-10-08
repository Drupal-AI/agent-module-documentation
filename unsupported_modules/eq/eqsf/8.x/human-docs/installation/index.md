# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Entityqueue** module (`entityqueue`) — this module schedules membership of
  entity queues, so Entityqueue must be present.
- **Cron** — either regular Drupal cron runs or a scheduler such as the **Ultimate
  Cron** module. The scheduled add/remove happens on cron, so queue changes take
  effect at the next cron run at or after each scheduled time.

## Install with Composer

From the project root:

```bash
composer require drupal/eqsf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eqsf -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eqsf -y
```

This also enables Entityqueue if it is not already on.

## Verify it worked

1. Create an entity queue at **Structure → Entity Queues**.
2. Add an **Entity Queue Scheduler** field to a content type.
3. Create a piece of content, set a queue and a near-future add date in the field,
   and save.
4. Run cron (`drush cron`) after that time and confirm the content has joined the
   queue.
