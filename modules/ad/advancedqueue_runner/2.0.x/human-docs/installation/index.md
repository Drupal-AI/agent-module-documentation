# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- The **Advanced Queue** module (`advancedqueue`) — this is a hard dependency and
  is what actually manages the queues. Composer will pull it in for you.

There are no additional PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/advancedqueue_runner -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including the Advanced Queue module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/advancedqueue_runner -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advancedqueue_runner -y
```

Enabling Advanced Queue Runner also enables Advanced Queue if it is not already
on. Once enabled, queued jobs are processed in the background — there is no
required configuration.
