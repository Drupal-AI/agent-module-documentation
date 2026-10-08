# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The contrib **Scheduler** module (`drupal/scheduler`, `^2.1`).
- Core's **Content Moderation** module (`content_moderation`).
- Core's **Options** module (`options`).

Drupal will enable the two core modules automatically as dependencies, but you need
to install Scheduler with Composer if it is not already present.

## Install with Composer

From the project root, requiring both this module and Scheduler:

```bash
composer require drupal/scheduler_content_moderation_integration drupal/scheduler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (Composer will resolve Scheduler on its own too, but listing
it makes the intent explicit.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scheduler_content_moderation_integration -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scheduler_content_moderation_integration -y
```

Enabling it also enables Scheduler, Content Moderation, and Options if they are not
already on.

## Next step

There is no configuration form. Continue with
[How to use it](../index.md#how-to-use-it) on the overview page to put a bundle under
a workflow, turn on scheduling, and schedule your first moderation transition.
Remember that scheduled jobs run on **cron**, so make sure cron is configured.
