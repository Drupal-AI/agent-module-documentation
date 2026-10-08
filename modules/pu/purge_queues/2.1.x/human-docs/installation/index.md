# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **PHP 7.2 or newer**.
- The **Purge** module (`drupal/purge` `^3`) — this is the whole point of the
  module, so it must be installed and enabled. Composer pulls it in automatically.

You'll typically already have Purge set up with a purger for your CDN or reverse
proxy (Varnish, Fastly, etc.) before adding this module.

## Install with Composer

From the project root:

```bash
composer require drupal/purge_queues -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update shared
dependencies — including the Purge module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/purge_queues -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en purge_queues -y
```

Enabling the module only makes the new queue plugins *available* — it does not
change your active queue. To start using deduplication you must select one of the
new queues on Purge's settings page; see the
[main guide](../index.md#how-to-use-it). The queue's database table is created
automatically the first time the queue is used.

This module ships no submodules.
