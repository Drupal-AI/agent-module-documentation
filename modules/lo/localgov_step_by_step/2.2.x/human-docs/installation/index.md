# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **LocalGov Core** (`localgov_core`) — this module is part of the LocalGov Drupal
  distribution and expects its shared framework.
- **Preview Link** (`preview_link`) — used to share unpublished journeys with
  reviewers.
- Core **Path**, **Text** and **Views** modules.

There are no additional third-party Composer or PHP library requirements. This
module is designed for a LocalGov Drupal site; it works best there.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_step_by_step -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install LocalGov Core,
Preview Link and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_step_by_step -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_step_by_step -y
```

LocalGov Core, Preview Link, Path, Text and Views are enabled as dependencies.
Enabling the module installs the two content types (overview and step page), the
step-navigation view, and grants the default LocalGov editor/author permissions.

## Optional integrations

If **LocalGov Services Navigation** or **LocalGov Topics** are present, the module
wires in optional fields so journeys can be attached to a service or classified by
topic. If **Scheduled Transitions** is in use, the relevant scheduled-transition
permissions are granted too. None of these are required — they are picked up
automatically when those modules are installed.

There is no settings page — see [Configuration](../configuration/index.md) for
building a journey and placing the block.
