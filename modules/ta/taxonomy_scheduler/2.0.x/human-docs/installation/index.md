# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- The contributed **Hook Event Dispatcher** module
  (`drupal/hook_event_dispatcher`) — used for the cron and presave hooks. Composer
  installs it automatically with the command below.
- Core's **Taxonomy** module and the core **Datetime** field module (which provides
  the scheduling date field).

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_scheduler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Hook Event Dispatcher
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_scheduler -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_scheduler -y
```

Enabling the module makes the settings form available but does not add the scheduling
field to any vocabulary yet — you choose the vocabularies on the settings page.
Continue with [Configuration](../configuration/index.md).
