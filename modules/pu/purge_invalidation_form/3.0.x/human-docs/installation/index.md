# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- **PHP 8.3 or newer** (`php: ^8.3`) — note the fairly recent PHP requirement.
- **The [Purge](https://www.drupal.org/project/purge) module, version 3.6 or
  newer** (`drupal/purge:^3.6`). Composer installs it for you if it isn't already
  present.

You also need, in practice, **at least one Purge *purger* enabled** — a contrib
purger for your cache layer (for example a Varnish or CDN purger). Purge and this
module don't clear anything on their own; the purger does the actual work, and it
also determines which invalidation types show up in the form.

There are no other third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/purge_invalidation_form -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install or update Purge and
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/purge_invalidation_form -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en purge_invalidation_form -y
```

Enabling the module also registers its **Invalidation Form Processor** in Purge (it
is enabled by default). This processor authorises the direct invalidations; if it is
ever missing, the form reports that it needs to be added.

## Right after enabling

Grant the restricted **Purge invalidation** permission
(`purge_invalidation_form purge invalidation`) to the roles that should be able to
clear cache — at *People → Permissions*. Then the form is available at
*Configuration → Development → Performance → Purge invalidation form* (see the
[overview](../index.md#how-to-use-it)).

This module has no submodules and no separate settings page — the invalidation form
is the whole interface.
