# Installation

## Requirements

Breadcrumbs Visibility needs:

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Block**, **Node**, and **System** modules — all part of a standard
  Drupal install and enabled automatically as dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/breadcrumbs_visibility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/breadcrumbs_visibility -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en breadcrumbs_visibility -y
```

On enable, the module:

- Adds the `display_breadcrumbs` boolean field to all nodes.
- Backfills every existing **published** node to "breadcrumbs on" (value `1`), so
  your live pages look exactly as they did before.
- Sets its own module weight high (99) so it runs after modules such as
  Scheduler.

## After enabling

1. Go to **People → Permissions** and grant **Administer breadcrumbs visibility
   config** to the roles that should be allowed to toggle breadcrumbs.
2. Edit any node and look for the **Page display options** group in the sidebar
   to start turning breadcrumbs off where you want.

There is no separate settings form — see the [overview](../index.md) for how the
per-node and per-content-type controls work.
