# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`).
- The **Scheduler** module (`scheduler`) — Advanced Scheduler extends it.
- The **Workbench Moderation** module (`workbench_moderation`), which provides the
  moderation states and transitions the schedules target.

Drupal will require these dependencies to be present before it lets you enable the
module. Install and configure Scheduler and your moderation workflow first.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_scheduler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and will pull in Scheduler and Workbench Moderation if
they are not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/advanced_scheduler -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_scheduler -y
```

Enabling it also enables Scheduler and Workbench Moderation if they are not
already on. Once active, the scheduling fields on your content can target
moderation states — see the [overview](../index.md#how-to-use-it) for how to
schedule a transition.
