# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **PHP 5.6 or newer** (`php >=5.6.0`).
- Core's **Content Moderation** module (`content_moderation`) and core's
  **Datetime** module (`datetime`), both enabled. Drupal pulls these in as
  dependencies when you enable Lightning Scheduler.

There are no third-party Composer or PHP library requirements. Note that the
scheduling fields only appear on entity types that have a Content Moderation
workflow assigned, so you'll want at least one workflow configured to see the
module in action.

## Install with Composer

From the project root:

```bash
composer require drupal/lightning_scheduler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lightning_scheduler -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lightning_scheduler -y
```

Enabling it installs the two scheduling base fields
(`scheduled_transition_date` and `scheduled_transition_state`) on every entity
type that already has a Content Moderation workflow, and it keeps them in sync as
you add or remove workflows later. No submodules ship with this project.

## Verify it worked

Edit a piece of moderated content. Near the moderation-state selector you should
see the "add transition" scheduling interface. If you don't see it, confirm the
content type is actually assigned to a Content Moderation workflow — without one,
the scheduling fields don't exist yet.
